Received: from eggs.gnu.org ([2001:4830:134:3::10]:44273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eMEk4-00089b-0w
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:02:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eMEjw-0001Dk-Ag
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:02:40 -0500
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:45929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eMEjw-0001As-3Z
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 10:02:32 -0500
Received: by mail-wr0-x235.google.com with SMTP id h1so590447wre.12
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 07:02:30 -0800 (PST)
References: <151203716694.2960.12305472500745415473.malonedeb@gac.canonical.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <151203716694.2960.12305472500745415473.malonedeb@gac.canonical.com>
Date: Tue, 05 Dec 2017 15:02:28 +0000
Message-ID: <87609lrzej.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1735384] [NEW] OpenJDK JVM segfaults on
 qemu-sh4 (regression)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1735384 <1735384@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> writes:

> Public bug reported:
>
> Some of the recent changes introduced a regression which makes the
> OpenJDK JVM crash on qemu-sh4:
>
> (sid-sh4-sbuild)root@nofan:/# java -version
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> Segmentation fault
> (sid-sh4-sbuild)root@nofan:/#

With an --enable-debug build I managed to replicate:

  root@6e10336e48ac:/etc/apt# java --version
  qemu-sh4: /home/alex/lsrc/qemu/qemu.git/tcg/tcg.h:703: temp_idx: Assertio=
n `n >=3D 0 && n < tcg_ctx->nb_temps' failed.
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  Segmentation fault (core dumped)

Which implies the front end has gotten something wrong. Maybe this
somehow tripped up the fault resolution in the end? Can you try with an
--enable-debug build?

>
> An older version works fine:
>
> (sid-sh4-sbuild)root@nofan:/# java -version
> openjdk version "9.0.1"
> OpenJDK Runtime Environment (build 9.0.1+11-Debian-1)
> OpenJDK Zero VM (build 9.0.1+11-Debian-1, interpreted mode)
> (sid-sh4-sbuild)root@nofan:/#
>
> Haven't had time for bisecting this yet.
>
> Adrian
>
> ** Affects: qemu
>      Importance: Undecided
>          Status: New


--
Alex Benn=C3=A9e
