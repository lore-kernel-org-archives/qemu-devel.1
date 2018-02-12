Received: from eggs.gnu.org ([2001:4830:134:3::10]:47019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elJot-0003RF-9Z
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:31:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1elJop-0003uJ-KW
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:31:19 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38770 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1elJop-0003tj-Gl
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 14:31:15 -0500
References: <20180125135129.9305-1-klim.kireev@virtuozzo.com>
	<bb1b8270-e924-3d41-a172-38ba79db9bf7@redhat.com>
	<fd22674c-059e-8d37-338c-5d2d4d96eb20@redhat.com>
	<CAFEAcA9eKZNznjgnRy_vuKvcQZ2e=0XD0b9reGBFBBFoBTREQg@mail.gmail.com>
	<CAKmqyKNN_ysFP0pwDaccc1T+znoMfNtTXPzhLE-nsB7pCqmctg@mail.gmail.com>
	<4b726592-1078-1ac8-37b1-9227122d2429@redhat.com>
	<ac7cca9f-24f7-6b04-acbd-e63c99df9136@virtuozzo.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <8ad4b5f9-eced-3a3f-64b3-494624e3c369@redhat.com>
Date: Mon, 12 Feb 2018 20:30:52 +0100
MIME-Version: 1.0
In-Reply-To: <ac7cca9f-24f7-6b04-acbd-e63c99df9136@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] "make check -j4" hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: klim <klim.kireev@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Alistair Francis <alistair23@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Denis V. Lunev" <den@virtuozzo.com>

On 12.02.2018 15:42, klim wrote:
[...]
> I just have reverted my 2 commits and
>=20
> after that make check -j32 hangs
>=20
> with
>=20
> GTester: last random seed: R02Sb95a3bf6ab4c05540cec188081a7cc2a
>=20
> in vhost-user-test
>=20
> so it is not my fault

You're right. I've bisected the issue again, and this time I've applied
8f6d701044b ("tests/test-filter-redirector: move close()") on top of
each step if necessary, and indeed, the "vhost-user-test" problem has
nothing to do with your patches, Klim, but with the one from Marc-Andr=C3=
=A9.
According to git bisect, this is the commit that introduced the problem:

	commit 7e49f5e8e508ed020c96798b3f7083e24e0e425b
	tests: use memfd in vhost-user-test

Peter, since this is quite annoying if "make check" is not working
reliably, could you please revert that commit until a proper solution is
found?

 Thanks,
  Thomas
