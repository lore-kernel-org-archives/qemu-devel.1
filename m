Return-Path: <SRS0=y3lU=7F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC48C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 18:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EF1820679
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2020 18:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCf3GN3w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EF1820679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcYmQ-0006qO-DP
	for qemu-devel@archiver.kernel.org; Sat, 23 May 2020 14:21:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcYlr-0006Pm-4h
 for qemu-devel@nongnu.org; Sat, 23 May 2020 14:21:19 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36513)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcYlp-00084x-U0
 for qemu-devel@nongnu.org; Sat, 23 May 2020 14:21:18 -0400
Received: by mail-wm1-x344.google.com with SMTP id u188so13147448wmu.1
 for <qemu-devel@nongnu.org>; Sat, 23 May 2020 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xA8Nqtt1+OBjWfWm1Z8rrLkRPUDhTaus6vdHJucQGOA=;
 b=JCf3GN3wXFaV3qN4Cd6h5BBMeZSibU8lDUIG8/vQNIEccQTusvKwTV29ACe0rV73tD
 rShsbWq2H5sCBCI503iEl3I5xSxDUWvhVcZIysIrJ2pdWcnuXNU2lMWLnTiUVbf0GNfR
 6+e6kUd+alWtm5VnGCf5BOhYMhuswo1RG2y+Q/C7fIH0usdXDHoHLj1YeWCrncHUKs2X
 RMt0JxGg/4OoUwtsp0/reM2VxhQv04zA+z0MbhJUMIzE0412DZI2o2GkLFKz5XWvqx47
 yhPeWKdQIAAL6F4e8vNe6HGcHyLJuwXRybkR+pFSP+dbQSSkKxGJio2/WXFfRrSu3XD5
 BX1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xA8Nqtt1+OBjWfWm1Z8rrLkRPUDhTaus6vdHJucQGOA=;
 b=JKSmrbJqp5OM4zDaMpwjVewCy7k/fCbnlZxYf0nkSFPCAEuC2Y6yJFT0ml1p2Dgjdo
 hDTF539pS+yMjv+Er6DrdfPa7NHtIAa1lKsVjn6Lyc7bu50CS/USVbd2Bg+sSIl8FnnR
 mG50zIag33Doh8DWMfPqM38buEqgTMG/iIay/fl03VFtQrTZLgbjFFpY1k7alFlAcnIh
 07Zu5QyXQPOPN3RaEuBD7Pq3itvvjfPkT+khUMHLJFHjwyiGelkBVS3HTVIrO5etwoz1
 wWPhqUdoRcH9YRUzK9Nl27vYw47J/jtmZETwQn6b7pncgMaaEVGlX+ehzLO/4z5Bg28M
 qHRA==
X-Gm-Message-State: AOAM532RE6RoB73NZgv/1NBSUyEfmWLX77BkRRo50hidCp04nEWl9uSQ
 hm+KEG75SiNQso6na2Pr7+0=
X-Google-Smtp-Source: ABdhPJwrhGdHXQT9p2iTI5F8oqEWQ7L6BS6wyjZCemgyEp6t9qoImZ5hTEFnRCqqDcDvT56Yh99SpQ==
X-Received: by 2002:a1c:99d7:: with SMTP id
 b206mr12275583wme.150.1590258076004; 
 Sat, 23 May 2020 11:21:16 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id 88sm12627127wrq.77.2020.05.23.11.21.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 May 2020 11:21:14 -0700 (PDT)
Subject: Re: [Bug 1880326] [NEW] memory writes make artist_rop8() crash
To: Bug 1880326 <1880326@bugs.launchpad.net>, qemu-devel@nongnu.org,
 Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <159025699248.19687.6356837063531567895.malonedeb@soybean.canonical.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <18b7004a-9f29-a498-f8f3-6db5cb2dfdc1@amsat.org>
Date: Sat, 23 May 2020 20:21:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159025699248.19687.6356837063531567895.malonedeb@soybean.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 5/23/20 8:03 PM, Philippe Mathieu-Daudé wrote:
> Public bug reported:
> 
> As of commit d19f1ab0, LLVM libFuzzer found:
> 
> =================================================================
> ==6814==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7fd89f97bd5a at pc 0x55dc44594db5 bp 0x7ffd6f461b40 sp 0x7ffd6f461b38
> READ of size 1 at 0x7fd89f97bd5a thread T0
>     #0 0x55dc44594db4 in artist_rop8
>     #1 0x55dc44595fd9 in draw_line
>     #2 0x55dc445937e4 in draw_line_size
>     #3 0x55dc4458ee9d in artist_reg_write
>     #4 0x55dc43f77ba7 in memory_region_write_accessor
>     #5 0x55dc43f775b8 in access_with_adjusted_size
>     #6 0x55dc43f762b3 in memory_region_dispatch_write
>     #7 0x55dc43dbb322 in flatview_write_continue
>     #8 0x55dc43dab2e2 in flatview_write
>     #9 0x55dc43daae14 in address_space_write
> 
> 0x7fd89f97bd5a is located 1122 bytes to the right of 16777464-byte region [0x7fd89e97b800,0x7fd89f97b8f8)
> allocated by thread T0 here:
>     #0 0x55dc43d87abf in operator new(unsigned long)
>     #1 0x55dc43c4274d in fuzzer::FuzzerDriver(int*, char***, int (*)(unsigned char const*, unsigned long))
>     #2 0x55dc43c3a526 in main (qemu-fuzz-hppa+0x982526)
>     #3 0x7fd8d05edf42 in __libc_start_main (/lib64/libc.so.6+0x23f42)
> 
> SUMMARY: AddressSanitizer: heap-buffer-overflow (qemu-fuzz-hppa+0x12dcdb4) in artist_rop8
> Shadow bytes around the buggy address:
>   0x0ffb93f27750: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0ffb93f27760: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0ffb93f27770: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0ffb93f27780: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0ffb93f27790: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
> =>0x0ffb93f277a0: fa fa fa fa fa fa fa fa fa fa fa[fa]fa fa fa fa
>   0x0ffb93f277b0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0ffb93f277c0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0ffb93f277d0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0ffb93f277e0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0ffb93f277f0: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
> Shadow byte legend (one shadow byte represents 8 application bytes):
>   Addressable:           00
>   Partially addressable: 01 02 03 04 05 06 07 
>   Heap left redzone:       fa
>   Freed heap region:       fd
>   Stack left redzone:      f1
>   Stack mid redzone:       f2
>   Stack right redzone:     f3
>   Stack after return:      f5
>   Stack use after scope:   f8
>   Global redzone:          f9
>   Global init order:       f6
>   Poisoned by user:        f7
>   Container overflow:      fc
>   Array cookie:            ac
>   Intra object redzone:    bb
>   ASan internal:           fe
>   Left alloca redzone:     ca
>   Right alloca redzone:    cb
>   Shadow gap:              cc
> ==6814==ABORTING
> 
> How to reproduce:
> 
> qemu-system-hppa -S -qtest stdio -accel qtest -display none < EOF
> writeb 0xf8100081 0x40
> writeb 0xf81000c5 0x40
> writeb 0xf8100e44 0x2b
> writeb 0xf8100e44 0x56
> writeb 0xf8100e44 0x10
> writeb 0xf8100600 0x0
> writeb 0xf8100821 0x21
> writeb 0xf8100b01 0x14
> writew 0xf8100044 0x1245
> writeb 0xf8100a0e 0x50
> writeb 0xf8100a02 0x49
> writeb 0xf8100821 0x0
> writew 0xf8100014 0x0
> writeb 0xf8100e46 0x46
> writeb 0xf8100052 0xe
> writeb 0xf8100621 0x14
> writeb 0xf8100b01 0x14
> writew 0xf8100044 0x1241
> writeb 0xf8100b02 0x25
> writeb 0xf8100b01 0x4
> writeb 0xf8100e46 0xb0
> writeb 0xf8100b02 0x0
> writel 0xf81000c4 0x49494949
> writeb 0xf8100b02 0x10
> writew 0xf8100010 0x11
> writew 0xf8100044 0x1212
> writew 0xf8100044 0x1245
> writew 0xf8100050 0xe2a
> writeb 0xf8100002 0x11
> writeb 0xf8100081 0xec
> writeb 0xf8100081 0xec
> writeb 0xf810030e 0xe
> writeb 0xf810000e 0x44
> writeb 0xf8100000 0xe
> writeb 0xf8100044 0xe
> writeb 0xf8100000 0xe
> writeb 0xf810030e 0x13
> writeb 0xf8100b44 0x2a
> writeb 0xf8100bf8 0x4
> writeb 0xf8100007 0x45
> writeb 0xf81000ff 0xff
> writew 0xf8100044 0xf042
> writew 0xf8100000 0x45
> writew 0xf8100044 0xf042
> writeb 0xf8100000 0xc5
> writeb 0xf81000ff 0xff
> writel 0xf8100044 0x101364ff
> writel 0xf81000c4 0xfba0a0a0
> writeb 0xf8100000 0x2a
> writeb 0xf81000c5 0x40
> writeb 0xf81000ff 0xdf
> writew 0xf8100000 0x4144
> writeb 0xf81000df 0x0
> writew 0xf8100044 0x4400
> writel 0xf8100044 0x101364ff
> writel 0xf81000c4 0xfb490045
> writeb 0xf8100000 0x2a
> writeb 0xf81000c5 0x40
> writel 0xf8100044 0x101364ff
> writel 0xf8100bc4 0x49004545
> writeb 0xf8100000 0x2a
> writeb 0xf81000c5 0x40
> writeb 0xf810000e 0x21
> writeb 0xf8100000 0x2a
> writeb 0xf81000c3 0x40
> writeb 0xf81000ff 0xdf
> writew 0xf8100044 0x1210
> writew 0xf8100044 0x1210
> writew 0xf8100010 0x4412
> writew 0xf8100010 0x4412
> writew 0xf8100044 0x1210
> writew 0xf8100044 0x1210
> writew 0xf8100044 0x1210
> writew 0xf8100000 0x4144
> writew 0xf8100044 0x4400
> writew 0xf8100000 0x4144
> writew 0xf81000bc 0xc100
> writew 0xf8100000 0x4144
> writew 0xf81000bc 0xc100
> writew 0xf8100044 0x1210
> writel 0xf8100044 0xfb53000a
> writew 0xf8100044 0x1210
> writel 0xf8100044 0xfb53000a
> writew 0xf8100044 0x1210
> writel 0xf8100044 0xfba7000a
> writew 0xf8100044 0x1210
> writew 0xf8100044 0x1210
> writew 0xf8100000 0x4144
> writew 0xf8100000 0x4144
> writew 0xf8100000 0x4144
> writew 0xf8100044 0x4400
> writew 0xf8100044 0x4411
> writew 0xf8100044 0x1210
> writew 0xf8100044 0x1210
> writew 0xf8100044 0x1210
> writew 0xf8100044 0x1212
> writew 0xf8100044 0x4445
> writeb 0xf81000ff 0xff
> writeb 0xf8100121 0x14
> writeb 0xf8100121 0x14
> writeb 0xf8100421 0x0
> writeb 0xf8100421 0x28
> writeb 0xf8100000 0x2a
> writeb 0xf81000c5 0x40
> writeb 0xf8100040 0x0
> writeb 0xf8100007 0x45
> writeb 0xf8100007 0x45
> writeb 0xf8100bf8 0x4
> writeb 0xf8100bf8 0x4
> writeb 0xf8100bf8 0x4
> writeb 0xf8100bf8 0x4
> writeb 0xf8100bf8 0x4
> writew 0xf8100060 0x11
> writew 0xf8100060 0x11
> writew 0xf8100060 0x17
> writeb 0xf8100446 0x46
> writeb 0xf8100604 0x50
> writeb 0xf8100821 0x21
> writeb 0xf8100108 0x21
> writeb 0xf810010c 0x21
> writeb 0xf8100081 0xec
> writeb 0xf8100041 0xec
> writel 0xf8100044 0x101364ff
> writel 0xf81000c4 0xfba0a0a0
> writel 0xf8100044 0x101364ff
> writel 0xf81000c4 0xfba0a0a0
> writel 0xf8100044 0x101364ff
> writel 0xf81000c4 0xfba0a0a0
> writeb 0xf8100052 0x24
> writew 0xf8100000 0x4144
> writeb 0xf81000df 0x0
> writew 0xf8100044 0x4400
> writew 0xf8100000 0x4144
> writeb 0xf81000df 0x41
> writeb 0xf8100504 0x50
> writew 0xf8100010 0x4412
> writew 0xf8100010 0x4412
> writew 0xf8100094 0x4145
> writel 0xf8100044 0x10424410
> writel 0xf81000a0 0xa0a0492a
> writel 0xf8100044 0x10040000
> writeb 0xf8100007 0x44
> writeb 0xf81000ff 0xff
> writeb 0xf8100007 0x44
> writeb 0xf81000ff 0x4
> writel 0xf8100044 0x10134900
> writeb 0xf8100000 0x2a
> writeb 0xf81000c5 0x40
> writeb 0xf8100000 0x2a
> writeb 0xf81000c5 0x40
> writew 0xf8100040 0x1212
> writew 0xf8100044 0x1245
> writew 0xf8100040 0x1212
> writew 0xf8100040 0x5002
> writew 0xf8100040 0x5002
> writew 0xf8100040 0x502a
> writeb 0xf8100081 0x40
> writeb 0xf810005d 0x40
> writeb 0xf8100030 0x5d
> writeb 0xf8100e44 0x44
> writeb 0xf8100044 0x3
> writeb 0xf8100044 0x3
> writeb 0xf8100044 0x13
> writew 0xf8100044 0x1210
> writew 0xf8100044 0x1210
> writew 0xf8100044 0x1210
> writew 0xf8100044 0x6d10
> writeb 0xf8100044 0x6d
> writeb 0xf8100000 0x2a
> writeb 0xf8100044 0x40
> writeb 0xf8100045 0xec
> writew 0xf8100044 0x1210
> writew 0xf8100044 0x1245
> writel 0xf8100044 0x101364ff
> writel 0xf81000c4 0xfba0a0a0
> writel 0xf8100044 0x101364ff
> writel 0xf8100044 0x101364ff
> writel 0xf8100044 0x101364ff
> writel 0xf8100008 0xfba0a0a0
> writel 0xf8100044 0x4208fba0
> writew 0xf8100010 0x4412
> writew 0xf8100010 0x4412
> writew 0xf8100010 0x4412
> writew 0xf8100010 0x4412
> writew 0xf8100010 0x4412
> writew 0xf8100000 0x4144
> writeb 0xf810030e 0xe
> writeb 0xf810030e 0xe
> writeb 0xf810032b 0xe
> writeb 0xf810032b 0xe
> writew 0xf8100010 0x4412
> writew 0xf81000ca 0x4441
> writew 0xf8100010 0x4412
> writew 0xf8100010 0x4412
> writew 0xf8100010 0x4412
> writew 0xf8100010 0x4412
> writeb 0xf8100080 0xe
> writeb 0xf8100080 0xd8
> writeb 0xf8100080 0x26
> writeb 0xf8100040 0x80
> writeb 0xf8100040 0x26
> writeb 0xf81000c3 0x40
> writeb 0xf81000ff 0xdf
> writeb 0xf81000c3 0x40
> writeb 0xf81000ff 0xdf
> writew 0xf8100014 0x4000
> writeb 0xf8100000 0xe
> writeb 0xf8100000 0x9e
> writeb 0xf8100000 0x3c
> writeb 0xf8100000 0x3c
> writeb 0xf8100000 0x3c
> writew 0xf8100000 0x4144
> writeb 0xf81000df 0x41
> writeb 0xf8100007 0x45
> writeb 0xf81000ff 0xff
> writeb 0xf8100007 0xb4
> writeb 0xf81000ff 0xff
> writeb 0xf8100007 0xb4
> writeb 0xf8100007 0xb4
> writel 0xf8100044 0x10139c05
> writel 0xf81000c4 0xfba0a0a0
> writeb 0xf8100604 0x50
> writeb 0xf8100021 0xe
> writeb 0xf8100021 0xe
> writeb 0xf8100021 0xe
> writeb 0xf8100021 0x90
> writew 0xf8100010 0x11
> writew 0xf8100010 0x11
> writew 0xf8100010 0x11
> writeb 0xf8100021 0xe
> writeb 0xf8100021 0xe
> writeb 0xf8100021 0xe
> writeb 0xf8100021 0xe
> writeb 0xf8100021 0xe
> writew 0xf8100010 0x4412
> writew 0xf8100010 0x4412
> writew 0xf8100010 0x4412
> writew 0xf8100010 0x4412
> writew 0xf8100010 0x4412
> writeb 0xf8100021 0xe
> writeb 0xf8100021 0xe
> writeb 0xf8100021 0x21
> writeb 0xf8100021 0x21
> writeb 0xf8100000 0x0
> writeb 0xf8100e04 0x46
> EOF
> 
> Program terminated with signal SIGSEGV, Segmentation fault.
> #0  0x000056367b2085c0 in artist_rop8 (s=0x56367d38b510, dst=0x7f9f972fffff <error: Cannot access memory at address 0x7f9f972fffff>, val=0 '\000') at hw/display/artist.c:284
> 284             *dst &= ~plane_mask;
> (gdb) bt
> #0  0x000056367b2085c0 in artist_rop8 (s=0x56367d38b510, dst=0x7f9f972fffff <error: Cannot access memory at address 0x7f9f972fffff>, val=0 '\000') at hw/display/artist.c:284
> #1  0x000056367b209325 in draw_line (s=0x56367d38b510, x1=-20480, y1=-1, x2=0, y2=17920, update_start=true, skip_pix=-1, max_pix=-1) at hw/display/artist.c:646
> #2  0x000056367b2095a0 in draw_line_size (s=0x56367d38b510, update_start=true) at hw/display/artist.c:696
> #3  0x000056367b20a214 in artist_reg_write (opaque=0x56367d38b510, addr=1052164, val=70, size=1) at hw/display/artist.c:932
> #4  0x000056367b06ea7c in memory_region_write_accessor (mr=0x56367d38ba10, addr=1052164, value=0x7fff112132d8, size=1, shift=0, mask=255, attrs=...) at memory.c:483
> #5  0x000056367b06ec33 in access_with_adjusted_size (addr=1052164, value=0x7fff112132d8, size=1, access_size_min=1, access_size_max=4, access_fn=
>     0x56367b06e999 <memory_region_write_accessor>, mr=0x56367d38ba10, attrs=...) at memory.c:540
> #6  0x000056367b071bb4 in memory_region_dispatch_write (mr=0x56367d38ba10, addr=1052164, data=70, op=MO_8, attrs=...) at memory.c:1477
> #7  0x000056367b00fe33 in flatview_write_continue (fv=0x56367d6f9fa0, addr=4161801732, attrs=..., ptr=0x7fff112134e0, len=1, addr1=1052164, l=1, mr=0x56367d38ba10) at exec.c:3147
> #8  0x000056367b00ff81 in flatview_write (fv=0x56367d6f9fa0, addr=4161801732, attrs=..., buf=0x7fff112134e0, len=1) at exec.c:3190
> #9  0x000056367b0102eb in address_space_write (as=0x56367cff99c0, addr=4161801732, attrs=..., buf=0x7fff112134e0, len=1) at exec.c:3289
> 
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
> 

The crash is avoided using this patch:
-- >8 --
diff --git a/hw/display/artist.c b/hw/display/artist.c
index 6e17c43f13..fcfd67da47 100644
--- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -563,7 +563,7 @@ static void fill_window(ARTISTState *s, int startx,
int starty,
 static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
                       bool update_start, int skip_pix, int max_pix)
 {
-    struct vram_buffer *buf;
+    struct vram_buffer *buf = &s->vram_buffer[ARTIST_BUFFER_AP];
     uint8_t color;
     int dx, dy, t, e, x, y, incy, diago, horiz;
     bool c1;
@@ -571,6 +571,12 @@ static void draw_line(ARTISTState *s, int x1, int
y1, int x2, int y2,

     trace_artist_draw_line(x1, y1, x2, y2);

+    if (x1 * y1 >= buf->size || x2 * y2 >= buf->size) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "draw line (%d,%d) (%d,%d)\n", x1, y1, x2, y2);
+        return;
+    }
+
     if (update_start) {
         s->vram_start = (x2 << 16) | y2;
     }
@@ -628,7 +634,6 @@ static void draw_line(ARTISTState *s, int x1, int
y1, int x2, int y2,
     x = x1;
     y = y1;
     color = artist_get_color(s);
-    buf = &s->vram_buffer[ARTIST_BUFFER_AP];

     do {
         if (c1) {
---

I am not sure this is the best fix, IMO the invalid value should be
reported earlier.

