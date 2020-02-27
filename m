Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB01C4BA37
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD90D222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 02:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YhQ9oxFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD90D222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j79DR-0003Fw-WF
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 21:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1j799d-0000a2-BT
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:44:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1j799c-00040p-44
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 21:44:01 -0500
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42]:38746)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1j799b-0003r3-TN; Wed, 26 Feb 2020 21:44:00 -0500
Received: by mail-yw1-xc42.google.com with SMTP id 10so1665213ywv.5;
 Wed, 26 Feb 2020 18:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=EyHoyQjXvYcvJ8Og7Fj6dWE/IvMVWGSMfLOGft9NDmQ=;
 b=YhQ9oxFy3sLy2eypHoR+97Yuy+UXYg8WaYqlFXBUkhixK4La5BlQP8KoJqOKu3FQ4j
 xZEvpkzYuED0VuRYCfBP5fai+HwbyZlOo2MjPM7Py6Lfo0olXhDOaEMvVVclSletngFY
 zZCWNqX9q39Kgx5DJVQlHWWidwW8TO+w1IQSa8IHn2BOsfnV4oQbLbXekc21O+67s4l4
 nwB9xF2EMP9ZPDg/5y2JjWYVXF/0bqn6rwUxW0URt53FbnLJObLnR7kGScf/uW3mPGRf
 HkCjlvg+e3sTLI5ds8dLAmHC+Kg225AGCTA6JyzeOjmzXWmfh5PmPXIbcHsjqvwLbEzU
 L3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=EyHoyQjXvYcvJ8Og7Fj6dWE/IvMVWGSMfLOGft9NDmQ=;
 b=S3a6kWCtZkb0qWn1d5ik+pV+GHAGpBPJDASw+ALdG3UPlFLiIUNz2tBHXEHJ8+z15H
 w9UbZKcIzHof4gWSGLYNJrrf0qRPwBTesqRZg+6GU2LW7OMCGOHDxjC94esr0m+simSX
 zu/CsZsfZvfSaybb7jDXCxdhKJVRXMpekGJRixq1iQlVRiNfOHAf0KUUuNCgUubAPyS+
 MNqFT7hliRpODhwyG/s41kL+2JnE63sCTh0lOzap9F8BpyvP0/RzK/r6mPFptxLCySpW
 RLvJNP8ZZJEbF5uOioHwzKe26KxSAUPRiqS6GCoO9YO3BaSTlOjWv3U7P7siB6gE3ijB
 feRg==
X-Gm-Message-State: APjAAAWAFWD7OO17n4ep8xrFgjl1ePhnVzyzL4YkoeBujK7wIvI8EDiO
 xeWyW4nUpe4VDt083iYrfHs=
X-Google-Smtp-Source: APXvYqwFcBsAtLwAkTBWOkJX6jDBacKxK1SIP/JmNhhksGQeCGIqxzERjWeWrLr0ajWJ+sF6aqNU4Q==
X-Received: by 2002:a25:be06:: with SMTP id h6mr1749179ybk.61.1582771437729;
 Wed, 26 Feb 2020 18:43:57 -0800 (PST)
Received: from [192.168.0.5] (d149-67-30-58.try.wideopenwest.com.
 [67.149.58.30])
 by smtp.gmail.com with ESMTPSA id a202sm1891666ywe.8.2020.02.26.18.43.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Feb 2020 18:43:56 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
From: Programmingkid <programmingkidx@gmail.com>
In-Reply-To: <CAL1e-=hhhw4x4H24DWg6pTp9DmjyfwM6GFMOmWasKC66x5tR4Q@mail.gmail.com>
Date: Wed, 26 Feb 2020 21:43:55 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <2126C4B4-B0F2-4B0F-ADEC-211466989E36@gmail.com>
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <CD566CEF-6844-455C-B9C7-E5DFDE50E770@gmail.com>
 <alpine.BSF.2.22.395.2002191538190.33319@zero.eik.bme.hu>
 <1BC2E9E9-A694-4ED3-BD3D-D731F23B7245@gmail.com>
 <alpine.BSF.2.22.395.2002251241080.22173@zero.eik.bme.hu>
 <3539F747-145F-49CC-B494-C9794A8ABABA@gmail.com>
 <AM6PR03MB5525DE221E3E7E595893DF4DC8EA0@AM6PR03MB5525.eurprd03.prod.outlook.com>
 <AM4PR07MB350651FBB263FEEDB857CBFFCAEA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <87eeuhxw0y.fsf@linaro.org>
 <CAL1e-=gGsEV4_a4gJr2x0L3r_UK7isnpjOWoJRCDhqpG_XT3Ww@mail.gmail.com>
 <CAKyx-3MCENJREWm0BxO3ES9sDB04KV3FzYoVFKK20Fh_iwh7wg@mail.gmail.com>
 <CAL1e-=hhhw4x4H24DWg6pTp9DmjyfwM6GFMOmWasKC66x5tR4Q@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c42
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
Cc: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, luigi burdo <intermediadc@hotmail.com>,
 Dino Papararo <skizzato73@msn.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On Feb 26, 2020, at 12:27 PM, Aleksandar Markovic =
<aleksandar.m.mail@gmail.com> wrote:
>=20
> On Wed, Feb 26, 2020 at 6:04 PM G 3 <programmingkidx@gmail.com> wrote:
>>=20
>> Accuracy is an important part of the IEEE 754 floating point =
standard. The whole purpose of this standard is to ensure floating point =
calculations are consistent across multiple CPUs. I believe referring to =
this patch as inaccurate is itself inaccurate. That gives the impression =
that this patch produces calculations that are not inline with =
established standards. This is not true. The only part of this patch =
that will produce incorrect values are the flags. There *may* be a =
program or two out there that depend on these flags, but for the =
majority of programs that only care about basic floating point =
arithmetic this patch will produce correct values. Currently the =
emulated PowerPC's FPU already produces wrong values for the flags. This =
patch does set the Inexact flag (which I don't like), but since I have =
never encountered any source code that cares for this flag, I can let it =
go. I think giving the user the ability to decide which option to use is =
the best thing to do.
>>=20
>=20
> =46rom the experiments described above, the patch in question changes =
the behavior
> of applications (for example, sound is different with and without the
> patch), which is
> in contradiction with your claim that you "never encountered any
> source code that
> cares for this flag" and that "the only part of this patch that will
> produce incorrect
> values are the flags".
>=20
> In other words, and playing further with them:
>=20
> The claim that "referring to this patch as inaccurate is itself
> inaccurate" is itself inaccurate.
>=20
> Best regards,
> Aleksandar

It is inaccurate to state that just because the USB audio device seems =
to play better with the hardfloat feature enabled that this changes the =
fact that I have yet to see any source code that actually reviews the =
flags. I have reviewed both the USB audio device and Apple's =
AppleUSBAudio class code and have not seen any mention of the exception =
flags.=20


