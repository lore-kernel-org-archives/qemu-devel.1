Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DC1C33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 17:02:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7072085B
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 17:02:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7072085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aurel32.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io9Ij-0001Qt-7G
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 12:02:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60975)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aurelien@aurel32.net>) id 1io9FI-0007Lj-OY
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 11:59:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aurelien@aurel32.net>) id 1io9FH-0002Fs-I3
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 11:59:20 -0500
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:37822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aurelien@aurel32.net>)
 id 1io9FH-0002Ev-Cd; Sun, 05 Jan 2020 11:59:19 -0500
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
 by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <aurelien@aurel32.net>)
 id 1io9FE-0005bk-ST; Sun, 05 Jan 2020 17:59:16 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.92.3)
 (envelope-from <aurelien@aurel32.net>)
 id 1io9FE-007hSH-Dn; Sun, 05 Jan 2020 17:59:16 +0100
Date: Sun, 5 Jan 2020 17:59:16 +0100
From: Aurelien Jarno <aurelien@aurel32.net>
To: Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [Qemu-devel] [PATCH v4 3/7] target/riscv: Create function to
 test if FP is enabled
Message-ID: <20200105165916.GA1834646@aurel32.net>
References: <cover.1566573576.git.alistair.francis@wdc.com>
 <5cc26abb98a9534720f09674b4b9caafb8f2cf0a.1566573576.git.alistair.francis@wdc.com>
 <20200105163640.GA1752551@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200105163640.GA1752551@aurel32.net>
User-Agent: Mutt/1.13.2 (2019-12-18)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:bc8:30d7:100::1
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
Cc: alistair23@gmail.com, palmer@dabbelt.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-01-05 17:36, Aurelien Jarno wrote:
> > diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> > index e0d4586760..2789215b5e 100644
> > --- a/target/riscv/csr.c
> > +++ b/target/riscv/csr.c
>=20
> [ snip=A0]
>=20
> > @@ -307,6 +307,7 @@ static int write_mstatus(CPURISCVState *env, int cs=
rno, target_ulong val)
> >  {
> >      target_ulong mstatus =3D env->mstatus;
> >      target_ulong mask =3D 0;
> > +    int dirty;
> > =20
> >      /* flush tlb on mstatus fields that affect VM */
> >      if (env->priv_ver <=3D PRIV_VERSION_1_09_1) {
> > @@ -340,8 +341,9 @@ static int write_mstatus(CPURISCVState *env, int cs=
rno, target_ulong val)
> > =20
> >      mstatus =3D (mstatus & ~mask) | (val & mask);
> > =20
> > -    int dirty =3D ((mstatus & MSTATUS_FS) =3D=3D MSTATUS_FS) |
> > -                ((mstatus & MSTATUS_XS) =3D=3D MSTATUS_XS);
> > +    dirty =3D (riscv_cpu_fp_enabled(env) &&
> > +             ((mstatus & MSTATUS_FS) =3D=3D MSTATUS_FS)) |
> > +            ((mstatus & MSTATUS_XS) =3D=3D MSTATUS_XS);
> >      mstatus =3D set_field(mstatus, MSTATUS_SD, dirty);
> >      env->mstatus =3D mstatus;
>=20
> This patch, and more precisely the above two hunks broke
> qemu-system-riscv64. More precisely, when running a Debian sid system
> inside QEMU, sshd hangs during key exchange.

The problem is that at this stage, mstatus !=3D env->status. Prior to that
patch, dirty was computed exclusively on the new mstatus status, after
the update by val. With this patch, riscv_cpu_fp_enabled() refers to the
old value of mstatus. Therefore when FS is changed from "Off" (FS =3D 00)
to "Dirty" (FS =3D=3D 11), the SD bit is not set.

--=20
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net

