Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522F6C34056
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 18:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D45320801
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 18:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvhB/TQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D45320801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4U6D-0003z5-AR
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 13:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1j4U5X-0003Fn-K9
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 13:28:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1j4U5W-0006iA-Cr
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 13:28:47 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34801)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>)
 id 1j4U5W-0006hj-89; Wed, 19 Feb 2020 13:28:46 -0500
Received: by mail-oi1-x242.google.com with SMTP id l136so24785878oig.1;
 Wed, 19 Feb 2020 10:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZlTooY9JnCeeFTSOwD1i7Ep64fCY48CGjZmnCvHvtz8=;
 b=NvhB/TQaQ3LkdzIdfQfaXWeqGe2y6ATLLNGsKwVJs8+sM2CRkaFJlg23UWG7BzvlGq
 rTNA190P6582D4DnzLP30Gl1FOpmlCytVlodn67lLZejdsu6X6aKA8+hukUCLonntKv8
 J+0TzFWVCsIgmBhdyuNt+Wmy5hWnosfpddqP+XyY2kwwoxv7uAVz/+Hp9qqRlVjl55gg
 wMnXbUklRfzz03xUQkpM49Hr0b2UbMeEboP4Mrb+tkqPPRMGG8PDVooqrQCRR1FlvF/S
 qJKeMk92EcQ5P/tOOgwcVxwASk6Ix/yspzsawWaTHdgNpwNCYBA+1OTX6NlPVkpOfmgp
 9XuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZlTooY9JnCeeFTSOwD1i7Ep64fCY48CGjZmnCvHvtz8=;
 b=B35TB1KxVowqDgd7frn8YcVHZ3IdKRc8DC/lYbXSr1pmxjXMpFRUzt/al1CGcM6SuI
 BgOtlMLGUK/DDarRVDw6H+7/Lir4lo2eCbOa1AAO0Nz+xL5VT0m9gy3pmffWLCwkyErE
 0ljHBtJwaZCeq6zb2zyrGiZGl2pCTx9m7voVu41y9zMnNnSB56sj0qvG0/nIiXpbodQX
 mZicZiA/59I6uXeTqD0/83e/Du2QQoxSpw5FMXDVyLCCiUSzAMLX3m+HtCsHf4nttDmp
 HNnM7lHtxCucE0xByYhz7vikHae9nCWGUTOdcnPSk6xBYuL7lAEngkzJBSxFLCTwZTON
 8qYQ==
X-Gm-Message-State: APjAAAVYg6QjgXpH3Q/v3lRYU/QyXbQvAXQFOTzZ5tTwUouDvIB7rpDI
 30NQo6Ff/zurlbupE+/LNUZ45VztYxX80U81tSE=
X-Google-Smtp-Source: APXvYqyK2lxuurR+ytB+jad3YF26hT+vJQ5SAE3ks3VnlsLo//g+eMvzoKMl0gi0bu/Oq3oHwZLJgwPDJCaaaCgW3xY=
X-Received: by 2002:aca:2407:: with SMTP id n7mr5544231oic.14.1582136924930;
 Wed, 19 Feb 2020 10:28:44 -0800 (PST)
MIME-Version: 1.0
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <CD566CEF-6844-455C-B9C7-E5DFDE50E770@gmail.com>
 <alpine.BSF.2.22.395.2002191538190.33319@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2002191538190.33319@zero.eik.bme.hu>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Wed, 19 Feb 2020 19:28:33 +0100
Message-ID: <CABLmASGhqbao0ngRAoHA7KBFA5CoMXLwaVh9wzv1Ec022FRjbQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: multipart/alternative; boundary="000000000000658538059ef1f5cb"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Programmingkid <programmingkidx@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>, Paul Clarke <pc@us.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000658538059ef1f5cb
Content-Type: text/plain; charset="UTF-8"

Hi,

I tested with the current ppc-for-5.0 branch and with v1 of the hardfloat
patches applied on top of that. There is a noticeable speed improvement in
Linux and OSX hosts. Windows 10 host doesn't seem to be impressed at all. I
saw no obvious glitches so far. The fpu performance on OSX hosts seems very
slow. This was not always the case in the past, when it was on par with
Linux performance.

Below are my results.

Best,
Howard

Host Linux (Fedora 31):
Mac OS tests: 9.2 with MacBench 5.0
Baseline(100%): G3 300Mhz
5.0 branch + hardfloat patches: cpu 193%, fpu 86%
5.0 branch: cpu 188%, fpu 57%
Mac OSX tests: 10.5 with Skidmarks 4.0 test
Baseline(100%): G4 1.0Ghz.
5.0 branch + hardfloat patches: Int:131 FP:11 Vec:15
5.0 branch: Int:131 FP:9 Vec:11

Host OSX Sierra:
Mac OS tests: 9.2 with MacBench 5.0
Baseline(100%): G3 300Mhz
5.0 branch + hardfloat patches: cpu 199%, fpu 66%
5.0 branch: cpu 199%, fpu 40%
Mac OSX tests: 10.5 with Skidmarks 4.0 test
Baseline(100%): G4 1.0Ghz.
5.0 branch + hardfloat patches: Int:129 PF:11 Vec:14
5.0 branch: Int:129 FP:8 Vec:9

Host Windows 10:
Mac OS tests: 9.2 with MacBench 5.0
Baseline(100%): G3 300Mhz
5.0 branch + hardfloat patches: cpu 180%, fpu 54%
5.0 branch: cpu 199%, fpu 40%
Mac OSX tests: 10.5 with Skidmarks 4.0 test
Baseline(100%): G4 1.0Ghz.
5.0 branch + hardfloat patches: Int:130 FP:9 Vec:10
5.0 branch: Int:130 FP:10 Vec:11

All tests done on the same host with v1 of the hardfloat patches
Intel i7-4770K at 3.50Ghz. 32Gb memory
All guests set to 1024x768 and "thousands" of colors.
Linux and OSX (with brew) use default compilers.
Windows build cross-compiled from Fedora with x86_64-win64-mingw32

Skidmarks test is a combination of tests:
ParseVid (INT)
MPEG (INT)
PixBlend (INT)
Ellipticrypt (INT)
Rijndael (INT)
Quicksort (INT)
MDCT (FP)
IntToFloat (FP)
Q3 (FP)
FFT (FP)
VolInt (FP)
Quant (VMX)
Galaxy (VMX)
IDCT (VMX)
BigMult (VMX)

--000000000000658538059ef1f5cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>I tested with the curren=
t ppc-for-5.0 branch and with v1 of the hardfloat patches applied on top of=
 that.=20
There is a noticeable speed improvement in Linux and OSX hosts. Windows 10 =
host doesn&#39;t seem to be impressed at all. I saw no obvious glitches so =
far. The fpu performance on OSX hosts seems very slow. This was not always =
the case in the past, when it was on par with Linux performance.<br></div><=
div><br></div><div>
Below are my results.

</div><div><br></div><div>Best,</div><div>Howard<br></div><div><br></div><d=
iv></div><div>Host Linux (Fedora 31):<br></div>Mac OS tests: 9.2 with MacBe=
nch 5.0<br>Baseline(100%): G3 300Mhz<br>5.0 branch + hardfloat patches: cpu=
 193%, fpu 86%<br>5.0 branch: cpu 188%, fpu 57%<br>Mac OSX tests: 10.5 with=
 Skidmarks 4.0 test<br>Baseline(100%): G4 1.0Ghz.<br>5.0 branch + hardfloat=
 patches: Int:131 FP:11 Vec:15<br>5.0 branch: Int:131 FP:9 Vec:11<br><br>Ho=
st OSX Sierra:<br>Mac OS tests: 9.2 with MacBench 5.0<br>Baseline(100%): G3=
 300Mhz<br>5.0 branch + hardfloat patches: cpu 199%, fpu 66%<br>5.0 branch:=
 cpu 199%, fpu 40%<br>Mac OSX tests: 10.5 with Skidmarks 4.0 test<br>Baseli=
ne(100%): G4 1.0Ghz.<br>5.0 branch + hardfloat patches: Int:129 PF:11 Vec:1=
4<br>5.0 branch: Int:129 FP:8 Vec:9<br><br>Host Windows 10:<br>Mac OS tests=
: 9.2 with MacBench 5.0<br>Baseline(100%): G3 300Mhz<br>5.0 branch + hardfl=
oat patches: cpu 180%, fpu 54%<br>5.0 branch: cpu 199%, fpu 40%<br>Mac OSX =
tests: 10.5 with Skidmarks 4.0 test<br>Baseline(100%): G4 1.0Ghz.<br>5.0 br=
anch + hardfloat patches: Int:130 FP:9 Vec:10<br>5.0 branch: Int:130 FP:10 =
Vec:11<br><br>All tests done on the same host with v1 of the hardfloat patc=
hes<br>Intel i7-4770K at 3.50Ghz. 32Gb memory<br><div>All guests set to 102=
4x768 and &quot;thousands&quot; of colors.</div><div>Linux and OSX (with br=
ew) use default compilers.<br></div><div>Windows build cross-compiled from =
Fedora with x86_64-win64-mingw32</div><div><br></div>Skidmarks test is a co=
mbination of tests:<br>ParseVid (INT)<br>MPEG (INT)<br>PixBlend (INT)<br>El=
lipticrypt (INT)<br>Rijndael (INT)<br>Quicksort (INT)<br>MDCT (FP)<br>IntTo=
Float (FP)<br>Q3 (FP)<br>FFT (FP)<br>VolInt (FP)<br>Quant (VMX)<br>Galaxy (=
VMX)<br>IDCT (VMX)<br>BigMult (VMX) </div>

--000000000000658538059ef1f5cb--

