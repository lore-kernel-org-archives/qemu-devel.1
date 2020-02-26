Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D74C4BA2D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:52:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1052072D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:52:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1052072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j75Xe-00033a-6l
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 17:52:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38569)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j75WJ-0001cM-PU
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:51:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j75WI-0003Lm-0J
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:51:11 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:42890)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j75WH-00038g-Pn; Wed, 26 Feb 2020 17:51:09 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id BF4AC74637D;
 Wed, 26 Feb 2020 23:51:05 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 98BA37461AE; Wed, 26 Feb 2020 23:51:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 96A3E74569F;
 Wed, 26 Feb 2020 23:51:05 +0100 (CET)
Date: Wed, 26 Feb 2020 23:51:05 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: R: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
In-Reply-To: <87eeuhxw0y.fsf@linaro.org>
Message-ID: <alpine.BSF.2.22.395.2002262311370.39102@zero.eik.bme.hu>
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <CD566CEF-6844-455C-B9C7-E5DFDE50E770@gmail.com>
 <alpine.BSF.2.22.395.2002191538190.33319@zero.eik.bme.hu>
 <1BC2E9E9-A694-4ED3-BD3D-D731F23B7245@gmail.com>
 <alpine.BSF.2.22.395.2002251241080.22173@zero.eik.bme.hu>
 <3539F747-145F-49CC-B494-C9794A8ABABA@gmail.com>
 <AM6PR03MB5525DE221E3E7E595893DF4DC8EA0@AM6PR03MB5525.eurprd03.prod.outlook.com>
 <AM4PR07MB350651FBB263FEEDB857CBFFCAEA0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <87eeuhxw0y.fsf@linaro.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1146421166-1582757465=:39102"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: qemu-devel@nongnu.org, Programmingkid <programmingkidx@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>, luigi burdo <intermediadc@hotmail.com>,
 Dino Papararo <skizzato73@msn.com>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1146421166-1582757465=:39102
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Feb 2020, Alex Benn=C3=A9e wrote:
> That's the wrong way around. We have regression tests for a reason. I'l=
l
> happily accept patches to turn on hardfloat for PPC if:
>
> a) they don't cause regressions in our fairly extensive floating point
> tests

Where are these tests and how to run them? I'm not aware of such tests so=
=20
I've only tried running simple guest code to test changes but if there ar=
e=20
more extensive FP tests I'd better use those.

> b) the PPC maintainers are happy with the new performance profile
>
> The way forward would be to:
>
> 1. patch to drop #if defined(TARGET_PPC) || defined(__FAST_MATH__)

This is simple but I've found that while it seems to make some vector=20
instructions faster it also makes most simple FP ops slower because it=20
will go thorugh checking if it can use hardfloat but never can because th=
e=20
fp_status is cleared before every FP op. That's why I've set inexact bit=20
to let it use hardfloat and be able to test if it would work at all.=20
That's all my RFC patch did, I've had a 2nd version trying to avoid slow=20
down with above #if defined() dropped but hardfloat=3Dfalse so it only us=
es=20
softfloat as before but it did not worked out too well, some tests said v=
2=20
was even slower. Maybe to avoid overhead we should add a variable instead=
=20
of the QEMU_NO_HARDFLOAT define that can be set during runtime but=20
probably that won't be faster either. Thus it seems there's no way to=20
enable hardfloat for PPC and not have slower performance for most FP ops=20
without also doing some of the other points below (even if it's beneficia=
l=20
for vector ops).

> 2. audit target/ppc/fpu_helper.c w.r.t chip manual and fix any unneeded
> splatting of flags (if any)

This would either need someone who knows PPC FPU or someone who can take=20
the time to learn and go through the code. Not sure I want to volunteer=20
for that. But I think the clearing of the flags is mainly to emulate FI=20
bit which is an non-sticky inexact bit that should show the inexact statu=
s=20
of last FP op. (There's another simliar bit for fraction rounded as well=20
but that does not disable hardfloat.) Question is if we really want to=20
accurately emulate these bits? Are there any software we care about=20
relying on these? If we can live with not having correct FI bit emulation=
=20
(which was the case for a long time until these were fixed) then we could=
=20
have an easy way to enable hardfloat without more extensive changes. If w=
e=20
want to accurately emulate also these bits then we probably will need=20
changes to softfloat to allow registering FP exception handlers so we=20
don't have to clear and check bits but can get an exception from FPU and=20
then can set those bits but I have no idea how to do that.

Regards,
BALATON Zoltan
--3866299591-1146421166-1582757465=:39102--

