Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA57AC2D0C8
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 01:26:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F1420838
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 01:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vT6d4iU9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F1420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilNLc-00036w-Qc
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 20:26:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilNKg-0002UD-SJ
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 20:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilNKf-0006W1-ES
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 20:25:26 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40023)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilNKf-0006Nz-3X
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 20:25:25 -0500
Received: by mail-pl1-x643.google.com with SMTP id s21so10547912plr.7
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 17:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TuD/EAWeI0+iiutGAb6Nci9T/WsnQ5nQBBoSAWRpNfw=;
 b=vT6d4iU9KCiZ5XVt7MK9slYyHR53yJ4uZktdjCNIgPBuynPI9/ouW9CyGEmXzX1DoL
 6i4e58k3zbSJ7wD0qgjoZrP2U5I1tPvgqZ5MTyU1nv7D2+o98gPF46lv4DmSa0hlUgDa
 C1bYFlbq8Y0ZQa8fq+fNkOA0H4q456ggI2zjViFax8pPzT/9Z8h54Z+dIfuYf2L8l6mT
 KYsP89dJI2FvgAZbUTqbbrRaezciTtkwaWag6Jd8L1+GIFuBe6utMeZanzNiPUR31MJf
 mx5W4cfTxbySvLIaktbCofXv3DUJA8SiT7t6Nhq7VpTLhUQTMhzYQWifmM5o/uatxDzO
 AvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TuD/EAWeI0+iiutGAb6Nci9T/WsnQ5nQBBoSAWRpNfw=;
 b=eeWT51/BoPAFVvlcGa7dnULt6Yuy+0i4gXFQ5bmVvZy0IH8fJoXDWZDRajh2OSoqg6
 F8vt8VwHhjjfnT0Aeve8T1Ua0QOTSZjk2+XRvs7bJTQSuPA0cj+NowQfVpndbzPJfQr7
 AAZCV4AYTl0WDcFQ/HqEglpVM/NtLDOyx5PqYG/KDaynNULcEcxBJE7IeaNIzrM2NULm
 R9OF5wZQ3aiHf/wcEwBxBD2jD6EBnGufPlifxxXi4P1oZ6fI/fVdQcC6Y7UjYEJqIRPe
 QB3ZEfiJXxQofIHfxcAqX7HOtfr6AreaXVaeSbffQ0fayejArdBSQmS6DPiq4bxZNjdr
 m0dQ==
X-Gm-Message-State: APjAAAXb5q1K6h9eVjkhgn9PoPosDtPUukGk7sOh54SuPFXjX/HO2mVW
 go/024gNW9+pR6jqhHjopOqlPUKG0Ag=
X-Google-Smtp-Source: APXvYqxi5zUQ1gIET6Ii+K9ZWPS5Lxw5gdms3DxYZllUKDKDXvNCuCdeum5txmPmFWtG0ZAimPeqWg==
X-Received: by 2002:a17:902:fe8d:: with SMTP id
 x13mr61782345plm.232.1577582722811; 
 Sat, 28 Dec 2019 17:25:22 -0800 (PST)
Received: from [192.168.1.118] (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id l2sm26564104pff.59.2019.12.28.17.25.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2019 17:25:21 -0800 (PST)
Subject: Re: [PATCH v5 0/6] HPPA: i82596, PS/2 and graphics emulation
To: Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
References: <20191220211512.3289-1-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5ddcb764-6f39-9bb9-1e3e-83cf6401078d@linaro.org>
Date: Sun, 29 Dec 2019 12:25:16 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220211512.3289-1-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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

On 12/21/19 8:15 AM, Sven Schnelle wrote:
> these series adds quite a lot to the HPPA emulation in QEMU:
> i82596 emulation from Helge, PS/2 and Artist graphics emulation.
> 
> See https://parisc.wiki.kernel.org/index.php/Qemu for a few screenshots
> of QEMU running a X11/CDE session in HP-UX.
> 
> Changes in v5:
>  - fix a buffer overrun in vram_bit_write()
>  - improve STI line wraparound
> 
> Changes in v4:
>  - introduce Artist-internal address space
>  - rewrite screen update functions to use the generic framebuffer routines
>  - use dirty bitmap code to not always redraw the whole screen
> 
> Changes in v3:
>  - use BIT() macro in gsc_to_pci_forwarding()
>  - fix version id in vm state
>  - fix an error in the PS/2 KBD_CMD_SET_MAKE_BREAK implementation
> 
> Changes in v2:
>  - dropped 'hppa: remove ISA region' as that patch requires some more work
>  - added shortlog to seabios update
>  - use const and MAKE_64BIT_MASK in dino.c
> 
> Regards,
> Sven
> 
> Helge Deller (2):
>   hw/hppa/dino.c: Improve emulation of Dino PCI chip
>   hppa: Add support for LASI chip with i82596 NIC
> 
> Sven Schnelle (4):
>   ps2: accept 'Set Key Make and Break' commands
>   hppa: add emulation of LASI PS2 controllers
>   hppa: Add emulation of Artist graphics
>   seabios-hppa: update to latest version

Queued these 6.  I squashed Helge's -nographics fix into patch 5.

I cannot get my debian 8 install to boot to a prompt with the artist graphics
enabled.  I'm not sure if I need a newer kernel or what.  But it doesn't do
nothing either, so I'm a bit confused.

However, I have validated a boot of hpux-11.11, so any refinements that might
be required should be incremental.


r~

