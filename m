Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9DAC35DEE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 03:07:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D85AB22525
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 03:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe7eGmzv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85AB22525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6QZc-00007L-1X
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 22:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1j6QYx-00081v-3X
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:07:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1j6QYv-0002H5-7z
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 22:07:11 -0500
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:35519)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1j6QYv-0002G8-2n; Mon, 24 Feb 2020 22:07:09 -0500
Received: by mail-yw1-xc44.google.com with SMTP id i190so6447916ywc.2;
 Mon, 24 Feb 2020 19:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=NbUeFaSg0C5X62e8QRnrtiyK1p6W25fLbDyd7UPOuFc=;
 b=Qe7eGmzvo/OcblWJAG5VioPq9Xg5qMjRmI8TfP33s84vH2mE9heILL9ZME/W63hAma
 V/WNoOrTDTBWQceXkD9Ju/y+7/keX5cCE4Jci+v8Bl50BzWtR6Hi4QGFiWKy/EvLVXj5
 F65KRSSDZhuszFxeZZQ+HNpXppR0EXASI0LmebsgBkBNDGU8XlTaIQOAV7saSIrLZb0L
 T+gZDmGoF9WPUvXx6RnvuNXkfp00m2bu0bt40ltKImgH09oKt3bJYJJxYF/qyWsgIu6h
 /PtmUoNwgnGW2VWnbgOlYAwPkZlEugHaXzngnA4kEPKhj/rTLDzMA0YtEGTvH5qzOLKN
 Dm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=NbUeFaSg0C5X62e8QRnrtiyK1p6W25fLbDyd7UPOuFc=;
 b=M4Uz8dnNxS0Pirutl3bS+sn0Q7QTY2Zs0Brub+7AEmbPTgwLpZXTeMsr0UTHDUaa32
 SQqP3Dp5dZAjwRiO8c7RABrvVtokNRI0AjrRVwIyl+8u1FQO+6BvcGDbfVIGaqGzdeEY
 IiScZKElerfNEjwb9KU47L6u+ZAVFAZ2WRbFeptRPwbcARqrnBWI8fsGaxTi18PCB4F5
 fVJsLc13lpQFafnOVuwRdTFHdMTc1LF5LzUjM8DuW3EVPcOD/5WtUzLw/N2Pm8j3h/gw
 1GkV9iaxDlWdn3O6J3G8/qawf1XUP2rZk6Wk/x4SjW+3Jm03n7zx8mZvPzDumYzo5cej
 2DAg==
X-Gm-Message-State: APjAAAXIIMUGUqsCnH5Q3BdR9P2uT499FhpPNVanbJvXnsfRwdmI31Sg
 KKLGmxYXGEIE5izx/ATCmgo=
X-Google-Smtp-Source: APXvYqygGvlU6FzlTekjT+il2Vbs2+1eohlfLaep+CFHHc/RKwqNuVYDOrzk35kXjILsdDJcX/vKlg==
X-Received: by 2002:a81:f4b:: with SMTP id 72mr44254770ywp.251.1582600027856; 
 Mon, 24 Feb 2020 19:07:07 -0800 (PST)
Received: from [192.168.0.5] (d149-67-30-58.try.wideopenwest.com.
 [67.149.58.30])
 by smtp.gmail.com with ESMTPSA id a74sm5764242ywe.42.2020.02.24.19.07.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 24 Feb 2020 19:07:06 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <alpine.BSF.2.22.395.2002191538190.33319@zero.eik.bme.hu>
Date: Mon, 24 Feb 2020 22:07:05 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <1BC2E9E9-A694-4ED3-BD3D-D731F23B7245@gmail.com>
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <CD566CEF-6844-455C-B9C7-E5DFDE50E770@gmail.com>
 <alpine.BSF.2.22.395.2002191538190.33319@zero.eik.bme.hu>
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc@nongnu.org,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>, Paul Clarke <pc@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On Feb 19, 2020, at 10:35 AM, BALATON Zoltan <balaton@eik.bme.hu> =
wrote:
>=20
> Hello,
>=20
> On Tue, 18 Feb 2020, Programmingkid wrote:
>>> On Feb 18, 2020, at 12:10 PM, BALATON Zoltan <balaton@eik.bme.hu> =
wrote:
>>> While other targets take advantage of using host FPU to do floating
>>> point computations, this was disabled for PPC target because always
>>> clearing exception flags before every FP op made it slightly slower
>>> than emulating everyting with softfloat. To emulate some FPSCR bits,
>>> clearing of fp_status may be necessary (unless these could be =
handled
>>> e.g. using FP exceptions on host but there's no API for that in QEMU
>>> yet) but preserving at least the inexact flag makes hardfloat usable
>>> and faster than softfloat. Since most clients don't actually care
>>> about this flag, we can gain some speed trading some emulation
>>> accuracy.
>>>=20
>>> This patch implements a simple way to keep the inexact flag set for
>>> hardfloat while still allowing to revert to softfloat for workloads
>>> that need more accurate albeit slower emulation. (Set hardfloat
>>> property of CPU, i.e. -cpu name,hardfloat=3Dfalse for that.) There =
may
>>> still be room for further improvement but this seems to increase
>>> floating point performance. Unfortunately the softfloat case is =
slower
>>> than before this patch so this patch only makes sense if the default
>>> is also set to enable hardfloat.
>>>=20
>>> Because of the above this patch at the moment is mainly for testing
>>> different workloads to evaluate how viable would this be in =
practice.
>>> Thus, RFC and not ready for merge yet.
>>>=20
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>> v2: use different approach to avoid needing if () in
>>> helper_reset_fpstatus() but this does not seem to change overhead
>>> much, also make it a single patch as adding the hardfloat option is
>>> only a few lines; with this we can use same value at other places =
where
>>> float_status is reset and maybe enable hardfloat for a few more =
places
>>> for a little more performance but not too much. With this I got:
>>=20
>> <snip>
>>=20
>> Thank you for working on this. It is about time we have a better FPU.
>=20
> Thank you for testing it. I think it would be great if we could come =
up with some viable approach to improve this before the next freeze.
>=20
>> I applied your patch over David Gibson's ppc-for-5.0 branch. It =
applied cleanly and compiled easily.
>=20
> I've heard some preliminary results from others that there's also a =
difference between v1 and v2 of the patch in performance where v1 may be =
faster for same cases so if you (or someone else) want and have time you =
could experiment with different versions and combinations as well to =
find the one that's best on all CPUs. Basically we have these parts:
>=20
> 1. Change target/ppc/fpu_helper.c::helper_reset_fpstatus() to force =
float_flag_inexact on in case hadfloat is enabled, I've tried two =
approaches for this:
>=20
> a. In v1 added an if () in the function
> b. In v2 used a variable from env set earlier (I've hoped this may be =
faster but maybe it's not, testing and explanation is welcome)
>=20
> 2. Also change places where env->fp_status is copied to a local tstat =
and then reset (I think this is done to accumulate flags from multiple =
FP ops that would individually reset env->fp_status or some other =
reason, maybe this could be avoided if we reset fp_status less often but =
that would need more understanding of the FP emulation that I don't have =
so I did not try to clean that up yet).
>=20
> If v2 is really slower than v1 then I'm not sure is it because also =
changing places with tstat or because of the different approach in =
helper_reset_fpstatus() so you could try combinations of these as well.
>=20
>> Tests were done on a Mac OS 10.4.3 VM. The CPU was set to G3.
>=20
> What was the host CPU and OS this was tested on? Please always share =
CPU info and host OS when sharing bechmark results so they are somewhat =
comparable. It also depends on CPU features for vector instrucions at =
least so without CPU info the results could not be understood.

Intel Core i5-2500S CPU @ 2.70GHz.

> I think G3 does not have AltiVec/VMX so maybe testing with G4 would be =
better to also test those ops unless there's a reason to only test G3. =
I've tested with G4 both FPU only and FPU+VMX code on Linux host with =
i7-9700K CPU @ 3.60GHz as was noted in the original cover letter but may =
be I'va also forgotten some details so I list it here again.

Ok, I did test on the G4, here are my results:

Git commit: c1e667d2598b9b3ce62b8e89ed22dd38dfe9f57f
Mac OS 10.4.3 VM
-cpu G4
-USB audio device

Hardfloat=3Dfalse
Audio sounds bad when playing midi file.
Extraction rate: 1.5x
Converting rate: 0.7x
Total time: 7:24

Hardfloat=3Dtrue
Midi audio sounded perfect for about 30 seconds, then it went silent!
Extraction rate: 1.4x (slower with hard float)
Converting rate: 0.7x (same as without hardfloat)
Total time: 7:16 (faster time with hardfloat)

>=20
>> I did several tests and here are my results:
>>=20
>> With hard float:
>> - The USB audio device does not produce any sound.
>=20
> I've heard this could also be due to some other problem not directly =
related to FPU, maybe there's a problem with USB/OHCI emulation as well =
because problems with that were reported but it's interesting why you =
get different results changing FPU related stuff. I think OSX uses float =
samples so probably does use FPU for processing sound and may rely on =
some pecularity of the hardware as it was probably optimised for Apple =
hardware. It would be interesting to find out how FPU stuff is related =
to this but since it's broken anyway probably not a show stopper at the =
moment.

When I played sound this second time I hard the same broken audio I =
usually hear with the USB audio device with hardfloat set to false. When =
playing the same midi file with hardfloat set to true, the audio played =
perfectly! It only played for 30 seconds before it went silent.

>=20
>> - Converting a MIDI file to AAC in iTunes happens at 0.4x (faster =
than soft float :) ).
>=20
> Does resulting file match? As a simple test I've verified md5sum of =
the resulting mp3 with the lame benchmark I've tried just to find any =
big errors. Even if it does not prove that nothing broke, it shuold =
detect if something breaks badly. However that was WAV->MP3 where =
results were same, although the VMX build did produce different result =
than FPU only but did so consistently for multiple runs. With MIDI there =
might be slight timing difference that could cause different audio =
results so you should first verify if doing the conversion multiple =
times does produce the same result at all without any patch first.

The md5 number for each file does match. Note this time I converted a =
midi file to MP3.

>=20
>> For my FPSCR test program, 21 tests failed. The high number is =
because the inexact exception is being set for situations it should not =
be set for.
>=20
> Since we force the inexact flag to be set to enable hardfloat this is =
expected. More interesting is if apart from this are there any =
difference in the results compared to the soffloat case (that may also =
be host CPU dependent I think). Do you have more detailed info on the =
errors and differences found?

I can give you the full testing suite if you like. I run it on Mac OS =
10.4 but it should compile with gcc on Linux. I will send it to you in a =
separate email because it is big.

<snip>

>> With soft float: - Some sound can be heard from the USB audio device. =
It isn't good sounding. I had to force quit Quicktime player because it =
stopped working.
>> - Converting a MIDI file to AAC in iTunes happens at 0.3x (slower =
than hard float).
>> - 13 tests failed with my FPSCR test program.
>>=20
>> This patch is a good start. I'm not worried about the Floating Point =
Status and Control Register flags being wrong since hardly any software =
bothers to check them. I think more optimizations can happen by
>=20
> I don't know if guest code checks fpscr and what flags it cares about. =
Also don't know if it's a fact that these are not used but maybe if we =
test with more guest codes we can find out. That's why I'd like to at =
least have an option to test with hardfloat. Unfortunately enabling =
hardfloat without also making it default would make it slower so if we =
go this way we should make sure we can also enable hardfloat as default.
>=20
>> simplifying the FPU. As it is now it makes a lot of calls per =
operation.
>=20
> Question is if those calls are really needed to emulate PPC FPU or if =
not why would they be there? If the FPU is really that much different so =
all these calls are needed then there's not much to simplify (but maybe =
there could be some optimisations possible). This would need someone to =
understand the current code in full first that probably we don't =
currently (ar least I don't for sure so can't really make changes =
either). Another more viable approach is to pick a small part and follow =
through with that and try to clean up and optimise that small part only. =
The exception and fpscr handling is one such part, another could be =
round_canonical() that seems to be high on profiles I've taken. Maybe =
this could be done by reading and understading docs only on the small =
part picked that may be easier than getting everything first. I wonder =
if such smaller tasks could be defined and given out as GSoC or other =
volunteer projects?

I have another idea on how to improve QEMU's performance. What if you =
enabled more CPUs for the PowerPC target? Mac OS 9, Mac OS X, and Linux =
support multiple CPUs. It might actually be easier to do this than to =
improve the FPU. I imagine the performance increase with multiple =
emulated CPUs would be much more noticeable.=20


