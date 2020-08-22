Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75E8C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 20:03:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74FB32072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 20:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cW8y6f3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FB32072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9ZjL-0005A8-PI
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 16:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9ZiT-000464-Hn; Sat, 22 Aug 2020 16:02:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9ZiS-0002Wj-7A; Sat, 22 Aug 2020 16:02:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id y3so4976804wrl.4;
 Sat, 22 Aug 2020 13:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WJSIt9wu4//KOk8axXvaYddG5Qq66TWeoXqzZPNJ3u4=;
 b=cW8y6f3Y22ZvjZTqYGQeH1FxUARtqSyvwIy/8nuFtGiX8u3omaqYjyBsGICbJ3ro4r
 SpDg6ch5M+L/Jv+jybsnE6cbMmEw51Vo+U5bKUBW/XAz06ciZB9RkyOiVo/9Yr1wE42D
 6YaW2rKMiI9BcHcYTznlLGeIItdwwj+CzlMHsbY78oMmu6q93x0yL0qc0Tes3VaK8jVv
 cnFdcx6yF5nJOEl8fH5hX2YVo+ZmTfoeJLQeafyRm+54KvGbIIXVa/gKisfJ+wnxudu7
 qAKEc0t1xGoGmb8BqJdU5xel82xaAeNxdGmyNtr7Ws97qUvcUwIv3LwP1S85aQpr1/4k
 13wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WJSIt9wu4//KOk8axXvaYddG5Qq66TWeoXqzZPNJ3u4=;
 b=rCOv7wlGI2ONyXja1ugTNwjUFrqSrKUMc2ZNtI1SIfxzStMuNyar1M2+MMKuM31bk+
 RM3dFdDJdaFGqhQHicfWt6yj1g6WPEpJCumkNMpp2OTHLjSdzlQxaToCR8nozHMCZEut
 I/vsUErNy0hOkzws/sNQXdg5HxgIAOzHFbsYUnD0A8V416AacnFOvwiZ0tnoL7LsfvXZ
 GkM0UIMQ8QyBJc9s1Ge/Pryf8SYEM+1CycXR91x85X1IRNPeNR4T/jE6q+iOKtNE/Mog
 G20TSfqIBJ+Ul1BQWxvt7O7THoMOpY4RSMySANq1rbRUEgn2lvCFEHx8gKqEzD9VX2hp
 5VhQ==
X-Gm-Message-State: AOAM532C3qs017PGBWTvU54nh5JmdpoXMY2QcH1f1inEfqYU4zJ3NwwE
 ADc48Bx7u+12xgyhY0mWqvE=
X-Google-Smtp-Source: ABdhPJxOVSkPeaJbZ/K6JGuwnIqssMnU+qOLtYmiURiWwNWnHub9I4E0uYhNmDi1TWN/XpeGJRo+GA==
X-Received: by 2002:adf:e98c:: with SMTP id h12mr8027184wrm.3.1598126533742;
 Sat, 22 Aug 2020 13:02:13 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id r22sm13276500wmh.45.2020.08.22.13.02.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Aug 2020 13:02:13 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] hw/misc/unimp: Improve how offset/value are
 displayed
To: qemu-devel@nongnu.org
References: <20200812190206.31595-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1ccf070b-7abd-ebfd-2788-92a81b4fc8fe@amsat.org>
Date: Sat, 22 Aug 2020 22:02:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200812190206.31595-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/12/20 9:02 PM, Philippe Mathieu-Daudé wrote:
> This series aims to ease looking at the '-d unimp' output reported
> by the UnimplementedDevice.
> 
> - read/write accesses are now aligned
> - the value format width uses the access size
> - the offset (address) uses the size of the memory region it belongs
> 
> Series fully reviewed.

ping?

