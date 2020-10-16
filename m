Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B198C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:48:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF32C20848
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 13:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZUx+IDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF32C20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTQ5U-0002YK-Kz
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 09:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTQ2x-0000nM-52
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 09:45:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43476)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTQ2v-000380-Bh
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 09:45:26 -0400
Received: by mail-wr1-x444.google.com with SMTP id g12so2977526wrp.10
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=u3NPzuw3U1ysbxDrVVm46Y3+aVJ/RvOMe9jJtWXH0ws=;
 b=ZZUx+IDJ3HBOaCZAiSwXo9QiZlFblXoEOwoGNI5wt9/UaAvbJWv9QjAv50oTBdvbkY
 g/ZdA4B588AluwC465UpMjbtImyDOdKJ5k1MSC/6rXEdAfgHzrCWIjnLhiL3HTPotCuX
 Z9GrJAjOWbHGVk+70Sp5B8S+d3mRC1u0XlSGzdI3wmvTemwb72MEzEZBG+7dknPh/Fig
 bNPLMBQnQyOUMRJvA21DFRd/jfhq3p8QAojG1wBqQvufc9C4uMIh7SQOxzu1CvVyVKAD
 LXkBK1Imynwdry2IQ1aTqISywr2VnHrH2JDNAsszNODGsCemXm9NYVVlfC/QYfbvRxkA
 1yTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u3NPzuw3U1ysbxDrVVm46Y3+aVJ/RvOMe9jJtWXH0ws=;
 b=ZjqzHB96ge0LhAGlTYcmBLC/NmImeuOcASukG7F0OnEHGjHQPoW+JKAl6qZTLj6j6+
 sIMbro+n9wqyNlU1k1BrLNuHwiU6lNilISJxXzU04mtKURB/E7meaoVX9Vy1903j+pPO
 xS96QvIqzYhCXVWPKoUwzel1Uh0BkIELQ40nQ2lWhvS++1bJ+xKtXOoVlSiql2Ef/kFt
 JytpmZYFuPyPKUalYt2Ebp8/egQF/+5/KoW4XO6NJt8OXykWN+oPjsJZH3g73rm3OP7d
 ueBXpgIqTMfj/6amVHFTBnYUK5UZdWoxqUDviGKY53Y2PrhteCkNNcNwMX4IILsbor08
 Mi4A==
X-Gm-Message-State: AOAM532FGtp6VijDtE7joC/lz8uPPdqEtXtPysybWfZztp9P2PUD3g0F
 cgphusSKIe90ostNDZUrf7g=
X-Google-Smtp-Source: ABdhPJyLfF2L2sdpF/UJHu6SnzAHxpy1liaJzmH2n+WlWVT7eeNnRe5MfGzAyUFXaIjUkpjYyJRZwg==
X-Received: by 2002:adf:97dd:: with SMTP id t29mr4023932wrb.322.1602855922937; 
 Fri, 16 Oct 2020 06:45:22 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id w4sm2810227wmi.10.2020.10.16.06.45.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 06:45:22 -0700 (PDT)
Subject: Re: [PATCH v2 0/4] MAINTAINERS: Update MIPS sections
To: qemu-devel@nongnu.org
References: <20201013101659.3557154-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <077a3f73-1743-4d2d-a27d-86eb8bcf28ea@amsat.org>
Date: Fri, 16 Oct 2020 15:45:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201013101659.3557154-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.253,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Chen Huacai <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 12:16 PM, Philippe Mathieu-Daudé wrote:
> Volunteer to maintain MIPS TCG.
> As discussed on list, Huacai will likely send a similar patch.
> 
> Few more adjustments (in particular around Boston board).
> 
> Based-on: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
> https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg01974.html
> 
> v2:
> - Squashed Paul email address change with Boston downgrade (Thomas)
> 
> Philippe Mathieu-Daudé (4):
>    MAINTAINERS: Put myself forward for MIPS target
>    MAINTAINERS: Remove duplicated Malta test entries
>    MAINTAINERS: Downgrade MIPS Boston to 'Odd Fixes', fix Paul Burton
>      mail
>    MAINTAINERS: Move MIPS GIC timer files to Boston board section

Thanks, patches 1-3 applied to mips-next.

