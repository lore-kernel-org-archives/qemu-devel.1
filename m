Received: from eggs.gnu.org ([2001:4830:134:3::10]:59497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj7F2-00072D-GB
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:36:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj7F1-0007eK-ON
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:36:40 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:36429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cj7F1-0007dr-Gt
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 11:36:39 -0500
Received: by mail-wr0-x22e.google.com with SMTP id u108so34124690wrb.3
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 08:36:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <871suh2ff3.fsf@linaro.org>
References: <CAFEAcA_KVG19uhPuBUNx4ySmebnL1Hit6=HUX9ug0FkBFMwasg@mail.gmail.com>
	<877f492ppx.fsf@linaro.org>
	<e28337d0-d572-cd9a-3f45-0ecc074c32c9@ilande.co.uk>
	<874lzd2mp7.fsf@linaro.org>
	<9efa47c0-2a5f-0229-7e27-97a0142ff22d@ilande.co.uk>
	<871suh2ff3.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Mar 2017 16:36:17 +0000
Message-ID: <CAFEAcA_70-Y1s+EBhusuGRWr51EzE21PASLRVQFS_PV+NQsw2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] intermittent make check failure:
 "tcg_handle_interrupt: assertion failed: (qemu_mutex_iothread_locked())"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU Developers <qemu-devel@nongnu.org>

On 1 March 2017 at 15:19, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> I haven't managed to run into the intermittent trigger yet. How do I run
> the test directly?
>
>   make tests/prom-env-test
>
> Just makes the test case and
>
>   ./tests/prom-env-test
> **
> ERROR:tests/libqtest.c:589:qtest_get_arch: assertion failed: (qemu !=3D N=
ULL)
> Aborted (core dumped)

These tests all need a bunch of environment variables set (notably
the one that tells it which QEMU binary to run). If you run
'make check V=3D1' it prints out all the command lines and then
you can cut-n-paste the one you're interested in from that
(and trim down any other tests it's running in the process).

thanks
-- PMM
