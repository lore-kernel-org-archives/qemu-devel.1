Received: from eggs.gnu.org ([2001:4830:134:3::10]:56182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fMERG-0008Ag-P2
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fMERD-0002M7-II
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:15:30 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:45172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fMERD-0002L2-7G
	for qemu-devel@nongnu.org; Fri, 25 May 2018 11:15:27 -0400
Received: by mail-wr0-x241.google.com with SMTP id w3-v6so9836664wrl.12
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 08:15:27 -0700 (PDT)
References: <20180525133851.27161-1-alex.bennee@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180525133851.27161-1-alex.bennee@linaro.org>
Date: Fri, 25 May 2018 16:15:24 +0100
Message-ID: <87o9h3sr5f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 00/49] fix buildings of tests/tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Hi,
>
> Main changes since last version:
>   - clean-up test-mmap (no more re-definitions of run-test-mmap warnings)
>   - merged some patches
>   - added new run-test, diff-out and skip-test helpers
>   - fixed the powerpc cross compiler (now sid based)
>   - enabled testing for powerpc

Two late breaking problems are fixed with v5.1 patches. These are:

>   tests/tcg/i386: add runner for test-i386-fprem

We no longer include a 69Mb reference file in the patch. The Makefile
will generate on your hardware if it doesn't exist before running
through QEMU.

>   tests/tcg: add run, diff, and skip helper macros

A typo in the fprem test case to use diff-out instead of diff-test.

If you want you can always grab a pre-made branch at:

  https://github.com/stsquad/qemu/tree/testing/tcg-tests-revival-v5.1

--
Alex Benn=C3=A9e
