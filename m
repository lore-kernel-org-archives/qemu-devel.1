Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E649C34031
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 02:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1870520801
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 02:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYTJmXzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1870520801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4F62-0003Fx-4z
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 21:28:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46366)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1j4F5J-0002Yq-TH
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 21:27:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1j4F5I-0003WJ-Jm
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 21:27:33 -0500
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:45286)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1j4F5I-0003VW-DC; Tue, 18 Feb 2020 21:27:32 -0500
Received: by mail-yw1-xc44.google.com with SMTP id a125so10404907ywe.12;
 Tue, 18 Feb 2020 18:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=HmXatRJhOMItblAMqCpNbDrkco7ZHzqDM/SJbCfIibQ=;
 b=QYTJmXzvHHkARK2u+jYwK6C08hGBi7qkCGdg4hwerL6/okee7zdYkZHCwH/ZUPsNg0
 AM84r+Pk+ysaO4l8Sl8p8PydARxOImzonkBQWj5gWJwjvdRwSKsciOI9Cs8OB7W29d6O
 SiSa53uVwkHWZo4IudUIeYnm5Q9GrjPcRT0bdocvgvnoiPav9GLCmlBf4lQpN3Jd9kNQ
 wi24TLgngikRjDWjXRNG/51+4akNWyH7usJvr4t6JpyzY119xI2kEv0fl5lfMTEGimw4
 Y1W0w196BP10U/TuQzgdSjOwt5hnLuO1gykf98LjY4D5hqY6Z5Tk87cjtMh5JGjwzUWA
 ywRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=HmXatRJhOMItblAMqCpNbDrkco7ZHzqDM/SJbCfIibQ=;
 b=mzgYDJXWDYH4zmdd6CXxqDAkzHjA6Y2nS5QPXNegfsVNKf9oFZW8J6R2lTOgTLR9Dn
 XDLyq7Z+24ClgiwbCs4+S/0xe7eIQnKOaUtCG6kyT6VuoP/DiKluUXT3cGs5SHX7G1zp
 gAsAFn3p6rBbddmSGTNYv9mEDAUuM8G92s5t1D2W3z4gupHNgyPzFtmeXPWcKhsqQg8b
 ROMHGGUseS3Ule8nt02lTvbqVPpR7HkYn/jCMEr3Fa2JbjEi08IHjwlTyW6lqr4FwHWF
 Gr0szFq7yHfWao2UF4dnV/gUzZtwYHMJCI8Gl0IY5s92NNfud+iuynbXmWhqjJl3RwDV
 /h7g==
X-Gm-Message-State: APjAAAUdTw2cNnyk6f7g95XHG9dkh4Zd8p0fd7MZA8V4FWLTb31PwURC
 IsM9PCigOjy0f6YSDcs1PBw=
X-Google-Smtp-Source: APXvYqwwKjoiuzE049oUm0e4WPM6LqIW3r3O/u8ccmMelPyK6q2LGf0Hcht8yf6aFUfXeVyMMLIpSA==
X-Received: by 2002:a81:4c48:: with SMTP id z69mr21303729ywa.152.1582079251242; 
 Tue, 18 Feb 2020 18:27:31 -0800 (PST)
Received: from [192.168.0.5] (d149-67-30-58.try.wideopenwest.com.
 [67.149.58.30])
 by smtp.gmail.com with ESMTPSA id u127sm297265ywb.68.2020.02.18.18.27.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 18 Feb 2020 18:27:30 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <20200218171702.979F074637D@zero.eik.bme.hu>
Date: Tue, 18 Feb 2020 21:27:28 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <CD566CEF-6844-455C-B9C7-E5DFDE50E770@gmail.com>
References: <20200218171702.979F074637D@zero.eik.bme.hu>
To: BALATON Zoltan <balaton@eik.bme.hu>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>, qemu-ppc@nongnu.org,
 Paul Clarke <pc@us.ibm.com>, Howard Spoelstra <hsp.cat7@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On Feb 18, 2020, at 12:10 PM, BALATON Zoltan <balaton@eik.bme.hu> =
wrote:
>=20
> While other targets take advantage of using host FPU to do floating
> point computations, this was disabled for PPC target because always
> clearing exception flags before every FP op made it slightly slower
> than emulating everyting with softfloat. To emulate some FPSCR bits,
> clearing of fp_status may be necessary (unless these could be handled
> e.g. using FP exceptions on host but there's no API for that in QEMU
> yet) but preserving at least the inexact flag makes hardfloat usable
> and faster than softfloat. Since most clients don't actually care
> about this flag, we can gain some speed trading some emulation
> accuracy.
>=20
> This patch implements a simple way to keep the inexact flag set for
> hardfloat while still allowing to revert to softfloat for workloads
> that need more accurate albeit slower emulation. (Set hardfloat
> property of CPU, i.e. -cpu name,hardfloat=3Dfalse for that.) There may
> still be room for further improvement but this seems to increase
> floating point performance. Unfortunately the softfloat case is slower
> than before this patch so this patch only makes sense if the default
> is also set to enable hardfloat.
>=20
> Because of the above this patch at the moment is mainly for testing
> different workloads to evaluate how viable would this be in practice.
> Thus, RFC and not ready for merge yet.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> v2: use different approach to avoid needing if () in
> helper_reset_fpstatus() but this does not seem to change overhead
> much, also make it a single patch as adding the hardfloat option is
> only a few lines; with this we can use same value at other places =
where
> float_status is reset and maybe enable hardfloat for a few more places
> for a little more performance but not too much. With this I got:

<snip>

Thank you for working on this. It is about time we have a better FPU.=20

I applied your patch over David Gibson's ppc-for-5.0 branch. It applied =
cleanly and compiled easily.

Tests were done on a Mac OS 10.4.3 VM. The CPU was set to G3.=20

I did several tests and here are my results:

With hard float:
- The USB audio device does not produce any sound.=20
- Converting a MIDI file to AAC in iTunes happens at 0.4x (faster than =
soft float :) ).
For my FPSCR test program, 21 tests failed. The high number is because =
the inexact exception is being set for situations it should not be set =
for.

With soft float:
- Some sound can be heard from the USB audio device. It isn't good =
sounding. I had to force quit Quicktime player because it stopped =
working.
- Converting a MIDI file to AAC in iTunes happens at 0.3x (slower than =
hard float).
- 13 tests failed with my FPSCR test program.

This patch is a good start. I'm not worried about the Floating Point =
Status and Control Register flags being wrong since hardly any software =
bothers to check them. I think more optimizations can happen by =
simplifying the FPU. As it is now it makes a lot of calls per operation.


