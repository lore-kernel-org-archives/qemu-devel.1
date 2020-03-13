Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F89C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:06:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F28D8206EB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 16:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28D8206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCmpk-0006bY-4n
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 12:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51010)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <remi@remlab.net>) id 1jCmop-0005YG-7Q
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:05:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <remi@remlab.net>) id 1jCmon-0005Z4-TQ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 12:05:51 -0400
Received: from poy.remlab.net ([2001:41d0:2:5a1a::]:51078
 helo=ns207790.ip-94-23-215.eu) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <remi@remlab.net>)
 id 1jCmok-0005EG-V9; Fri, 13 Mar 2020 12:05:47 -0400
Received: from basile.remlab.net (87-92-31-51.bb.dnainternet.fi [87.92.31.51])
 (Authenticated sender: remi)
 by ns207790.ip-94-23-215.eu (Postfix) with ESMTPSA id 169F25FD2A;
 Fri, 13 Mar 2020 17:05:45 +0100 (CET)
From: =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC] [PATCH 0/5] ARMv8.5-MemTag disassembly
Date: Fri, 13 Mar 2020 18:05:44 +0200
Message-ID: <2232346.Qcd0NKbubf@basile.remlab.net>
Organization: Remlab
In-Reply-To: <886d0295-9fed-2e81-ce5e-54668755029e@linaro.org>
References: <2159383.tmy0LfLZHX@basile.remlab.net>
 <886d0295-9fed-2e81-ce5e-54668755029e@linaro.org>
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le perjantaina 13. maaliskuuta 2020, 17.49.06 EET Richard Henderson a =C3=
=A9crit :
> On 3/13/20 6:59 AM, R=C3=A9mi Denis-Courmont wrote:
> > For proper storage and checking of memory tags, MTE =3D=3D 2 would be
> > necessary. I have some code (on top of this RFC but not included) to add
> > the tag allocation logic. But I have no clue how to actually store the
> > tags in QEMU system mode at this point, so it's mostly dead code.
>=20
> I have implemented this, and posted version 6 yesterday.
> Peter gave you the link.

Yes, I'm sure it's feasible on the system mode. Physical indexing is not a=
=20
problem there.

> > In user mode, it seems impossible anyway, as tags are indexed by physic=
al,
> > not virtual address and QEMU cannot know which virtual memory address m=
ay
> > physically alias another within the user process.
>=20
> When I update my mte user branch, I will only support anonymous memory,
> since I cannot share my on-the-side data structure for tags between
> aarch64-linux-user processes, whether or not they are in a tmpfs
> filesystem.

Oh, absolutely: if you only support anonymous memory, then the user mode ca=
se=20
is easy as you can index tags on virtual address - much easier than system=
=20
mode in all likelihood. I already had kludgy implementation of that a year=
=20
ago, but that was not in a level of code quality that I'd ever submit publi=
cly=20
to an OSS project. It works fine as long as there's no named mappings in th=
e=20
tested code. My point was *only* that I can't think of a reasonable way to=
=20
implement user mode *correctly*, no more.

And given that it was neither correct nor fast, it seemed doubly questionab=
le=20
in QEMU. AFAIU, QEMU tries to optimize for speed anyway (hence that it does=
=20
not trigger SP alignment exception, for instance).

=2D-=20
=E9=9B=B7=E7=B1=B3=E2=80=A7=E5=BE=B7=E5=B0=BC-=E5=BA=93=E5=B0=94=E8=92=99
http://www.remlab.net/




