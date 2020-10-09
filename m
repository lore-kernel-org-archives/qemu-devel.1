Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B7BC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C55922225D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfZB+HGF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55922225D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQugX-0000Ix-Ao
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 11:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQufy-0008L6-LP
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:51:22 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:35278)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQufx-0008SH-4K
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:51:22 -0400
Received: by mail-wr1-x443.google.com with SMTP id n15so10812001wrq.2
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 08:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vUw25a+JF28NDJn2+bNEzpLoUNqu5DI1Lon8tieP4jc=;
 b=kfZB+HGFlYlXiei/c2tiqXL7S6OO2l7GXQ4Nbg4E9BSh+PefJpARLoVoLIEH8j12wI
 PAvjJXLiUu9Sx4GZSNIeUwPsnVP+Mr0eChtF0eQi4Hj5DlUlWBDvmN1pu/tRbJ6uwudv
 2h/ycrS5wRCdfxnX/c860of7ZeQwQkPNSzKnK5+32Mfdfo+42f5DLDjLIKaEDqkdwVOE
 JUY72lgazZ6BcN0toA75NJLnt4svB+PRM5WPob6AicDlXXFkzWl87PhsTfIE5xks8vP1
 HGWiLEGr2b6mADZT7roE2PpNy/Ofr9s+Idat7WDg5+f7ecWtzO2jfn0962SYHIerkkz1
 Cd0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vUw25a+JF28NDJn2+bNEzpLoUNqu5DI1Lon8tieP4jc=;
 b=h/zbqDK3PlTC2JJrF2yW51jBml6kdBQ0I5QZS5LBEmzk0hnieaPY9l/s4f0Ub7sGr9
 jG9jPzaJ0Ruq8aKNL8s2obee3aPmGTIvCrFG5KXd6tU2qaUJIHC3jwQTWNf2O8Y/CKvq
 njhk/lcxYBJ1g/0GSXz8/iPxMyqw6+ZcfUJqM6wfmFkOrDebRGUoCsUZSUEf/IFl9SOY
 3wFklDu3L1d5HvKBW5GdOcW5RGwKWBaVor1Q1+Mb3/rb1RXMdYhQokqIex4uxWoMTKgT
 ABjB6ppH/h5WeRDcTZLR8rAiIxMzWvCWj3IGVBpKIayK8Z8aHZJk7bcxsxJy2ZnIOXqo
 WI4w==
X-Gm-Message-State: AOAM532wi7wN9fFumaWEfP2zkTvv1kBUYhfop/LMXKzvg5Zz8ZwIqcER
 5PM6jbti8dTgcAg+vf9WSDA=
X-Google-Smtp-Source: ABdhPJz4K/oCUeF2NhUD/KwP4Va2A37AiyoyaEtypkKKmeJOLCyy7jSqEBZil0LOTRQHhqWHI5fPGw==
X-Received: by 2002:adf:f44d:: with SMTP id f13mr11424377wrp.385.1602258679529; 
 Fri, 09 Oct 2020 08:51:19 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id x64sm12415748wmg.33.2020.10.09.08.51.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 08:51:18 -0700 (PDT)
Subject: Re: [RFC PATCH v2 0/3] target/mips: Report unimplemented cache()
 operations
To: qemu-devel@nongnu.org
References: <20200813181527.22551-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <012b6a7a-09de-977d-d57f-aaf8d83140fe@amsat.org>
Date: Fri, 9 Oct 2020 17:51:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200813181527.22551-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.208,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 8:15 PM, Philippe Mathieu-Daudé wrote:
> Few patches to improve the handling of the 'cache' opcode.
> 
> I'm not sure why helper_cache() is generated for user-only mode.
> 
> v1 was:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg727959.html
> Supersedes: <20200806122612.17167-1-f4bug@amsat.org>
> 
> Philippe Mathieu-Daudé (3):
>    target/mips/op_helper: Convert multiple if() to switch case
>    target/mips/op_helper: Document Invalidate/Writeback opcodes as no-op
>    target/mips/op_helper: Log unimplemented cache opcode

Thanks, added to mips-next (addressing Richard comments).

