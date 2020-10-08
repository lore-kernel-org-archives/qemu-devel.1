Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A48C433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:45:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72BA52184D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 07:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gtc+R3/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BA52184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQQbo-0006Hj-Ft
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 03:45:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQQaZ-0005Ra-Mx
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:43:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kQQaW-0008Nz-Q8
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 03:43:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602143024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cDgC4d48P7A3ljvKzLfjx/yZN0sdukQw9zMo29YgeuQ=;
 b=Gtc+R3/5u3RwK4KjtJnUDTcts7TcND3JTlz7wIUh68rJB2kYssn7XvtMuc9GkV7J2DjHAP
 1BDWrCoGafg0rhH6LoAzWsT5HPz8g/EvXx1ko7NQThXs7F5eLjkjPEDd2xB6Yh1xZP7c8b
 GmYVTJM5cPJKsdabdy+nRgf+it8KyT8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-EFic-0OeM9eh82tSBcy3yw-1; Thu, 08 Oct 2020 03:43:42 -0400
X-MC-Unique: EFic-0OeM9eh82tSBcy3yw-1
Received: by mail-wm1-f70.google.com with SMTP id z7so2849588wmi.3
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 00:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cDgC4d48P7A3ljvKzLfjx/yZN0sdukQw9zMo29YgeuQ=;
 b=O+C7zCakikYEm1PPZ3BXOIEtPBEJ1L9QlqiVR7Kd52aNKlJY7JlLFVHG6V2iIVpwA1
 XoYoSOjraXR4UK4Xe8s3lK/TRvXkhd+KNzK4OwC2D2uRcrL7QkANCTcxQqsDvFrAX4uw
 fyOYnyKmNk0kAVo193d5SstV2IonotgeXbdOsj797AjIcpJx59sktn8c3C7jtbByLpX8
 Rgsf4SyUkR+k5IBaVOnVIDvZGLshbGKhpJFy/eXBS8ribJtliuw8yQok/FX1kGkuyeLo
 /zBfbfvDWOrxLHwBQKnidD/x7E7Y+biJuFENU1l486YCAUJNV7CMMg9R3n+fsitUO2HV
 LJ1g==
X-Gm-Message-State: AOAM5335W4SYBfV2ArskVkE92BzzfvJnEyJ5Sh5sZqZuA7MjCJwPC80q
 KlJaFiNOT6jApFceUR9gfwXT/A6/Xfxt/T8O7jER7YwoPllVIeTTgluazaC8BLzAUC86o1kx29R
 d/6WAnMqFiztz2kw=
X-Received: by 2002:a1c:1d89:: with SMTP id d131mr7232551wmd.119.1602143021305; 
 Thu, 08 Oct 2020 00:43:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJybkwgjldLvZdqzcqeuDae7xUhP9XKlUU64GgAZ6ztLnuKy03Zn3+xAnDe0H6mnLDPidz575g==
X-Received: by 2002:a1c:1d89:: with SMTP id d131mr7232527wmd.119.1602143021059; 
 Thu, 08 Oct 2020 00:43:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:bb8c:429c:6de1:f4ec?
 ([2001:b07:6468:f312:bb8c:429c:6de1:f4ec])
 by smtp.gmail.com with ESMTPSA id q20sm5583446wmc.39.2020.10.08.00.43.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 00:43:39 -0700 (PDT)
Subject: Re: [PATCH v3 04/16] fuzz: Add DMA support to the generic-fuzzer
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20200921022506.873303-1-alxndr@bu.edu>
 <20200921022506.873303-5-alxndr@bu.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4fa19590-4b40-aedb-fa1d-44c844337ecf@redhat.com>
Date: Thu, 8 Oct 2020 09:43:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921022506.873303-5-alxndr@bu.edu>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 02:56:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 darren.kenny@oracle.com, bsd@redhat.com, stefanha@redhat.com,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/09/20 04:24, Alexander Bulekov wrote:
> +    if (qtest_log_enabled) {
> +        /*
> +         * With QTEST_LOG, use a normal, slow QTest memwrite. Prefix the log
> +         * that will be written by qtest.c with a DMA tag, so we can reorder
> +         * the resulting QTest trace so the DMA fills precede the last PIO/MMIO
> +         * command.
> +         */
> +        fprintf(stderr, "[DMA] ");
> +        fflush(stderr);
> +        qtest_memwrite(qts_global, ar.addr, buf, ar.size);
> +    } else {
> +       /*
> +        * Populate the region using address_space_write_rom to avoid writing to
> +        * any IO MemoryRegions
> +        */
> +        address_space_write_rom(first_cpu->as, ar.addr, MEMTXATTRS_UNSPECIFIED,
> +                buf, ar.size);
> +    }

I wonder if you should just copy address_space_write_rom to your own
code.  This way you can log the write just like qtest_memwrite would,
while skipping memwrites that would access IO regions.

Paolo


