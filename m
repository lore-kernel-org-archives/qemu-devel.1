Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8086C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:22:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 938012083B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 10:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938012083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gentoo.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIr44-0007Y8-DW
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 06:22:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dilfridge@gentoo.org>)
 id 1kIqy3-00008u-V4
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:16:43 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:50704)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dilfridge@gentoo.org>)
 id 1kIqy1-0004J5-6h
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 06:16:43 -0400
From: Andreas =?ISO-8859-1?Q?K=2E_H=FCttel?= <dilfridge@gentoo.org>
To: Alistair Francis <alistair23@gmail.com>
Subject: Re: riscv32 wait() problem, qemu or glibc?
Date: Thu, 17 Sep 2020 13:16:30 +0300
Message-ID: <2156782.iezcSG77Qx@farino>
Organization: Gentoo Linux
In-Reply-To: <CAKmqyKOZ+i-zWp06GPyDNDo3ON+D5Q09e=YhPsJQOd4K9uPeVQ@mail.gmail.com>
References: <9435182.tdPhlSkOF2@farino> <9381423.g9G3TJQzCC@farino>
 <CAKmqyKOZ+i-zWp06GPyDNDo3ON+D5Q09e=YhPsJQOd4K9uPeVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4480764.52yBJDM9G5";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Received-SPF: pass client-ip=140.211.166.183;
 envelope-from=dilfridge@gentoo.org; helo=smtp.gentoo.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 06:16:38
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: GNU C Library <libc-alpha@sourceware.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--nextPart4480764.52yBJDM9G5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Donnerstag, 17. September 2020, 00:05:10 EEST schrieb Alistair Francis:
> On Wed, Sep 16, 2020 at 2:09 PM Andreas K. H=FCttel <dilfridge@gentoo.org=
>=20
wrote:
> > > My guess is that somewhere in QEMU the types don't match what RV32 is
> > > using. It's probably worth printing out the size, alignment and value
> > > of everything at every stage and see what breaks.
> >=20
> > Thanks.
>=20
> Sorry I can't be more helpful. Hopefully one day I will look into it,
> but it's not a high priority.

No problem at all. I'm mostly going to postpone this now in favour of=20
autobuilding bootable images (which needs some non-riscv specific=20
preparation).=20

Last thing I still did overnight was run the glibc testsuite in quemu-riscv=
32=20
user emulation. The summary is below (and as suspected a bit of a massacre)=
;=20
I'll look at the details later sometime.=20
If anyone else wants to poke at it, I've tarred up the full glibc build dir=
=20
and uploaded it together with the build log, see
https://dev.gentoo.org/~dilfridge/rv32-testing/

UNSUPPORTED: crypt/cert
=46AIL: debug/tst-backtrace4
=46AIL: debug/tst-backtrace5
=46AIL: debug/tst-backtrace6
=46AIL: elf/check-localplt
UNSUPPORTED: elf/tst-dlopen-self-container
UNSUPPORTED: elf/tst-dlopen-tlsmodid-container
XPASS: elf/tst-latepthread
UNSUPPORTED: elf/tst-ldconfig-bad-aux-cache
UNSUPPORTED: elf/tst-ldconfig-ld_so_conf-update
UNSUPPORTED: elf/tst-pldd
XPASS: elf/tst-protected1a
XPASS: elf/tst-protected1b
=46AIL: iconv/tst-iconv_prog
UNSUPPORTED: io/tst-copy_file_range
UNSUPPORTED: io/tst-getcwd-abspath
=46AIL: libio/tst-atime
UNSUPPORTED: locale/tst-localedef-path-norm
UNSUPPORTED: localedata/tst-localedef-hardlinks
=46AIL: malloc/tst-dynarray-fail
=46AIL: malloc/tst-dynarray-fail-mem
=46AIL: malloc/tst-interpose-nothread
=46AIL: malloc/tst-interpose-static-nothread
=46AIL: malloc/tst-interpose-static-thread
=46AIL: malloc/tst-interpose-thread
=46AIL: malloc/tst-mallocfork2
UNSUPPORTED: malloc/tst-mallocstate
=46AIL: math/test-double-j1
=46AIL: math/test-double-y0
UNSUPPORTED: math/test-fesetexcept-traps
UNSUPPORTED: math/test-fexcept-traps
=46AIL: math/test-float-asinh
=46AIL: math/test-float-cos
=46AIL: math/test-float-cosh
=46AIL: math/test-float-erfc
=46AIL: math/test-float-exp
=46AIL: math/test-float-j0
=46AIL: math/test-float-j1
=46AIL: math/test-float-lgamma
=46AIL: math/test-float-sin
=46AIL: math/test-float-tgamma
=46AIL: math/test-float-y0
=46AIL: math/test-float32-asinh
=46AIL: math/test-float32-cos
=46AIL: math/test-float32-cosh
=46AIL: math/test-float32-erfc
=46AIL: math/test-float32-exp
=46AIL: math/test-float32-j0
=46AIL: math/test-float32-j1
=46AIL: math/test-float32-lgamma
=46AIL: math/test-float32-sin
=46AIL: math/test-float32-tgamma
=46AIL: math/test-float32-y0
=46AIL: math/test-float32x-j1
=46AIL: math/test-float32x-y0
=46AIL: math/test-float64-j1
=46AIL: math/test-float64-y0
UNSUPPORTED: math/test-matherr
UNSUPPORTED: math/test-matherr-2
UNSUPPORTED: math/test-nearbyint-except
UNSUPPORTED: math/test-nearbyint-except-2
=46AIL: misc/test-errno-linux
=46AIL: misc/tst-clone2
=46AIL: misc/tst-clone3
=46AIL: misc/tst-gettid-kill
=46AIL: misc/tst-glibcsyscalls
=46AIL: misc/tst-memfd_create
=46AIL: misc/tst-mlock2
UNSUPPORTED: misc/tst-ofdlocks-compat
UNSUPPORTED: misc/tst-pkey
=46AIL: misc/tst-sigcontext-get_pc
UNSUPPORTED: misc/tst-ttyname
UNSUPPORTED: nptl/test-cond-printers
UNSUPPORTED: nptl/test-condattr-printers
UNSUPPORTED: nptl/test-mutex-printers
UNSUPPORTED: nptl/test-mutexattr-printers
UNSUPPORTED: nptl/test-rwlock-printers
UNSUPPORTED: nptl/test-rwlockattr-printers
=46AIL: nptl/tst-align-clone
=46AIL: nptl/tst-cancel-self-canceltype
=46AIL: nptl/tst-cancel17
=46AIL: nptl/tst-cancel21
=46AIL: nptl/tst-cancel21-static
=46AIL: nptl/tst-cancel24
=46AIL: nptl/tst-cancel24-static
=46AIL: nptl/tst-cancelx16
=46AIL: nptl/tst-cancelx17
=46AIL: nptl/tst-cancelx18
=46AIL: nptl/tst-cancelx20
=46AIL: nptl/tst-cancelx21
=46AIL: nptl/tst-cancelx4
=46AIL: nptl/tst-cancelx5
=46AIL: nptl/tst-cleanupx4
=46AIL: nptl/tst-cond-except
=46AIL: nptl/tst-cond24
=46AIL: nptl/tst-cond25
=46AIL: nptl/tst-getpid1
UNSUPPORTED: nptl/tst-mutexpi5
UNSUPPORTED: nptl/tst-mutexpi5a
UNSUPPORTED: nptl/tst-mutexpi9
=46AIL: nptl/tst-oncex3
=46AIL: nptl/tst-oncex4
UNSUPPORTED: nptl/tst-pthread-getattr
=46AIL: nptl/tst-robust-fork
=46AIL: nptl/tst-robust1
=46AIL: nptl/tst-robust2
=46AIL: nptl/tst-robust3
=46AIL: nptl/tst-robust4
=46AIL: nptl/tst-robust5
=46AIL: nptl/tst-robust6
=46AIL: nptl/tst-robust7
=46AIL: nptl/tst-robust8
=46AIL: nptl/tst-robust9
XPASS: nptl/tst-stack4
UNSUPPORTED: nss/tst-nss-db-endgrent
UNSUPPORTED: nss/tst-nss-db-endpwent
UNSUPPORTED: nss/tst-nss-files-alias-leak
UNSUPPORTED: nss/tst-nss-files-alias-truncated
UNSUPPORTED: nss/tst-nss-files-hosts-erange
UNSUPPORTED: nss/tst-nss-files-hosts-getent
UNSUPPORTED: nss/tst-nss-files-hosts-long
UNSUPPORTED: nss/tst-nss-test3
=46AIL: posix/test-errno
=46AIL: posix/tst-fexecve
UNSUPPORTED: posix/tst-glob_lstat_compat
=46AIL: posix/tst-posix_spawn-setsid
=46AIL: posix/tst-spawn2
=46AIL: posix/tst-spawn4
UNSUPPORTED: posix/tst-spawn4-compat
UNSUPPORTED: posix/tst-sysconf-empty-chroot
=46AIL: posix/tst-wait4
UNSUPPORTED: resolv/tst-p_secstodate
UNSUPPORTED: resolv/tst-resolv-res_init
UNSUPPORTED: resolv/tst-resolv-res_init-thread
UNSUPPORTED: resolv/tst-resolv-threads
=46AIL: rt/tst-aio4
=46AIL: rt/tst-mqueue3
=46AIL: rt/tst-mqueue5
=46AIL: rt/tst-mqueue6
=46AIL: rt/tst-mqueue8x
=46AIL: stdio-common/tst-vfprintf-width-prec
=46AIL: stdio-common/tst-vfprintf-width-prec-mem
UNSUPPORTED: stdlib/tst-system
UNSUPPORTED: string/tst-strerror
UNSUPPORTED: string/tst-strsignal
XPASS: support/tst-support_descriptors
=46AIL: sysvipc/test-sysvmsg
=46AIL: sysvipc/test-sysvsem
Summary of test results:
     95 FAIL
   3971 PASS
     48 UNSUPPORTED
     17 XFAIL
      5 XPASS
make[1]: *** [Makefile:634: tests] Error 1







>=20
> > > AFAIK RV32 linux-user mode is pretty much un-tested. So their might be
> > > all sorts of issues with it unfortunately.
> >=20
> > Would you consider qemu system mode more reliable?
>=20
> Yes. For RISC-V the softmmu implementations are much more thoroughly test=
ed.
> > I need to prepare some bootable riscv gentoo images eventually anyway.
> > Might as well try a riscv32 one for comparison then if that is more
> > promising.
> It would be great to have more distros supporting RV32.
>=20
> Alistair
>=20
> > --
> > Andreas K. H=FCttel
> > dilfridge@gentoo.org
> > Gentoo Linux developer
> > (council, qa, toolchain, base-system, perl, libreoffice)


=2D-=20
Andreas K. H=FCttel
dilfridge@gentoo.org
Gentoo Linux developer=20
(council, qa, toolchain, base-system, perl, libreoffice)
--nextPart4480764.52yBJDM9G5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEE50NBr50KpJKM5MK59n+4O2olsAAFAl9jN35fFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEU3
NDM0MUFGOUQwQUE0OTI4Q0U0QzJCOUY2N0ZCODNCNkEyNUIwMDAACgkQ9n+4O2ol
sABlnw//RFpL/QZrniuNHlTEsHkU0xcL0GyP0TpVTa+0pAMsTuQnZjwDFDBXcJNH
luSSliVu4Rk8K5vjTV8DM04XNMPqJZeUdyLxO9SWze4t4CulhIJIktEgRNoE+27X
/mXTtO0oWQsb/HpRzaVrWPOKplNibePUYBYd6o7EIuVSafnhE3BzG5AWf4xGL9Z0
snSi0F9jQrYH6cvfXyvYlZ/Ab+GLZXpQCJiIqMnLDECzBv6INQaellrCGBwhiDPg
2zZwFy9rscyFL4Mq1jO4QNh1MC55V4Nr1rh6vQONyjetingPTkeWHJnAvVdBtmct
3ydo/JYxeMKUei01ty43XlnqfKOAiubWsJDjYfVT1XYDCWvG8tmps00rTodQX1cH
fsCZg1bQkhqzE7Mcx5nkUB7fMI1NfJPn8Hoe9wL9GqxewuKqTpyr5BqfrRdSrhSx
x05E7D1xbWclcwo0spGY8/hbEQLmCwK4f1u/Myv8nJeRjQG1gQa7te9NdDx01DBz
B9sFiyA4I12Htp0DeBxYNcntZr7HsUjAf8Tpzkw9g5TWNOWZRePwwW9EOSBIKs4K
of3gV3j97lcgg6BKAnFEc5EQDdBknqpS5KxsYV6FLs6otgA0BYb0ciiRhMgI6V/Z
TL4csTnFLde4CeVPZ+INbdnjViXPll6MDRac9VtTv5Km7xqLzjA=
=DTo7
-----END PGP SIGNATURE-----

--nextPart4480764.52yBJDM9G5--




