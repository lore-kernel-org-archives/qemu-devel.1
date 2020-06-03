Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 851C8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F9C7206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 16:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BTwtB6r4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F9C7206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgW4q-0002b9-IB
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 12:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgW3R-0001K0-Jm
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:15:49 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45426)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgW3M-0004FT-D6
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 12:15:49 -0400
Received: by mail-pl1-x642.google.com with SMTP id y11so964173plt.12
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2020 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wMcvYkurwjHiH49izWq+rhG4nDgnT4Ab4MOL7kCO9fw=;
 b=BTwtB6r425RUixSVS+wj2ixhYu/5ZCqnj8esyqpSzCjPio2UPmWlUqCr0L3qc2GVnS
 ZyXAsRzBHjgHkLFFuu43ZinT0qmBymO1J9+zbaZAWkLmM4pGhMFrXwyp0dnkGNlfQ3nP
 XxHsPvCcMFf9Fic2Sb7ocX+2dRGjwm93zlJ1MJzmKvhJceiSV5nNT4V24N95lsuw6qh7
 m87jdxnjcL8qo1LoTiJOQsoxTkCCaBkZy6Ig4K0pQz+Wy2YIVk5DCY41lPa/uXdd4e/i
 vQELnKEx/7O+masEfFo7GmSALZ5SXr2yNekCDOmcV/o+4yxZ6ab1zM0hHTDbbyL7d0mx
 /66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wMcvYkurwjHiH49izWq+rhG4nDgnT4Ab4MOL7kCO9fw=;
 b=RRtwD9WiFkiK40IABcC79LxA3ijo9pygm0uujbOhYcKRylgYIs9FYamd1qTeKNCkR0
 FCDC0+y7A+jEefrPC2R2chM6k5aeBV+THIDaHNReVamJ63U2h1AhqSkUNTgy3+G+39ZS
 Z1AoU738tQjNlmhvrow3Dc5jFmFDgfaUvYQekHjacg5Ui/6E+Q4nMrQFyKykq13lI7PM
 cwXyfRiLm9uqtTMwYKNFmB2keG7RtQsTWdMuNd79pbAB6iGuF8+5SmEP3QLyK560a/v0
 k0U+sKxffuCAegpa4Gvg1w5j6E79NRL/lG9QPrLY1lUUkVKSDjeJW8akBOh6ckkd3jxU
 YJOg==
X-Gm-Message-State: AOAM5300W+z/edn5QzlErFdfKUFvzcBJ2fT+Hzl5Ua+/6pLdDFH8U+Zo
 yM61Uw1oYdUdWbidnhm5MwdReQ==
X-Google-Smtp-Source: ABdhPJz4T295iZqiwAesz6IXs74a4O+6tG9bH43s1uPzDntK5UHzsfQ0mpihgZc4aj2YZ20h8JoQOQ==
X-Received: by 2002:a17:902:b414:: with SMTP id
 x20mr622571plr.32.1591200942666; 
 Wed, 03 Jun 2020 09:15:42 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gm11sm2899198pjb.9.2020.06.03.09.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2020 09:15:41 -0700 (PDT)
Subject: Re: [PATCH 1/3] target/unicore32: Remove unused headers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200603123754.19059-1-f4bug@amsat.org>
 <20200603123754.19059-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b7a23b71-165a-5048-7038-f845402db154@linaro.org>
Date: Wed, 3 Jun 2020 09:15:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603123754.19059-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/20 5:37 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/unicore32/helper.c | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

