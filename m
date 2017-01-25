Received: from eggs.gnu.org ([2001:4830:134:3::10]:46924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWLCU-0008VV-OJ
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:53:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWLCP-0000h1-Sr
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:53:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cWLCP-0000gr-Nt
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 05:53:09 -0500
References: <CAC2QTZY0SJczV9_e3TwJbEXwyuTQXDQesAP5W6U0JeYvsV5uQg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <c5202aa1-bf56-5d66-533a-a1e78a3eafa2@redhat.com>
Date: Wed, 25 Jan 2017 11:53:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAC2QTZY0SJczV9_e3TwJbEXwyuTQXDQesAP5W6U0JeYvsV5uQg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] migration: QEMU aborts migration of "none" machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ashijeet Acharya <ashijeetacharya@gmail.com>
Cc: "dgilbert@redhat.com" <dgilbert@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>

On 25.01.2017 11:01, Ashijeet Acharya wrote:
> Hi Thomas,
>=20
> I was able to reproduce the bug you encountered while trying to migrate
> a "none" machine.
>=20
> After digging deep and debugging the problem with gdb, I found that
> bitmap_new() is the function that crashes qemu as it always has
> zero bits being passed to it.
>=20
> I had a discussion with Dave on the IRC yesterday and he suggested the
> reason of crash being the absence of RAM ( since machine is "none")
> while attempting the migration.
>=20
> I am not sure what the ideal solution will be in this case; Do any of
> the maintainers have any suggestions or even a starting point which I
> can ponder upon?

I'm not that familiar with the migration code either, but maybe you
could simply check for last_ram_offset() =3D=3D 0 at the beginning of
ram_save_setup() and return with an error in that case?

 Thomas
