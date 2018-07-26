Received: from eggs.gnu.org ([2001:4830:134:3::10]:54224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fibut-0001xu-Cj
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 04:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fibuq-0000hk-E9
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 04:46:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fibuq-0000hW-8G
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 04:46:32 -0400
Date: Thu, 26 Jul 2018 10:46:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180726104628.3380b5bf@redhat.com>
In-Reply-To: <CAHNT7NtYMYXYZW=zRVpHYsnvcUy6BnmM2gZ5oJyXnHuwOnb_Ag@mail.gmail.com>
References: <1526382973-49342-1-git-send-email-imammedo@redhat.com>
	<1526400000-66561-1-git-send-email-imammedo@redhat.com>
	<CAHNT7NtoqQDpQCMF9C92KHvn6jLAy0K1fOJaT6nTTAAJ0s+utQ@mail.gmail.com>
	<20180518100214.5e14a753@redhat.com>
	<CAHNT7NtYMYXYZW=zRVpHYsnvcUy6BnmM2gZ5oJyXnHuwOnb_Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] riscv: remove define cpu_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Palmer Dabbelt <palmer@sifive.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?= =?UTF-8?B?w6k=?= <f4bug@amsat.org>

On Thu, 26 Jul 2018 10:27:38 +1200
Michael Clark <mjc@sifive.com> wrote:

> On Fri, May 18, 2018 at 8:02 PM, Igor Mammedov <imammedo@redhat.com> wrot=
e:
>=20
> > On Fri, 18 May 2018 14:10:24 +1200
> > Michael Clark <mjc@sifive.com> wrote:
> > =20
> > > On Wed, May 16, 2018 at 4:00 AM, Igor Mammedov <imammedo@redhat.com> =
=20
> > wrote: =20
> > > =20
> > > > cpu_init() was removed since 2.12, so drop the define that is now =
=20
> > unused. =20
> > > >
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > > > =20
> > >
> > > Reviewed-by: Michael Clark <mjc@sifive.com> =20
> > Michael,
> >
> > could you merge it through RISCV queue? =20
>=20
>=20
> Yes indeed. Sorry I missed this email.
>=20
> I'm going to bring this into the riscv-qemu queue right away and move it =
to
> the head of the queue, now we have Alastair's stuff in master. Although I
> won't be making any PRs until after 3.0 is released.

Thanks, it's cleanup so it's ok if it goes to 3.1
=20
[...]
