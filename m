Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5264C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 10:30:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 762FA2077D
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 10:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RG9fOpWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 762FA2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcnu9-0008KW-Jk
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 06:30:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcntZ-0007ra-1W
 for qemu-devel@nongnu.org; Sun, 24 May 2020 06:30:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21311
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jcntX-0002lv-1t
 for qemu-devel@nongnu.org; Sun, 24 May 2020 06:30:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590316213;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=z59w7SEaF1d3jNBssOWL4+Bfnkoh0304dpkCBk45xQ4=;
 b=RG9fOpWNWTkEZ4g2UMjqnyS9tDH1RT0o6AJIUt1SvXd0neg/qSO+j00yVqfTec9Fg386K0
 MfXzMCjbRlLvR1lXTUe10o7UvX1UEgjtBO2c2ZYRYMyFn6xLLy+iEWrxP9yAfnZANBWd3g
 zDKxdwEqAFKdFA8D74EqldWTqU72qkQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-JIkFfAolNl-y-cq57-CQjQ-1; Sun, 24 May 2020 06:30:11 -0400
X-MC-Unique: JIkFfAolNl-y-cq57-CQjQ-1
Received: by mail-wm1-f72.google.com with SMTP id 18so192116wmu.1
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 03:30:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z59w7SEaF1d3jNBssOWL4+Bfnkoh0304dpkCBk45xQ4=;
 b=XIzkD3qP5NttRLsKUv8mKGsHJNnhA/TjJcTrcjgwOs+ZUkRIbFzZkZ5HvNnpsJdhpD
 RO7zFAHxO75BCo6l5aCHeaZTmjTVNi9Vc56jcbfktVLwj0qeI1uvwuwk9zv6sF0v7OAi
 vvVXxL3IIp7gAEJrefhnGqhhnbqusA2xiGmDEpPrFs02jK7BIxDTuPLkYgF6dJRedH6m
 XCzc1B56tQYraSDxVCylmONutP1BbWyhCqNtR3Ee6opx59s3MUNAzecmCzPlzYJoO1hN
 CdhJIQIzEydtxnkKcw9uxj1jvOBFa0YkOBv8kxsa4QMuGsvmqHEP61JpT/2wUqXZyZ1W
 enNA==
X-Gm-Message-State: AOAM532fGKNOCxoVayPRnFX/CG0CTPGtwWATrYzGDV57w5zsqA8lM5Mr
 Ok2SVOJVw46GCvvQOhVSPWatALyGleW2cHUd8CW1ezME7YvhRgqBV8msGcnj+YwTGLKHsTN70br
 FsgTLqKSnerAjtHA=
X-Received: by 2002:a05:6000:1187:: with SMTP id
 g7mr10847217wrx.54.1590316209203; 
 Sun, 24 May 2020 03:30:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzeYCcwmpm7bTpTkQRPDqGxpGMN5/mZHKECcnIqenGg/jEYkU1wNiN0YRLW0QkdLHk6Q/x65A==
X-Received: by 2002:a05:6000:1187:: with SMTP id
 g7mr10847211wrx.54.1590316208981; 
 Sun, 24 May 2020 03:30:08 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id a12sm9009704wrs.70.2020.05.24.03.30.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 May 2020 03:30:08 -0700 (PDT)
Subject: Re: [Bug 1880355] [NEW] Length restrictions for fw_cfg_dma_transfer?
To: Bug 1880355 <1880355@bugs.launchpad.net>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <159029353528.907.11982786579949073896.malonedeb@chaenomeles.canonical.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <ced59c5e-01e9-9da6-5191-9d34ffa976b0@redhat.com>
Date: Sun, 24 May 2020 12:30:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159029353528.907.11982786579949073896.malonedeb@chaenomeles.canonical.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/24 06:30:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 5/24/20 6:12 AM, Alexander Bulekov wrote:
> Public bug reported:
> 
> For me, this takes close to 3 minutes at 100% CPU:
> echo "outl 0x518 0x9596ffff" | ./i386-softmmu/qemu-system-i386 -M q35 -m 32 -nographic -accel qtest -monitor none -serial none -qtest stdio
> 
> #0  phys_page_find (d=0x606000035d80, addr=136728041144404) at /exec.c:338
> #1  address_space_lookup_region (d=0x606000035d80, addr=136728041144404, resolve_subpage=true) at /exec.c:363
> #2  address_space_translate_internal (d=0x606000035d80, addr=136728041144404, xlat=0x7fff1fc0d070, plen=0x7fff1fc0d090, resolve_subpage=true) at /exec.c:382
> #3  flatview_do_translate (fv=0x606000035d20, addr=136728041144404, xlat=0x7fff1fc0d070, plen_out=0x7fff1fc0d090, page_mask_out=0x0, is_write=true, is_mmio=true, target_as=0x7fff1fc0ce10, attrs=...)
>     pment/qemu/exec.c:520
> #4  flatview_translate (fv=0x606000035d20, addr=136728041144404, xlat=0x7fff1fc0d070, plen=0x7fff1fc0d090, is_write=true, attrs=...) at /exec.c:586
> #5  flatview_write_continue (fv=0x606000035d20, addr=136728041144404, attrs=..., ptr=0x7fff1fc0d660, len=172, addr1=136728041144400, l=172, mr=0x557fd54e77e0 <io_mem_unassigned>)
>     pment/qemu/exec.c:3160
> #6  flatview_write (fv=0x606000035d20, addr=136728041144064, attrs=..., buf=0x7fff1fc0d660, len=512) at /exec.c:3177
> #7  address_space_write (as=0x557fd54e7a00 <address_space_memory>, addr=136728041144064, attrs=..., buf=0x7fff1fc0d660, len=512) at /exec.c:3271
> #8  dma_memory_set (as=0x557fd54e7a00 <address_space_memory>, addr=136728041144064, c=0 '\000', len=1378422272) at /dma-helpers.c:31
> #9  fw_cfg_dma_transfer (s=0x61a000001e80) at /hw/nvram/fw_cfg.c:400
> #10 fw_cfg_dma_mem_write (opaque=0x61a000001e80, addr=4, value=4294940309, size=4) at /hw/nvram/fw_cfg.c:467
> #11 memory_region_write_accessor (mr=0x61a000002200, addr=4, value=0x7fff1fc0e3d0, size=4, shift=0, mask=4294967295, attrs=...) at /memory.c:483
> #12 access_with_adjusted_size (addr=4, value=0x7fff1fc0e3d0, size=4, access_size_min=1, access_size_max=8, access_fn=0x557fd2288c80 <memory_region_write_accessor>, mr=0x61a000002200, attrs=...)
>     pment/qemu/memory.c:539
> #13 memory_region_dispatch_write (mr=0x61a000002200, addr=4, data=4294940309, op=MO_32, attrs=...) at /memory.c:1476
> #14 flatview_write_continue (fv=0x606000035f00, addr=1304, attrs=..., ptr=0x7fff1fc0ec40, len=4, addr1=4, l=4, mr=0x61a000002200) at /exec.c:3137
> #15 flatview_write (fv=0x606000035f00, addr=1304, attrs=..., buf=0x7fff1fc0ec40, len=4) at /exec.c:3177
> #16 address_space_write (as=0x557fd54e7bc0 <address_space_io>, addr=1304, attrs=..., buf=0x7fff1fc0ec40, len=4) at /exec.c:3271
> 
> 
> It looks like fw_cfg_dma_transfer gets the address(136728041144064) and length(1378422272) for the read from the value provided as input 4294940309 (0xFFFF9695) which lands in pcbios. Should there be any limits on the length of guest-memory that fw_cfg should populate?

It looks to me a normal behavior for a DMA device. DMA devices have a
different address space view than the CPUs.
Also note the fw_cfg is a generic device, not restricted to the x86 arch.

Maybe this function could use dma_memory_valid() to skip unassigned regions?


