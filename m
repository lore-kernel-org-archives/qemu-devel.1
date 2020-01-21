Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248F9C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:10:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDAAE206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 17:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C4P1iFY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDAAE206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itx2Y-00046t-4Q
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 12:10:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43389)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1itwyP-00074X-IM
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 12:05:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1itwyK-0000nb-Jc
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 12:05:52 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48448)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1itwyK-0000lU-4t
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 12:05:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579626346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xzRl92CS61y82nXKkxIbW59GPDZXf87l/UbeTEGZVaY=;
 b=C4P1iFY5IWokKTs9Sd7kz6APrnBYSiv5cLdn7tw1Dd9010qO5r8NvPrK2mPbdfDYGA4PW3
 4A0Qfv0sFafeTLp2iCDIQuT4u2hzlmOygHroDh/04Hm6rKoYrk1OlYYehFLBtddM8s5pa2
 JjKL/lRwjhcgmH1hLjV3tQa9Zk+JrgU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-Zzlqwe44O3Cm1ojEAgP0gA-1; Tue, 21 Jan 2020 12:05:45 -0500
Received: by mail-wm1-f72.google.com with SMTP id m133so640483wmf.2
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 09:05:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xzRl92CS61y82nXKkxIbW59GPDZXf87l/UbeTEGZVaY=;
 b=KG6zWrRtG5qZ7GcYTgIwW50qyUWR21GyxgYbofwTuhcxb+Pc5oxEal6s2s1mzSqn5N
 DeQFkgCYFRFIwglYvavLI8SZlCCEDdjUShiORxKWunLogmOAr+wRROBbGcypQ/MSqCgp
 /J4KVlpSfNMd+hiDd5lh0zX9NQsudETEjrbrGTziP8aSMH96fp4C1PYAW1f9DKcmKeRc
 1IeHNuuPOHjzHL8QJVlM8NyUb+a6LS2V+w0ilfvSF3/9/jRJGBp13Nb/kNM+srWeNtl6
 LoIsumSX4vqYG+OYtTdEkPalTywVszLtkwugjA0+AvcQngC1u/Arbi6pO2wumBi2rhre
 f00g==
X-Gm-Message-State: APjAAAUzvMSWE/q+jMH05YhImx3dXrqOIGwHvGuUnzYwnjKNh+k30lLK
 rL9x77txTo+DlKohsORAkSqfSJ/GwgWjE04gH1PZjEE48H/GUmKraSngnDzveLw8PIQnmFbiQAv
 xo4pS3ena63EN4tA=
X-Received: by 2002:a5d:448c:: with SMTP id j12mr6075072wrq.125.1579626343948; 
 Tue, 21 Jan 2020 09:05:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqwrh+VeXL0f4S9uLMuZvJYhUO3zJLMrSm9oGE0oMJdIP+JqCsnJjbzDkSK56lW/1iUM6Bhbsw==
X-Received: by 2002:a5d:448c:: with SMTP id j12mr6075042wrq.125.1579626343570; 
 Tue, 21 Jan 2020 09:05:43 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a?
 ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
 by smtp.gmail.com with ESMTPSA id p18sm8832wmb.8.2020.01.21.09.05.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 09:05:43 -0800 (PST)
Subject: Re: [PATCH v2] scsi-disk: define props in scsi_block_disk to avoid
 memleaks
To: pannengyuan@huawei.com, fam@euphon.net
References: <20200114091634.60856-1-pannengyuan@huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5e875870-449e-3f65-60bc-79ba5190d2fb@redhat.com>
Date: Tue, 21 Jan 2020 18:05:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200114091634.60856-1-pannengyuan@huawei.com>
Content-Language: en-US
X-MC-Unique: Zzlqwe44O3Cm1ojEAgP0gA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Euler Robot <euler.robot@huawei.com>, qemu-devel@nongnu.org,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/01/20 10:16, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> scsi_block_realize() use scsi_realize() to init some props, but
> these props is not defined in scsi_block_disk_properties, so they will
> not be freed.
> 
> This patch defines these prop in scsi_block_disk_properties and aslo
> calls scsi_unrealize to avoid memleaks, the leak stack as
> follow(it's easy to reproduce by attaching/detaching scsi-block-disks):
> 
> =================================================================
> ==qemu-system-x86_64==32195==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 57 byte(s) in 3 object(s) allocated from:
>   #0 0x7f19f8bed768 (/lib64/libasan.so.5+0xef768)  ??:?
>   #1 0x7f19f64d9445 (/lib64/libglib-2.0.so.0+0x52445)  ??:?
>   #2 0x7f19f64f2d92 (/lib64/libglib-2.0.so.0+0x6bd92)  ??:?
>   #3 0x55975366e596 (qemu-system-x86_64+0x35c0596)  /mnt/sdb/qemu/hw/scsi/scsi-disk.c:2399
>   #4 0x559753671201 (emu-system-x86_64+0x35c3201)  /mnt/sdb/qemu/hw/scsi/scsi-disk.c:2681
>   #5 0x559753687e3e (qemu-system-x86_64+0x35d9e3e)  /mnt/sdb/qemu/hw/scsi/scsi-bus.c:58
>   #6 0x55975368ac44 (qemu-system-x86_64+0x35dcc44)  /mnt/sdb/qemu/hw/scsi/scsi-bus.c:216
>   #7 0x5597532a7840 (qemu-system-x86_64+0x31f9840)  /mnt/sdb/qemu/hw/core/qdev.c:876
> 
> Direct leak of 15 byte(s) in 3 object(s) allocated from:
>   #0 0x7f19f8bed768 (/lib64/libasan.so.5+0xef768)  ??:?
>   #1 0x7f19f64d9445 (/lib64/libglib-2.0.so.0+0x52445)  ??:?
>   #2 0x7f19f64f2d92 (/lib64/libglib-2.0.so.0+0x6bd92)  ??:?
>   #3 0x55975366e06f (qemu-system-x86_64+0x35c006f)  /mnt/sdb/qemu/hw/scsi/scsi-disk.c:2388
>   #4 0x559753671201 (qemu-system-x86_64+0x35c3201)  /mnt/sdb/qemu/hw/scsi/scsi-disk.c:2681
>   #5 0x559753687e3e (qemu-system-x86_64+0x35d9e3e)  /mnt/sdb/qemu/hw/scsi/scsi-bus.c:58
>   #6 0x55975368ac44 (qemu-system-x86_64+0x35dcc44)  /mnt/sdb/qemu/hw/scsi/scsi-bus.c:216
> 
> @@ -3079,9 +3080,8 @@ static const TypeInfo scsi_cd_info = {
>  
>  #ifdef __linux__
>  static Property scsi_block_properties[] = {
> -    DEFINE_BLOCK_ERROR_PROPERTIES(SCSIDiskState, qdev.conf),         \
> +    DEFINE_SCSI_DISK_PROPERTIES(),.
The properties defined there shouldn't apply to scsi-block.

Can you explain what exactly is being leaked?

Paolo


