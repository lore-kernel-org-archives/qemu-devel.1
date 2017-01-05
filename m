Received: from eggs.gnu.org ([2001:4830:134:3::10]:39909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cPAVj-00064T-Nb
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:03:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cPAVf-0000Eu-PW
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:03:27 -0500
Received: from ignoranthack.me ([199.102.79.106]:54410
	helo=mail.ignoranthack.me)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbruno@freebsd.org>) id 1cPAVf-0000E5-Fm
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:03:23 -0500
Received: from [192.168.0.6] (97-123-13-194.albq.qwest.net [97.123.13.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sbruno@ignoranthack.me)
	by mail.ignoranthack.me (Postfix) with ESMTPSA id 4AD2E1928BA
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 16:03:22 +0000 (UTC)
References: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
From: Sean Bruno <sbruno@freebsd.org>
Message-ID: <e90abf9b-f474-2adc-1b2d-5d1df7fb1505@freebsd.org>
Date: Thu, 5 Jan 2017 09:03:17 -0700
MIME-Version: 1.0
In-Reply-To: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="xcAXFrjDDViO09klkaSRwqsWHx2vilkda"
Subject: Re: [Qemu-devel] New Year's starting over ... bsd-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xcAXFrjDDViO09klkaSRwqsWHx2vilkda
From: Sean Bruno <sbruno@freebsd.org>
To: qemu-devel@nongnu.org
Message-ID: <e90abf9b-f474-2adc-1b2d-5d1df7fb1505@freebsd.org>
Subject: Re: [Qemu-devel] New Year's starting over ... bsd-user
References: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
In-Reply-To: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 01/03/17 09:18, Sean Bruno wrote:
>=20
> I'm pondering where to start with getting FreeBSD's bsd-user code into
> shape so it could actually be reviewed and accepted now that its sort o=
f
> working again (signal handling fixed finally).
>=20
> I almost feel like the existing code should be purged, except that it
> gives a good history (and this seems lazy to me).
>=20
> As a first pass, I guess, I'd like to at least make i386 user run on
> x86_64.  What would you folks like to see in a first pass?
>=20
> sean
>=20
> ref: https://github.com/seanbruno/qemu-bsd-user/tree/bsd-user
>=20


Ok, this is probably too big for a single patch.  I'll see if its
reasonable to break this up across *some* kind of logic boundary.

=46rom 831cae735ea8f562109960401fb92fe861586dc8 Mon Sep 17 00:00:00 2001
From: Sean Bruno <sbruno@freebsd.org>
Date: Tue, 3 Jan 2017 09:57:51 -0700
Subject: [PATCH] Test branch that updates existing bsd-user code and
existing
 bsd-user targets only.

---
 Makefile.target                         |    2 +-
 bsd-user/Makefile.objs                  |    6 +-
 bsd-user/bsd-file.h                     | 1137 ++++++++++++++
 bsd-user/bsd-ioctl.c                    |  569 +++++++
 bsd-user/bsd-ioctl.h                    |   27 +
 bsd-user/bsd-mem.c                      |  124 ++
 bsd-user/bsd-mem.h                      |  438 ++++++
 bsd-user/bsd-misc.c                     |  209 +++
 bsd-user/bsd-misc.h                     |  341 +++++
 bsd-user/bsd-proc.c                     |  184 +++
 bsd-user/bsd-proc.h                     |  473 ++++++
 bsd-user/bsd-signal.h                   |  244 +++
 bsd-user/bsd-socket.c                   |  108 ++
 bsd-user/bsd-socket.h                   |  266 ++++
 bsd-user/bsdload.c                      |  171 ++-
 bsd-user/elfload.c                      | 2451
++++++++++++++++++++-----------
 bsd-user/errno_defs.h                   |   13 +-
 bsd-user/freebsd/host_os.h              |   46 +
 bsd-user/freebsd/make_syscall_nr_h.sh   |   45 +
 bsd-user/freebsd/os-extattr.c           |  118 ++
 bsd-user/freebsd/os-extattr.h           |  654 +++++++++
 bsd-user/freebsd/os-file.h              |  165 +++
 bsd-user/freebsd/os-ioctl-cmds.h        |  137 ++
 bsd-user/freebsd/os-ioctl-cryptodev.h   |   85 ++
 bsd-user/freebsd/os-ioctl-disk.h        |   53 +
 bsd-user/freebsd/os-ioctl-filio.h       |   45 +
 bsd-user/freebsd/os-ioctl-in6_var.h     |  229 +++
 bsd-user/freebsd/os-ioctl-ioccom.h      |   54 +
 bsd-user/freebsd/os-ioctl-sockio.h      |  252 ++++
 bsd-user/freebsd/os-ioctl-ttycom.h      |  257 ++++
 bsd-user/freebsd/os-ioctl-types.h       |   97 ++
 bsd-user/freebsd/os-misc.h              |  532 +++++++
 bsd-user/freebsd/os-proc.c              |  602 ++++++++
 bsd-user/freebsd/os-proc.h              |  531 +++++++
 bsd-user/freebsd/os-signal.h            |   43 +
 bsd-user/freebsd/os-socket.c            |  149 ++
 bsd-user/freebsd/os-socket.h            |  853 +++++++++++
 bsd-user/freebsd/os-stat.c              |  234 +++
 bsd-user/freebsd/os-stat.h              |  437 ++++++
 bsd-user/freebsd/os-strace.h            |   29 +
 bsd-user/freebsd/os-sys.c               | 1070 ++++++++++++++
 bsd-user/freebsd/os-thread.c            | 1419 ++++++++++++++++++
 bsd-user/freebsd/os-thread.h            |  533 +++++++
 bsd-user/freebsd/os-time.c              |  243 +++
 bsd-user/freebsd/os-time.h              |  832 +++++++++++
 bsd-user/freebsd/qemu-os.h              |   82 ++
 bsd-user/freebsd/strace.list            |   34 +-
 bsd-user/freebsd/syscall_nr.h           |  929 ++++++------
 bsd-user/freebsd/target_os_elf.h        |  151 ++
 bsd-user/freebsd/target_os_siginfo.h    |  125 ++
 bsd-user/freebsd/target_os_signal.h     |   79 +
 bsd-user/freebsd/target_os_stack.h      |  181 +++
 bsd-user/freebsd/target_os_thread.h     |    6 +
 bsd-user/freebsd/target_os_user.h       |  325 ++++
 bsd-user/freebsd/target_os_vmparam.h    |   22 +
 bsd-user/i386/target_arch.h             |   13 +
 bsd-user/i386/target_arch_cpu.c         |   80 +
 bsd-user/i386/target_arch_cpu.h         |  306 ++++
 bsd-user/i386/target_arch_elf.h         |   62 +
 bsd-user/i386/target_arch_reg.h         |   82 ++
 bsd-user/i386/target_arch_signal.h      |   94 ++
 bsd-user/i386/target_arch_sigtramp.h    |   11 +
 bsd-user/i386/target_arch_sysarch.h     |   78 +
 bsd-user/i386/target_arch_thread.h      |   45 +
 bsd-user/i386/target_arch_vmparam.h     |   28 +
 bsd-user/i386/target_signal.h           |    6 -
 bsd-user/i386/target_syscall.h          |   19 +
 bsd-user/main.c                         |  877 ++---------
 bsd-user/mmap.c                         |  416 ++++--
 bsd-user/netbsd/host_os.h               |   31 +
 bsd-user/netbsd/os-extattr.h            |  247 ++++
 bsd-user/netbsd/os-ioctl-cmds.h         |   48 +
 bsd-user/netbsd/os-ioctl-filio.h        |   29 +
 bsd-user/netbsd/os-ioctl-ioccom.h       |   38 +
 bsd-user/netbsd/os-ioctl-ttycom.h       |  240 +++
 bsd-user/netbsd/os-ioctl-types.h        |    7 +
 bsd-user/netbsd/os-misc.h               |  375 +++++
 bsd-user/netbsd/os-proc.c               |   11 +
 bsd-user/netbsd/os-proc.h               |  243 +++
 bsd-user/netbsd/os-socket.c             |    1 +
 bsd-user/netbsd/os-socket.h             |   98 ++
 bsd-user/netbsd/os-stat.c               |    1 +
 bsd-user/netbsd/os-stat.h               |    1 +
 bsd-user/netbsd/os-strace.h             |    1 +
 bsd-user/netbsd/os-sys.c                |   46 +
 bsd-user/netbsd/os-thread.c             |    1 +
 bsd-user/netbsd/os-thread.h             |  133 ++
 bsd-user/netbsd/os-time.c               |    1 +
 bsd-user/netbsd/os-time.h               |  179 +++
 bsd-user/netbsd/qemu-os.h               |    1 +
 bsd-user/netbsd/target_os_elf.h         |  227 +++
 bsd-user/netbsd/target_os_siginfo.h     |   82 ++
 bsd-user/netbsd/target_os_signal.h      |   70 +
 bsd-user/netbsd/target_os_stack.h       |   37 +
 bsd-user/netbsd/target_os_thread.h      |    6 +
 bsd-user/openbsd/host_os.h              |   31 +
 bsd-user/openbsd/os-extattr.h           |  247 ++++
 bsd-user/openbsd/os-ioctl-cmds.h        |   48 +
 bsd-user/openbsd/os-ioctl-filio.h       |   29 +
 bsd-user/openbsd/os-ioctl-ioccom.h      |   38 +
 bsd-user/openbsd/os-ioctl-ttycom.h      |  240 +++
 bsd-user/openbsd/os-ioctl-types.h       |    7 +
 bsd-user/openbsd/os-misc.h              |  375 +++++
 bsd-user/openbsd/os-proc.c              |   11 +
 bsd-user/openbsd/os-proc.h              |  243 +++
 bsd-user/openbsd/os-socket.c            |    1 +
 bsd-user/openbsd/os-socket.h            |   98 ++
 bsd-user/openbsd/os-stat.c              |    1 +
 bsd-user/openbsd/os-stat.h              |  176 +++
 bsd-user/openbsd/os-strace.h            |    1 +
 bsd-user/openbsd/os-sys.c               |   46 +
 bsd-user/openbsd/os-thread.c            |    1 +
 bsd-user/openbsd/os-thread.h            |  133 ++
 bsd-user/openbsd/os-time.c              |    1 +
 bsd-user/openbsd/os-time.h              |  179 +++
 bsd-user/openbsd/qemu-os.h              |    1 +
 bsd-user/openbsd/target_os_elf.h        |  227 +++
 bsd-user/openbsd/target_os_siginfo.h    |   82 ++
 bsd-user/openbsd/target_os_signal.h     |   70 +
 bsd-user/openbsd/target_os_stack.h      |   37 +
 bsd-user/openbsd/target_os_thread.h     |    6 +
 bsd-user/qemu-bsd.h                     |   85 ++
 bsd-user/qemu.h                         |  218 ++-
 bsd-user/signal.c                       |  896 ++++++++++-
 bsd-user/sparc/target_arch.h            |   11 +
 bsd-user/sparc/target_arch_cpu.c        |  114 ++
 bsd-user/sparc/target_arch_cpu.h        |  161 ++
 bsd-user/sparc/target_arch_elf.h        |   34 +
 bsd-user/sparc/target_arch_reg.h        |   56 +
 bsd-user/sparc/target_arch_signal.h     |   77 +
 bsd-user/sparc/target_arch_sigtramp.h   |   11 +
 bsd-user/sparc/target_arch_sysarch.h    |   52 +
 bsd-user/sparc/target_arch_thread.h     |   39 +
 bsd-user/sparc/target_arch_vmparam.h    |   37 +
 bsd-user/sparc/target_signal.h          |    5 -
 bsd-user/sparc/target_syscall.h         |   24 +-
 bsd-user/sparc64/target_arch.h          |   17 +
 bsd-user/sparc64/target_arch_cpu.c      |  122 ++
 bsd-user/sparc64/target_arch_cpu.h      |  284 ++++
 bsd-user/sparc64/target_arch_elf.h      |   38 +
 bsd-user/sparc64/target_arch_reg.h      |   56 +
 bsd-user/sparc64/target_arch_signal.h   |  188 +++
 bsd-user/sparc64/target_arch_sigtramp.h |   12 +
 bsd-user/sparc64/target_arch_sysarch.h  |  158 ++
 bsd-user/sparc64/target_arch_thread.h   |   57 +
 bsd-user/sparc64/target_arch_vmparam.h  |   37 +
 bsd-user/sparc64/target_signal.h        |    5 -
 bsd-user/sparc64/target_syscall.h       |   24 +-
 bsd-user/strace.c                       |   10 +
 bsd-user/syscall.c                      | 2086 +++++++++++++++++++++----=
-
 bsd-user/syscall_defs.h                 |  929 ++++++++++--
 bsd-user/x86_64/target_arch.h           |   13 +
 bsd-user/x86_64/target_arch_cpu.c       |   80 +
 bsd-user/x86_64/target_arch_cpu.h       |  321 ++++
 bsd-user/x86_64/target_arch_elf.h       |   55 +
 bsd-user/x86_64/target_arch_reg.h       |   92 ++
 bsd-user/x86_64/target_arch_signal.h    |   94 ++
 bsd-user/x86_64/target_arch_sigtramp.h  |   11 +
 bsd-user/x86_64/target_arch_sysarch.h   |   76 +
 bsd-user/x86_64/target_arch_thread.h    |   40 +
 bsd-user/x86_64/target_arch_vmparam.h   |   28 +
 bsd-user/x86_64/target_signal.h         |    5 -
 bsd-user/x86_64/target_syscall.h        |   21 +-
 configure


--xcAXFrjDDViO09klkaSRwqsWHx2vilkda
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGTBAEBCgB9FiEEuq1GMucSHejSCZfdEgHvyh5yfmQFAlhubkVfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJB
QUQ0NjMyRTcxMjFERThEMjA5OTdERDEyMDFFRkNBMUU3MjdFNjQACgkQEgHvyh5y
fmTWYQf/aO5kQnUGScKe32D4T+RJ/FLlfCCvvYktXFFiOnaTDabqrC7oN7EZIye7
Hli7yXnAxxAfu6OLP4jTcytI+SxIsvF2k74bDt4DMvsNj5p1P5lOMaLF601dapkM
nlEcalkR/kWFcQ94KbWWcHMufoc2t/aKR9mfo32gNH9kxjklpL2vDlQqOQo6Dm2S
JJfF2kHr8Li5dvhqSEGap+0WfqSfDSoz+5G4poaAWSArbffsJBvF1frUBno/mvf1
n14ursbGSln0PtmG7vgKMlZh0CeYqatyKEL02V0yZezeSKa8y9GNeAuUi0Xwuh4V
38kq9rXOg6rRnJgfW8j4xF1oXMq+2w==
=9oHl
-----END PGP SIGNATURE-----

--xcAXFrjDDViO09klkaSRwqsWHx2vilkda--
