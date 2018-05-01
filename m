Received: from eggs.gnu.org ([2001:4830:134:3::10]:41767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDXHM-0004g3-FY
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:34:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDXFz-0007bv-44
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:33:20 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fDXFy-0007bV-T4
	for qemu-devel@nongnu.org; Tue, 01 May 2018 11:31:55 -0400
Received: by mail-wr0-x22d.google.com with SMTP id i14-v6so7965215wre.2
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 08:31:54 -0700 (PDT)
References: <152518111080.22177.382728353135880212.malonedeb@soybean.canonical.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <152518111080.22177.382728353135880212.malonedeb@soybean.canonical.com>
Date: Tue, 01 May 2018 16:31:52 +0100
Message-ID: <87fu3b9ytz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1768246] [NEW] cpu-exec.c:648:
 cpu_loop_exec_tb: Assertion `use_icount' failed.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1768246 <1768246@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> writes:

> Public bug reported:
>
> OpenJDK no longer works on qemu-sh4, it previously did after #1735384
> was fixed.
>
> Crash indicates an assertion failure:
>
> (sid-sh4-sbuild)root@nofan:/# java --version
> qemu-sh4-static: /root/qemu/accel/tcg/cpu-exec.c:648: cpu_loop_exec_tb: A=
ssertion `use_icount' failed.
> qemu: uncaught target signal 6 (Aborted) - core dumped
> Aborted
> (sid-sh4-sbuild)root@nofan:/#
>
> Haven't bi-sected the issue yet, but will do so later.

Hmm that's ominous - arguably the assert should be inside the
CONFIG_USER but I'm not sure how you get to the point where icount isn't
< 0 after receiving a TB_EXIT_REQUESTED.

>
> ** Affects: qemu
>      Importance: Undecided
>          Status: New


--
Alex Benn=C3=A9e
