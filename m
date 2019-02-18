Received: from eggs.gnu.org ([209.51.188.92]:60808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gvlWk-0001KG-AY
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1gvlMv-0002WW-0J
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:02:10 -0500
Received: from mail-it1-x133.google.com ([2607:f8b0:4864:20::133]:32920)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1gvlMu-0002W1-LN
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 11:02:08 -0500
Received: by mail-it1-x133.google.com with SMTP id g137so141196ita.0
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 08:02:08 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <ab1a67c0-8872-6e22-fc70-946bbcabb8a1@redhat.com>
Date: Mon, 18 Feb 2019 11:02:05 -0500
Content-Transfer-Encoding: quoted-printable
Message-Id: <BD5AEBD4-0B91-4756-B8D6-C0E643CF1F42@oberlin.edu>
References: <B9D713FC-5896-4923-9788-AF7EAA9B462D@oberlin.edu>
	<ab1a67c0-8872-6e22-fc70-946bbcabb8a1@redhat.com>
Subject: Re: [Qemu-devel] Testing sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org



On Feb 18, 2019, at 08:43, Thomas Huth <thuth@redhat.com> wrote:

> I think you could use one of the machines that has a cfi02 on board. =
For
> example: Write some random data to a temporary file. Run qemu with:
>=20
> QTestState *qts;
> qts =3D qtest_initf(" qemu-system-arm -M musicpal,accel=3Dqtest "
>                "-drive if=3Dpflash,file=3D%s,format=3Draw", filename);

If I do that, will it be possible for the test to override the =
properties set by pflash_cfi02_register? It looks like I should be able =
to use -global to set properties that aren't set explicitly.

Thank you,

--=20
Stephen Checkoway
