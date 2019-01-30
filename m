Received: from eggs.gnu.org ([209.51.188.92]:46585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <me@halfdog.net>) id 1gouGK-0006ik-FZ
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 13:07:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <me@halfdog.net>) id 1gouGI-0007sr-Ls
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 13:07:00 -0500
Received: from mail.halfdog.net ([37.186.9.82]:63165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <me@halfdog.net>) id 1gouGH-0007pm-MM
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 13:06:57 -0500
Received: from [169.254.0.1] (helo=localhost) by mail.halfdog.net with esmtpsa
	(TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92-RC4)
	(envelope-from <me@halfdog.net>) id 1gouG9-0006hQ-5J
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 18:06:49 +0000
From: halfdog <me@halfdog.net>
In-reply-to: <154835963658.2045.2300981728946163161.malonedeb@wampee.canonical.com>
References: <154835963658.2045.2300981728946163161.malonedeb@wampee.canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Jan 2019 18:06:12 +0000
Message-ID: <2372-1548871572.684811@Aewj.Tnvx.bGcG>
Subject: Re: [Qemu-devel] [Bug 1813201] [NEW] QEMU TCG i386 / x86_64 system
 emulation crash when executing int instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1813201 <1813201@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org

Alberto Ortega writes:
> Public bug reported:
>
> QEMU version:
> -------------
>
> qemu from git, master branch commit
> d058a37a6e8daa8d71a6f2b613eb415b69363755
>
> Release versions are also affected.
>
> Summary:
> --------
>
> QEMU i386 and x86_64 system emulation crash when executing the following
> "int" instruction:
>
> cd08  int 8
>
> This generates a kernel NULL pointer dereference error in Linux, and a
> BSOD error in Windows.
>
> No special permissions are required to execute the instruction, any
> unprivileged user can execute it.
> ...

Funny. Does Qemu share code with VirtualBox? If so, a similar
missing CPL=3D=3D0 check was fixed in Virtualbox 7 years ago.

https://www.halfdog.net/Security/2012/VirtualBoxSoftwareInterrupt0x8GuestC=
rash/
