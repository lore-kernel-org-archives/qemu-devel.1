Received: from eggs.gnu.org ([2001:4830:134:3::10]:37460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVbfv-00011C-CJ
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVbfs-0004RE-AO
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:48:51 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:38292)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVbfs-0004R4-2n
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:48:48 -0400
Received: by mail-wm0-f49.google.com with SMTP id f67so21485645wmh.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 03:48:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3CA8C399-80D0-4BC8-ACC6-FD72A09D9685@skyportsystems.com>
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
	<1499111049-13721-20-git-send-email-mst@redhat.com>
	<CAFEAcA_giHFa-aw=WuuqmVFL+dr7HeD9E1o=oLszQywJbAd0wA@mail.gmail.com>
	<7EC3FA95-777F-4F8F-B02D-85FA09BAFC00@skyportsystems.com>
	<CAFEAcA8-o28j-FvHWz3=nZX_pO=+XOc_6MnmyFWB324+G7Ppqw@mail.gmail.com>
	<CAFEAcA-ireu_2fW00dX=Z3hu4Jongftab_ysymbJMB0893M4Ww@mail.gmail.com>
	<20170711220915-mutt-send-email-mst@kernel.org>
	<CAFEAcA_-hCV2Ogy3BS2RV4_AWYYQDT+fCNChVcz8uKZ8-VxhWA@mail.gmail.com>
	<273a7da7-2243-171f-e96d-39e8e8031984@redhat.com>
	<3CA8C399-80D0-4BC8-ACC6-FD72A09D9685@skyportsystems.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2017 11:47:25 +0100
Message-ID: <CAFEAcA8ZiTqAGS01Rtu8Vv9FHKXtUXwfc9mULkCkanQzirB14Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 19/21] tests: Add unit tests for the VM
 Generation ID feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>
Cc: Laszlo Ersek <lersek@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 12 July 2017 at 00:43, Ben Warren <ben@skyportsystems.com> wrote:
> Yes, it=E2=80=99s definitely a setup time problem.  With the values that =
are checked
> in, I can=E2=80=99t get it to fail on my setup, but if I wind the numbers=
 down I see
> the same failure as Peter.  So now we have the ages-old problem of =E2=80=
=9Cwhat new
> arbitrary value should I use that will not cause false failures but will
> eventually time out=E2=80=9D.

Empirically, we already have an answer to this, in the form
of the existing code in tests/boot-sector.c, which is used
by both that test and the bios-tables-test.c code to wait
for the BIOS initialization to complete, and which doesn't
cause false test timeouts in practice.

Can we make this test just use that existing function to
wait for the BIOS to be done, rather than having its own
timeout loop?

thanks
-- PMM
