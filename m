Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D3FC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7385E20724
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 15:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7385E20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCm4K-0003Ph-Mz
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 11:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <remi@remlab.net>) id 1jCm3f-0002fa-Bu
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <remi@remlab.net>) id 1jCm3d-0005EJ-Q2
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 11:17:07 -0400
Received: from poy.remlab.net ([2001:41d0:2:5a1a::]:50552
 helo=ns207790.ip-94-23-215.eu) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <remi@remlab.net>)
 id 1jCm3Z-000545-Tx; Fri, 13 Mar 2020 11:17:02 -0400
Received: from basile.remlab.net (87-92-31-51.bb.dnainternet.fi [87.92.31.51])
 (Authenticated sender: remi)
 by ns207790.ip-94-23-215.eu (Postfix) with ESMTPSA id 8C15F5FB07;
 Fri, 13 Mar 2020 16:16:59 +0100 (CET)
From: =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To: qemu-arm@nongnu.org
Subject: Re: [RFC] [PATCH 0/5] ARMv8.5-MemTag disassembly
Date: Fri, 13 Mar 2020 17:16:58 +0200
Message-ID: <3125680.9OkiO6kEAj@basile.remlab.net>
Organization: Remlab
In-Reply-To: <CAFEAcA_nGY4_UQ7jMdxuZXR=_rpVZVCAMX+UzEoFtSpcCVy9Dg@mail.gmail.com>
References: <2159383.tmy0LfLZHX@basile.remlab.net>
 <CAFEAcA_nGY4_UQ7jMdxuZXR=_rpVZVCAMX+UzEoFtSpcCVy9Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:41d0:2:5a1a::
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le perjantaina 13. maaliskuuta 2020, 16.03.36 EET Peter Maydell a =C3=A9cri=
t :
> On Fri, 13 Mar 2020 at 13:59, R=C3=A9mi Denis-Courmont <remi@remlab.net> =
wrote:
> >         Hello,
> >=20
> > The following changes since commit=20
d4f7d56759f7c75270c13d5f3f5f736a9558929c:
> >   Merge remote-tracking branch
> >   'remotes/pmaydell/tags/pull-target-arm-20200312' into staging
> >   (2020-03-12 17:34:34 +0000)>=20
> > adds support for the ARM MTE compatibility subset (which does not seem =
to
> > have an official name) to QEMU user mode and system mode on "max" CPU.
> > This corresponds to MTE =3D=3D 1 in the instruction set feature field, =
and
> > allows running code with MTE instructions without actual tag storage.
>=20
> Hi; how does this interact with Richard's series for MemTag ?
> https://patchew.org/QEMU/20200312194219.24406-1-richard.henderson@linaro.=
org

It does not. I don't know about that seriers. The patches are part of the=20
patchset that lead to my PAuth fixes a year ago. At that time, only beta sp=
ec=20
was available, including obvious bugs (sysregs with duplicate opcodes),=20
suspicious things (TCO being EL3) and generally being a beta. I thus sat on=
=20
that part of the work until I now got time to rebase, clean and update to t=
he=20
released spec.

Meanwhile if there's a high-profile developer working on the same thing, I=
=20
guess there's no point for me to carry on.

=2D-=20
=E9=9B=B7=E7=B1=B3=E2=80=A7=E5=BE=B7=E5=B0=BC-=E5=BA=93=E5=B0=94=E8=92=99
http://www.remlab.net/




