Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5BEC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:29:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF3612176D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 00:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K1xkeuVn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3612176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihjh4-0004jd-6j
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 19:29:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihjgK-0004L1-QH
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:28:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihjgJ-0004gL-6R
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:28:44 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:35986)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihjgI-0004fP-Um
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 19:28:43 -0500
Received: by mail-pl1-x641.google.com with SMTP id a6so986820plm.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 16:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JbkfDVWSu+M6UJQZ/Gt0n8G3RKhqnHX377YF6un5mdw=;
 b=K1xkeuVnXWfp+ueAYjUj6utDVpbn899K7Hwc7FWEBiSeaT1P/jkHQYc8qudEx2exha
 lajkuxpRfXBAwCaO29O55cgA0dX+5VeXJtI9vRlXvvRCINMR2IjxtHuw1IHlO2xCB8LD
 QbxwDi8lkIxuQgPlDu6pFHpAc4mTB5xyp4wMFaRpy+9pHSGYrwf9bWjFhJPLNImaNZpx
 XxsVZfn2BHCGqbfysEcCfrE9T2f4aRZ07LE2Cy7fnt8X5T6ZBT59BD5lm3uxIEnwZ72q
 nepUg4s2MnXvTXbzI/h0CYVjMN17+hOotN6oI49og2Dm0CR6gFXrFFoOvUdT7GLWmvZg
 00SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JbkfDVWSu+M6UJQZ/Gt0n8G3RKhqnHX377YF6un5mdw=;
 b=F9HISuDggxbCk5q2cBJSvtqKCq+sUDshxO5wfKFZcpwVnMvt8PuK/nTtCN4I74J+Lh
 BEMlTmYnnPQI6bGyKqSlN3qd4W9Fg455lk+RxslVKShGbS13jfhaYFkPM+S3bM62vi4v
 38Abq9feuob6UZD9Ay4Rtnu76R0nxvEGq7O2Jy4wtUFQb4lq2k7GeO3d8euTdqaOCGgr
 p0a9+WZqk3Ft0tbrFT3uvN2e+O+QlNFNKOmw/YAQwQ0P5CfrvJsIG36c0fccJqybQbgX
 jknSYhwyfijs6kI5GLOatIviNPRptjkIEHeGHFpKgXVO6+SBG2LZkffhddjW/5XJYyJ7
 lDyQ==
X-Gm-Message-State: APjAAAV2CjOPEaP6YsmwV5uBQvj4hZcCzcgvy4CjVpd+9b8TJxR94VVu
 gB5J9cZEsK/bgMEZdmU3r+wYo0cgdh4=
X-Google-Smtp-Source: APXvYqxq5x9ORatf/QmuDjs071OxruRYOcyQYpIwu2mGZm3l8PT8yS0824fYCac3er99Wh7p/uQrOw==
X-Received: by 2002:a17:90a:9bc7:: with SMTP id
 b7mr6166955pjw.72.1576715321500; 
 Wed, 18 Dec 2019 16:28:41 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id e10sm5106655pfj.7.2019.12.18.16.28.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 16:28:40 -0800 (PST)
Subject: Re: [PATCH v4 5/6] hppa: Add emulation of Artist graphics
To: Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
References: <20191103205607.6590-1-svens@stackframe.org>
 <20191103205607.6590-6-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8a34a5a3-eb8f-c600-b17e-f9b448ea0925@linaro.org>
Date: Wed, 18 Dec 2019 14:28:37 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191103205607.6590-6-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/19 10:56 AM, Sven Schnelle wrote:
> This adds emulation of Artist graphics good enough
> to get a Text console on both Linux and HP-UX. The
> X11 server from HP-UX also works.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  hw/display/Kconfig       |    4 +
>  hw/display/Makefile.objs |    1 +
>  hw/display/artist.c      | 1449 ++++++++++++++++++++++++++++++++++++++
>  hw/display/trace-events  |    9 +
>  hw/hppa/Kconfig          |    1 +
>  hw/hppa/hppa_hardware.h  |    1 +
>  hw/hppa/machine.c        |    9 +
>  7 files changed, 1474 insertions(+)
>  create mode 100644 hw/display/artist.c

Seems to have some problems rebased upon master:


> Thread 6 "qemu-system-hpp" received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 0x7fffee3b6700 (LWP 11752)]
> 0x00005555558bba54 in artist_rop8 (s=s@entry=0x555556105400, 
>     dst=dst@entry=0x7fffed740000 "", val=0 '\000')
>     at /home/rth/qemu/qemu/hw/display/artist.c:288
> 288	        *dst |= val & plane_mask;
> (gdb) where
> #0  0x00005555558bba54 in artist_rop8
>     (s=s@entry=0x555556105400, dst=dst@entry=0x7fffed740000 "", val=0 '\000')
>     at /home/rth/qemu/qemu/hw/display/artist.c:288
> #1  0x00005555558bc145 in vram_bit_write
>     (s=s@entry=0x555556105400, posx=<optimized out>, posy=<optimized out>, incr_x=incr_x@entry=false, size=size@entry=4, data=<optimized out>, data@entry=0)
>     at /home/rth/qemu/qemu/hw/display/artist.c:430
> #2  0x00005555558bd33b in artist_reg_write
>     (opaque=0x555556105400, addr=1050144, val=0, size=4)
>     at /home/rth/qemu/qemu/hw/display/artist.c:862
> #3  0x00005555557b271b in memory_region_write_accessor
>     (mr=mr@entry=0x5555561058f0, addr=addr@entry=1050144, value=value@entry=0x7fffee3b4f08, size=size@entry=4, shift=shift@entry=0, mask=mask@entry=4294967295, attrs=...) at /home/rth/qemu/qemu/memory.c:483
> #4  0x00005555557b03d3 in access_with_adjusted_size
>     (addr=addr@entry=1050144, value=value@entry=0x7fffee3b4f08, size=size@entry=4, access_size_min=<optimized out>, access_size_max=<optimized out>, access_fn=access_fn@entry=
>     0x5555557b25f0 <memory_region_write_accessor>, mr=0x5555561058f0, attrs=...) at /home/rth/qemu/qemu/memory.c:539
> #5  0x00005555557b4b34 in memory_region_dispatch_write
>     (mr=mr@entry=0x5555561058f0, addr=addr@entry=1050144, data=<optimized out>, data@entry=0, op=op@entry=MO_BEUL, attrs=...)
>     at /home/rth/qemu/qemu/memory.c:1475
> #6  0x00005555557c18ed in io_writex
>     (env=env@entry=0x5555563a6b60, mmu_idx=mmu_idx@entry=4, val=val@entry=0, addr=addr@entry=4161799712, retaddr=140736415114886, op=MO_BEUL, iotlbentry=<optimized out>, iotlbentry=<optimized out>)
>     at /home/rth/qemu/qemu/accel/tcg/cputlb.c:977
> #7  0x00005555557c77bc in store_helper
>     (op=MO_BEUL, retaddr=140736415114886, oi=<optimized out>, val=0, addr=4161799712, env=0x5555563a6b60) at /home/rth/qemu/qemu/accel/tcg/cputlb.c:1716
> #8  0x00005555557c77bc in helper_be_stl_mmu
>     (env=0x5555563a6b60, addr=4161799712, val=0, oi=<optimized out>, retaddr=140736415114886) at /home/rth/qemu/qemu/accel/tcg/cputlb.c:1842
> #9  0x00007fffc007a686 in code_gen_buffer ()

