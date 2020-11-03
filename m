Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE507C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:50:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6145F20719
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 20:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6145F20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka3GL-0000Hk-Ck
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 15:50:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukma@denx.de>)
 id 1kZzb9-0001il-NA; Tue, 03 Nov 2020 11:55:55 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:34817)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukma@denx.de>)
 id 1kZzb6-0006D7-Sf; Tue, 03 Nov 2020 11:55:55 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4CQbWm5qzfz1qs0P;
 Tue,  3 Nov 2020 17:55:48 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 4CQbWm5FZBz1qspZ;
 Tue,  3 Nov 2020 17:55:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id SCC-USmKOzWx; Tue,  3 Nov 2020 17:55:46 +0100 (CET)
X-Auth-Info: Ne9LxEHexrM33x4iO/w4NbXv/lN+djjc+5Eu7aKHbWs=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Tue,  3 Nov 2020 17:55:46 +0100 (CET)
Date: Tue, 3 Nov 2020 17:55:32 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Alistair Francis <alistair23@gmail.com>
Subject: Re: [QEMU] Question regarding user mode support for ARM syscalls
Message-ID: <20201103175532.796074fb@jawa>
In-Reply-To: <CAKmqyKOFxO+NoyA0N2HbNDujKdDg4vFyMvpq=6+TPPxx4-VMFw@mail.gmail.com>
References: <20201103120027.6fdc868c@jawa>
 <CAKmqyKOFxO+NoyA0N2HbNDujKdDg4vFyMvpq=6+TPPxx4-VMFw@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/CqSCLvdd5re.s7aEWjS.8M0"; protocol="application/pgp-signature"
Received-SPF: none client-ip=212.18.0.9; envelope-from=lukma@denx.de;
 helo=mail-out.m-online.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 11:55:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 03 Nov 2020 15:49:23 -0500
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
Cc: qemu-discuss <qemu-discuss@nongnu.org>,
 GNU C Library <libc-alpha@sourceware.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/CqSCLvdd5re.s7aEWjS.8M0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alistair,

> On Tue, Nov 3, 2020 at 3:03 AM Lukasz Majewski <lukma@denx.de> wrote:
> >
> > Dear Qemu Community, =20
>=20
> Hey Lukasz,
>=20
> + QEMU Dev Mailing list
> + Laurent
>=20

Thanks for reaching more people.

> >
> > I would like to ask you for some advice regarding the usage of
> > arm-linux-user/qemu-arm user space program simulation.
> >
> > Background:
> > -----------
> >
> > I'm looking for a way to efficiently test y2038 in-glibc solution
> > for 32 bit architectures (e.g. ARM).
> >
> > For now I do use qemu-system-arm (part of Yocto/OE), which I'm
> > using to run Linux kernel 5.1, glibc under test and Y2038 tests. It
> > works [1].
> >
> > Problem:
> > --------
> >
> > I would like to test cross-compiled tests (which are built from
> > glibc sources) without the need to run the emulated system with
> > qemu-system-arm.
> >
> > I've come across the "QEMU user mode", which would execute the
> > cross-compiled test (with already cross-compiled glibc via -L
> > switch) and just return exit status code. This sounds appealing. =20
>=20
> As another advantage it is much, much faster at running the glibc
> tests.
>=20

+1

> >
> > As fair as I've read - QEMU user mode emulates ARM syscalls.
> >
> > During test execution (single qemu user mode process) I would need
> > to adjust date with clock_settime64 syscall and then execute other
> > syscalls if needed.
> >
> >
> > Please correct me if I'm wrong:
> > - It looks like qemu-arm doesn't have switch which would allow it to
> >   set time offset (to e.g. year 2039 - something similar to
> >   qemu-system-arm -rtc=3D).
> >
> > - As of 5.1 qemu version there is no support for syscalls
> > supporting 64 bit time on 32 bit architectures (e.g.
> > clock_settime64 and friends from [2]). =20
>=20
> There is some support in the current master, for example
> __NR_futex_time64 is supported.

I've just looked into v5.1.0 stable release. I will double check this
with -master branch.

>=20
> I started to add some support for RV32 once it was merged into glibc.

Ok.

>=20
> >
> > For my example program [3] statically build for testing (it works
> > with qemu-system-arm):
> >
> > ~/work/qemu-arm-tests-program$
> > ../qemu-5.1.0-arm/arm-linux-user/qemu-arm -L
> > ~/work/yocto/y2038/build/tmp/armv7at2hf-neon-poky-linux-gnueabi/y2038-g=
libc/2.30+git999-r0/image/opt
> > -strace ./cst
> >
> > 17746 brk(NULL) =3D 0x00074000
> > 17746 brk(0x000748a8) =3D 0x000748a8
> > 17746 uname(0x40800370) =3D 0
> > 17746 readlink("/proc/self/exe",0x407ff488,4096) =3D 43
> > 17746 brk(0x000958a8) =3D 0x000958a8
> > 17746 brk(0x00096000) =3D 0x00096000
> > 17746 mprotect(0x00070000,8192,PROT_READ) =3D 0
> > 17746statx(1,"",AT_EMPTY_PATH|AT_NO_AUTOMOUNT,STATX_BASIC_STATS,0x407ff=
d70)
> > =3D 0
> > 17746 Unknown syscall 404 --> is the syscall number of
> > clock_settime64 =20
>=20
> clock_settime64 is supported in master QEMU.

I will double check it - thanks for pointing this out.

>=20
> >
> > 17746 dup(2) =3D 3
> > 17746 fcntl64(3,F_GETFL) =3D 2
> > 17746statx(3,"",AT_EMPTY_PATH|AT_NO_AUTOMOUNT,STATX_BASIC_STATS,0x407ff=
8e8)
> > =3D 0 ERR
> >
> > Questions:
> > ----------
> >
> > 1. Is there any plan to add support for emulating syscalls
> > supporting 64 bit time on 32 bit architectures [2]? =20
>=20
> I would like to have RV32 supported, but it's a low priority for me.

Having syscalls supporting 64 bit time on 32 bit machines indicated in
[2] would be a very welcome for glibc testing.

> I
> expect it's something that will eventually happen though.

Ok.

>=20
> >
> > 2. Provide QEMU user space switch to adjust its time (i.e. add some
> > offset to in-fly emulated time syscalls - like clock_settime64)
> > when it is started? =20
>=20
> That I'm not sure about.

For me it would be enough to have:

qemu-arm -rtc=3D"2039-01-01" -L... ./ctx
So the emulated "time" would be after 32 bit time_t overflow when
QEMU user space emulation process starts (as long as it doesn't touch
the host machine time).


Another option (workaround) would be to run clock_settime64() with time
set to year 2038+ on the beginning of each glibc test. It shall work as
long as we don't change host time (and all time changes would stay in
the qemu user mode process).

> I assume just running date/clock_settime64
> from a script wouldn't work with the glibc test framework?

Could you elaborate on this use case/scenario? Do you have some
examples to share?

>=20
> Alistair
>=20
> >
> >
> > Thanks in advance for your help and reply.
> >
> >
> > Links:
> > [1] - https://github.com/lmajewski/meta-y2038/
> > [2] -
> > https://elixir.bootlin.com/linux/latest/source/arch/arm/tools/syscall.t=
bl#L419
> >
> > [3]:
> > Example program:
> > cat <<- EOF >> clock_settime_test.c
> > #include <stdio.h>
> > #include <time.h>
> >
> > int main (int argc, char **argv)
> > {
> >         struct timespec tv;
> >         int ret;
> >
> >         tv.tv_sec =3D 0x7FFFFFFF;
> >         tv.tv_sec +=3D 61;
> >         tv.tv_nsec =3D 0;
> >
> >         printf("clock_settime test program: ");
> >         ret =3D clock_settime(CLOCK_REALTIME, &tv);
> >         if (!ret)
> >                 printf("OK\n");
> >         else
> >                 perror("ERR\n");
> >
> >         return 0;
> > }
> > EOF
> >
> > Build the test program:
> > gcc -Wall -ggdb -D_TIME_BITS=3D64 -D_FILE_OFFSET_BITS=3D64
> > -I/opt/include -I/opt/usr/include -L/opt/usr/lib \
> > -Wl,-rpath=3D/opt/lib -Wl,--dynamic-linker=3D/opt/lib/ld-linux.so.2
> > clock_settime_test.c -o cst -static
> >
> >
> >
> > Best regards,
> >
> > Lukasz Majewski
> >
> > --
> >
> > DENX Software Engineering GmbH,      Managing Director: Wolfgang
> > Denk HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell,
> > Germany Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email:
> > lukma@denx.de =20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/CqSCLvdd5re.s7aEWjS.8M0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl+hi4QACgkQAR8vZIA0
zr2gGwgAsuIw9Y1BN6zLUNhonkuQeDhTTGuI4O67tClohkaR92IA0WSaP+oWZLlb
cqvAZ58JsuasQrl+sppKFjjY5CmrvA7SkGeBu4sEN8sWbKke0XVU3dbRt4mRRVax
CJSZv3cQZXu4NPKmbK+BdGy6BEntjPBPlTaaMkoPrzqDhXNwpJ0BwUFG9YXAV4NT
mDkHTI8mubyRp3Lg1wdz86H61Ft4UVTeHtH94cb+ZIuAuInm0Z0/UgbmtGciWnQw
7tCLd5Rz+YBRaIEREf+r1+vNzg4fNfV5SmeeCUfdxal5+HxRMBKJl7CSy8WxyMTc
vmeaSV5ZGaLZ4g4HGsLQwUJa+CPC6w==
=A70+
-----END PGP SIGNATURE-----

--Sig_/CqSCLvdd5re.s7aEWjS.8M0--

