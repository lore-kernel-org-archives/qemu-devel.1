Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EB9C4BA12
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA1052467F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 13:08:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA1052467F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6wQC-0003zp-TZ
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 08:08:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51357)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1j6wPY-0003O8-3l
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:07:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1j6wPW-0008Ov-CM
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 08:07:35 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:40256)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1j6wPV-00085c-MW; Wed, 26 Feb 2020 08:07:34 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id AFD84747E03;
 Wed, 26 Feb 2020 14:07:23 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8BABB747E02; Wed, 26 Feb 2020 14:07:23 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 8A0E9747E00;
 Wed, 26 Feb 2020 14:07:23 +0100 (CET)
Date: Wed, 26 Feb 2020 14:07:23 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
In-Reply-To: <87mu95y1le.fsf@linaro.org>
Message-ID: <alpine.BSF.2.22.395.2002261355500.81576@zero.eik.bme.hu>
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <d9d4fba7-2dcf-8f09-8f3a-7e0408c297b6@linaro.org>
 <alpine.BSF.2.22.395.2002211643480.45267@zero.eik.bme.hu>
 <CAFEAcA-teH7KXACL=5m0-X+g692EXKtqOy9d_uGjw6XA8S3vzA@mail.gmail.com>
 <alpine.BSF.2.22.395.2002211807380.69986@zero.eik.bme.hu>
 <CAFEAcA9-VzUXij1_vFr+d7KuMOw+Tdv0hvxW2WmfGxt=fAKvjg@mail.gmail.com>
 <alpine.BSF.2.22.395.2002212034570.8472@zero.eik.bme.hu>
 <87mu95y1le.fsf@linaro.org>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-712543236-1582722443=:81576"
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 John Arbuckle <programmingkidx@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paul Clarke <pc@us.ibm.com>, Howard Spoelstra <hsp.cat7@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-712543236-1582722443=:81576
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Wed, 26 Feb 2020, Alex Benn=C3=A9e wrote:
> BALATON Zoltan <balaton@eik.bme.hu> writes:
>> OK, then how about keeping the default accurate but allow to opt in to
>> use FPU even if it's known to break some bits for workloads where
>> users would need speed over accuracy and would be happy to live with
>> the limitation.
>
> About the only comparison I can think of is the thread=3Dsingle:multi
> flags for TCG which is mostly there to help developers eliminate causes
> of bugs. The default for MTTCG is it is enabled when it's safe. If you
> enable it via the command line where QEMU hasn't defaulted it on you
> will get lots of loud warnings about potential instability. The most
> commonly used case is thread=3Dsingle when you want to check it's not a
> MTTCG bug.
>
> I'm as cautious as Peter here about adding a "faster but broken" comman=
d
> line flag because users will invariably read up to the "faster" and the=
n
> spend a lot of time scratching their heads when things break.

OK understood. However this is specifically about PPC emulation where som=
e=20
bits exists in FPSCR that's hard to emulate with hardfloat but until=20
recently these weren't correctly emulated in my understanding and things=20
still ran OK so it's believed that these bits are seldom used. It was onl=
y=20
fixed due to some tests revealing it not because of actual negative=20
effects seen.

Unfortunately enabling hardfloat without any other changes would make the=
=20
default softfloat case a bit slower so that's why I was asking about also=
=20
making hardfloat case the default.

I can try to try some other approach to avoid always setting inexact bit=20
and only keep it set as other archs do but not sure when will I have time=
=20
to get there. Some help in this would be appreciated by those who know PP=
C=20
FPU and interested in running it faster in QEMU.

Regards,
BALATON Zoltan
--3866299591-712543236-1582722443=:81576--

