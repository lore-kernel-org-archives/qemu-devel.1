Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E41C388F7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 11:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8268206F4
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 11:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFL6B1p2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8268206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbMkm-0000ln-2h
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 06:51:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbMjT-0008IU-Fk; Sat, 07 Nov 2020 06:50:11 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43881)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kbMjR-0007Rj-6Z; Sat, 07 Nov 2020 06:50:10 -0500
Received: by mail-wr1-x443.google.com with SMTP id g12so3928397wrp.10;
 Sat, 07 Nov 2020 03:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Sz3oidMq2981QFuGMaLmZPuGSZXqPTFX+rY/wRTZ7bM=;
 b=ZFL6B1p2ogVOD2fp38M7xuzXpSbyOM44pqnpU8r7tOofzpuXKFBHsjp1Ap3Zy7o7Vb
 yVD3/MSt5bXLvNsh2ICAMptLQ8Cva9TL8Cf1mJkTPOBSjLk+pHhFxNhpJpjEPUmfv1aZ
 jmuKNGcPwnHXjR3A2uQZTI4trbXW19UoR9VtbhPwnWPQ3pv/0Y3VKZnnajSNHJk+CbrL
 s47VS/zQVPN8I/XKDogojPx6umzBtFS61CQQd1y17RJn0wPQvjFXXozUuA71HOQM0cro
 zpt0Vq6rEnv7ZHTG0zawYcJyxWiL2c4NoTqZHoxmFV1Bk147dDkspQYDjQDinUkL5Yv8
 scaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Sz3oidMq2981QFuGMaLmZPuGSZXqPTFX+rY/wRTZ7bM=;
 b=ZUjieLXBy7H1v/jeidp38/N7u83bLcoF/SdvmB+MvHFAI4swqn6omOA7NxiIQrornl
 u0ctUWhqG1LeJLsdisQ5aJsEaEz74fmWBFU/63Usui8jjjerczt129S3zb4oCBXOt0Bw
 63sHFyKmMJbdqxCBWfkAQosrIIXYa/9suwqNpnEJDR4Iv18feq+iFUpTuG5qE5gXo3WL
 q2oj5LFFZwDbPsONHlZKZdTqUJLz4cd9nJBLEOBUXbLXTC/K5zzU8s484ussFL7o0EQ/
 7Ic7Tdn+Ep/D0s6qWUHDJR1V1+f40wD5HgB7aXMuJG8DbmW+VsZkHkOb9mX/Sm18vs0I
 zdZA==
X-Gm-Message-State: AOAM532wgqRoZ0xlqyrgrdkOpLRYU3dFuSL+U32xbsw9VmqS6gE/knsI
 RXisUwvj6wvR0eZRXdQCFEjkUi3/d44=
X-Google-Smtp-Source: ABdhPJxLpr/1pMqxug/dBE58N7LAv20b4pkvyawA6NDMjWA5J6KQyhSZUjPaIRmaY0imcZlrb5WELw==
X-Received: by 2002:adf:dc85:: with SMTP id r5mr8035710wrj.66.1604749806581;
 Sat, 07 Nov 2020 03:50:06 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id g186sm6385321wma.1.2020.11.07.03.50.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 07 Nov 2020 03:50:05 -0800 (PST)
Subject: Re: [PATCH] macio: set user_creatable to false in macio_class_init()
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, thuth@redhat.com,
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20201107112811.24870-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <85a333ce-7e09-373f-0c6e-70dbb2c8e758@amsat.org>
Date: Sat, 7 Nov 2020 12:50:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201107112811.24870-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/7/20 12:28 PM, Mark Cave-Ayland wrote:
> Commit 348b8d1a76 "macio: don't reference serial_hd() directly within the device"
> removed the setting of user_creatable to false on the basis that the restriction
> was due to the use of serial_hd() in macio_instance_init().
> 
> Unfortunately this isn't the full story since the PIC object property links
> must still be set before the device is realized. Whilst it is possible to update
> the macio device and Mac machines to resolve this, the fix is too invasive at
> this point in the release cycle.
> 
> For now simply set user_creatable back to false in macio_class_init() to
> prevent QEMU from segfaulting in anticipation of the proper fix arriving in
> QEMU 6.0.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/misc/macio/macio.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

