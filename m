Received: from eggs.gnu.org ([2001:4830:134:3::10]:37508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWm88-0002L9-HH
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:47:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gWm85-0008AO-2h
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:47:36 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gWm84-00089a-RW
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 12:47:33 -0500
Received: by mail-wm1-x343.google.com with SMTP id a62so3140256wmh.4
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 09:47:31 -0800 (PST)
References: <20181210152829.29271-1-alex.bennee@linaro.org>
	<20181210152829.29271-10-alex.bennee@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181210152829.29271-10-alex.bennee@linaro.org>
Date: Tue, 11 Dec 2018 17:47:29 +0000
Message-ID: <87r2eo0xce.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 09/13] tests/tcg: split cris tests into
 system and user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: edgar.iglesias@gmail.com, michael@walle.cc, aurelien@aurel32.net, amarkovic@wavecomp.com, shorne@gmail.com, jcmvbkbc@gmail.com


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> This will help with the make system as we build a different set of
> tests for each qemu binary.

Hmm actually they are all userspace tests. Perhaps the split should be
bare (as in not needing libc) and libc based tests? We can only build
the bare tests at the moment as the only packaged cris compilers I could
find where system compilers only for building kernels or -nostdinc stuff
that doesn't need a libc.

If there is a canonical location for a cris toolchain with libc we can
create a docker image for that instead. Edgar?


--
Alex Benn=C3=A9e
