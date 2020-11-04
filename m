Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D57C4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6598221F8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:58:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6598221F8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaGVE-0000vL-OQ
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 05:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukma@denx.de>)
 id 1kaGU5-0008Da-7r; Wed, 04 Nov 2020 05:57:45 -0500
Received: from mail-out.m-online.net ([2001:a60:0:28:0:1:25:1]:39524)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukma@denx.de>)
 id 1kaGU2-0006R7-80; Wed, 04 Nov 2020 05:57:44 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4CR3X22CPqz1rwbX;
 Wed,  4 Nov 2020 11:57:38 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 4CR3X21ff8z1qwlk;
 Wed,  4 Nov 2020 11:57:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id R_Ksv6E0uSs9; Wed,  4 Nov 2020 11:57:36 +0100 (CET)
X-Auth-Info: 8pMrCpKaXWoT1tW5AaRMdy1WMVaoAo+k8exvGill1J4=
Received: from jawa (85-222-111-42.dynamic.chello.pl [85.222.111.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Wed,  4 Nov 2020 11:57:36 +0100 (CET)
Date: Wed, 4 Nov 2020 11:57:06 +0100
From: Lukasz Majewski <lukma@denx.de>
To: Alistair Francis <alistair23@gmail.com>
Subject: Re: [QEMU] Question regarding user mode support for ARM syscalls
Message-ID: <20201104115706.154e76a4@jawa>
In-Reply-To: <CAKmqyKNRU8EqcyVv4gduNsKcMOUWSmW2oWTvfWMNS3C70Nx9PQ@mail.gmail.com>
References: <20201103120027.6fdc868c@jawa>
 <CAKmqyKOFxO+NoyA0N2HbNDujKdDg4vFyMvpq=6+TPPxx4-VMFw@mail.gmail.com>
 <20201103175532.796074fb@jawa>
 <CAKmqyKNRU8EqcyVv4gduNsKcMOUWSmW2oWTvfWMNS3C70Nx9PQ@mail.gmail.com>
Organization: denx.de
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/eu_frwX7XhCSuQSvA3eWk6s"; protocol="application/pgp-signature"
Received-SPF: none client-ip=2001:a60:0:28:0:1:25:1;
 envelope-from=lukma@denx.de; helo=mail-out.m-online.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 05:57:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

--Sig_/eu_frwX7XhCSuQSvA3eWk6s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alistair,

> On Tue, Nov 3, 2020 at 8:55 AM Lukasz Majewski <lukma@denx.de> wrote:
> >
> > Hi Alistair,
> > =20
> > > On Tue, Nov 3, 2020 at 3:03 AM Lukasz Majewski <lukma@denx.de>
> > > wrote: =20
> > > >
> > > > Dear Qemu Community, =20
> > >
> > > Hey Lukasz,
> > >
> > > + QEMU Dev Mailing list
> > > + Laurent
> > > =20
> >
> > Thanks for reaching more people.
> > =20
> > > >
> > > > I would like to ask you for some advice regarding the usage of
> > > > arm-linux-user/qemu-arm user space program simulation.
> > > >
> > > > Background:
> > > > -----------
> > > >
> > > > I'm looking for a way to efficiently test y2038 in-glibc
> > > > solution for 32 bit architectures (e.g. ARM).
> > > >
> > > > For now I do use qemu-system-arm (part of Yocto/OE), which I'm
> > > > using to run Linux kernel 5.1, glibc under test and Y2038
> > > > tests. It works [1].
> > > >
> > > > Problem:
> > > > --------
> > > >
> > > > I would like to test cross-compiled tests (which are built from
> > > > glibc sources) without the need to run the emulated system with
> > > > qemu-system-arm.
> > > >
> > > > I've come across the "QEMU user mode", which would execute the
> > > > cross-compiled test (with already cross-compiled glibc via -L
> > > > switch) and just return exit status code. This sounds
> > > > appealing. =20
> > >
> > > As another advantage it is much, much faster at running the glibc
> > > tests.
> > > =20
> >
> > +1
> > =20
> > > >
> > > > As fair as I've read - QEMU user mode emulates ARM syscalls.
> > > >
> > > > During test execution (single qemu user mode process) I would
> > > > need to adjust date with clock_settime64 syscall and then
> > > > execute other syscalls if needed.
> > > >
> > > >
> > > > Please correct me if I'm wrong:
> > > > - It looks like qemu-arm doesn't have switch which would allow
> > > > it to set time offset (to e.g. year 2039 - something similar to
> > > >   qemu-system-arm -rtc=3D).
> > > >
> > > > - As of 5.1 qemu version there is no support for syscalls
> > > > supporting 64 bit time on 32 bit architectures (e.g.
> > > > clock_settime64 and friends from [2]). =20
> > >
> > > There is some support in the current master, for example
> > > __NR_futex_time64 is supported. =20
> >
> > I've just looked into v5.1.0 stable release. I will double check
> > this with -master branch.
> > =20
> > >
> > > I started to add some support for RV32 once it was merged into
> > > glibc. =20
> >
> > Ok.
> > =20
> > > =20
> > > >
> > > > For my example program [3] statically build for testing (it
> > > > works with qemu-system-arm):
> > > >
> > > > ~/work/qemu-arm-tests-program$
> > > > ../qemu-5.1.0-arm/arm-linux-user/qemu-arm -L
> > > > ~/work/yocto/y2038/build/tmp/armv7at2hf-neon-poky-linux-gnueabi/y20=
38-glibc/2.30+git999-r0/image/opt
> > > > -strace ./cst
> > > >
> > > > 17746 brk(NULL) =3D 0x00074000
> > > > 17746 brk(0x000748a8) =3D 0x000748a8
> > > > 17746 uname(0x40800370) =3D 0
> > > > 17746 readlink("/proc/self/exe",0x407ff488,4096) =3D 43
> > > > 17746 brk(0x000958a8) =3D 0x000958a8
> > > > 17746 brk(0x00096000) =3D 0x00096000
> > > > 17746 mprotect(0x00070000,8192,PROT_READ) =3D 0
> > > > 17746statx(1,"",AT_EMPTY_PATH|AT_NO_AUTOMOUNT,STATX_BASIC_STATS,0x4=
07ffd70)
> > > > =3D 0
> > > > 17746 Unknown syscall 404 --> is the syscall number of
> > > > clock_settime64 =20
> > >
> > > clock_settime64 is supported in master QEMU. =20
> >
> > I will double check it - thanks for pointing this out.
> > =20
> > > =20
> > > >
> > > > 17746 dup(2) =3D 3
> > > > 17746 fcntl64(3,F_GETFL) =3D 2
> > > > 17746statx(3,"",AT_EMPTY_PATH|AT_NO_AUTOMOUNT,STATX_BASIC_STATS,0x4=
07ff8e8)
> > > > =3D 0 ERR
> > > >
> > > > Questions:
> > > > ----------
> > > >
> > > > 1. Is there any plan to add support for emulating syscalls
> > > > supporting 64 bit time on 32 bit architectures [2]? =20
> > >
> > > I would like to have RV32 supported, but it's a low priority for
> > > me. =20
> >
> > Having syscalls supporting 64 bit time on 32 bit machines indicated
> > in [2] would be a very welcome for glibc testing.
> > =20
> > > I
> > > expect it's something that will eventually happen though. =20
> >
> > Ok.
> > =20
> > > =20
> > > >
> > > > 2. Provide QEMU user space switch to adjust its time (i.e. add
> > > > some offset to in-fly emulated time syscalls - like
> > > > clock_settime64) when it is started? =20
> > >
> > > That I'm not sure about. =20
> >
> > For me it would be enough to have:
> >
> > qemu-arm -rtc=3D"2039-01-01" -L... ./ctx
> > So the emulated "time" would be after 32 bit time_t overflow when
> > QEMU user space emulation process starts (as long as it doesn't
> > touch the host machine time).
> >
> >
> > Another option (workaround) would be to run clock_settime64() with
> > time set to year 2038+ on the beginning of each glibc test. It
> > shall work as long as we don't change host time (and all time
> > changes would stay in the qemu user mode process).
> > =20
> > > I assume just running date/clock_settime64
> > > from a script wouldn't work with the glibc test framework? =20
> >
> > Could you elaborate on this use case/scenario? Do you have some
> > examples to share? =20
>=20
> Whoops, I got confused here. The clock_gettime syscall goes to the
> host, so we just report host time. I was thinking about softMMU where
> we maintain our own time.
>=20
> So your proposed `-rtc` command would add an offset to the host time?
> Something like:
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 3160a9ba06..240bd59bb2 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -12074,6 +12074,7 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>=20
>          ret =3D target_to_host_timespec64(&ts, arg2);
>          if (!is_error(ret)) {
> +            ts.tv_sec -=3D 567993505;
>              ret =3D get_errno(clock_settime(arg1, &ts));
>          }
>          return ret;
> @@ -12096,6 +12097,8 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>          struct timespec ts;
>          ret =3D get_errno(clock_gettime(arg1, &ts));
>          if (!is_error(ret)) {
> +            // Calculate different to same time in 2038
> +            ts.tv_sec +=3D 567993505;
>              ret =3D host_to_target_timespec64(arg2, &ts);
>          }
>          return ret;
>=20
> That might end up working if you can intercept all of the absolute
> time syscalls.

It looks to me that intercepting _all_ time related syscalls seems to
be a time consuming task.

>=20
> Without any mainline support that would be easy to do in your local
> tree,

The "local tree" solution is not an acceptable solution for me.

> which would at least allow you to test. You could also change
> your host time to 2038, but that would break things for your host.

Yes, I would like to avoid changing the host time.

>=20
> Alistair
>=20
> > =20
> > >
> > > Alistair
> > > =20
> > > >
> > > >
> > > > Thanks in advance for your help and reply.
> > > >
> > > >
> > > > Links:
> > > > [1] - https://github.com/lmajewski/meta-y2038/
> > > > [2] -
> > > > https://elixir.bootlin.com/linux/latest/source/arch/arm/tools/sysca=
ll.tbl#L419
> > > >
> > > > [3]:
> > > > Example program:
> > > > cat <<- EOF >> clock_settime_test.c
> > > > #include <stdio.h>
> > > > #include <time.h>
> > > >
> > > > int main (int argc, char **argv)
> > > > {
> > > >         struct timespec tv;
> > > >         int ret;
> > > >
> > > >         tv.tv_sec =3D 0x7FFFFFFF;
> > > >         tv.tv_sec +=3D 61;
> > > >         tv.tv_nsec =3D 0;
> > > >
> > > >         printf("clock_settime test program: ");
> > > >         ret =3D clock_settime(CLOCK_REALTIME, &tv);
> > > >         if (!ret)
> > > >                 printf("OK\n");
> > > >         else
> > > >                 perror("ERR\n");
> > > >
> > > >         return 0;
> > > > }
> > > > EOF
> > > >
> > > > Build the test program:
> > > > gcc -Wall -ggdb -D_TIME_BITS=3D64 -D_FILE_OFFSET_BITS=3D64
> > > > -I/opt/include -I/opt/usr/include -L/opt/usr/lib \
> > > > -Wl,-rpath=3D/opt/lib -Wl,--dynamic-linker=3D/opt/lib/ld-linux.so.2
> > > > clock_settime_test.c -o cst -static
> > > >
> > > >
> > > >
> > > > Best regards,
> > > >
> > > > Lukasz Majewski
> > > >
> > > > --
> > > >
> > > > DENX Software Engineering GmbH,      Managing Director: Wolfgang
> > > > Denk HRB 165235 Munich, Office: Kirchenstr.5, D-82194
> > > > Groebenzell, Germany Phone: (+49)-8142-66989-59 Fax:
> > > > (+49)-8142-66989-80 Email: lukma@denx.de =20
> >
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

--Sig_/eu_frwX7XhCSuQSvA3eWk6s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl+iiQIACgkQAR8vZIA0
zr3LUQf/QKAcAuyfkwQ9ddWMEgIOM9JIH9aG2tXovUFdbQ9wJ0cJ+ChTOg9tpBNf
n2k50BwewNkVe9n+jl5OOScpyZb5bx5sPibqZUprJhoSPl5a4kHG13N7G3rH0Ynk
WM86Ig08UUEJUf3o5OjFSOaLj0siuzdbgzIcp8+WCaSeVcEUfY2LuVuRjJJ/g1jU
1Rm2L0BlYarU3jFiKI8vHTGUdbRAlWNJOM5szRkHNyD6FFwQ+U7+6UwYkBC3C5eW
k7gCsdwW8OgwjklvQg8mHFFTIDeIQbMSXxbHbixkbRLHM7hpUv+Ocha98zBrR9p/
VLLV7xBeDRKDuTGORcWVyFc5SXWhDw==
=pyqh
-----END PGP SIGNATURE-----

--Sig_/eu_frwX7XhCSuQSvA3eWk6s--

