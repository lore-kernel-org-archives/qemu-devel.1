Received: from eggs.gnu.org ([2001:4830:134:3::10]:57208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fW0Yz-0003oS-DS
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fW0Yv-0007xN-Di
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:27:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36962 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fW0Yv-0007xE-8m
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 10:27:49 -0400
Date: Thu, 21 Jun 2018 16:27:46 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180621162746.16de966a@redhat.com>
In-Reply-To: <CAJ+F1CKwFY7zM2mqYU3QtOdpx9jOXNFTtgfEvNJZionByas6Qg@mail.gmail.com>
References: <20180515121433.6112-1-marcandre.lureau@redhat.com>
	<20180515121433.6112-4-marcandre.lureau@redhat.com>
	<20180621145405.197d5106@redhat.com>
	<CAJ+F1CKFq5=Afoqg8YZGw-TO8vJqTPwjpW_UAMh6G8LPp4ZztA@mail.gmail.com>
	<CAJ+F1CJ+g4wUCi4ao8z7K6CvuO4Zt9VqOi46o4voo3e8Vceeyg@mail.gmail.com>
	<CAJ+F1CKwFY7zM2mqYU3QtOdpx9jOXNFTtgfEvNJZionByas6Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/4] acpi: build TPM Physical Presence
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Thu, 21 Jun 2018 16:13:32 +0200
Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> wrote:

> Hi
>=20
> On Thu, Jun 21, 2018 at 3:22 PM, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
> > Hi
> >
> > On Thu, Jun 21, 2018 at 3:21 PM, Marc-Andr=C3=A9 Lureau
> > <marcandre.lureau@gmail.com> wrote:
> > =20
> >>>> +    method =3D aml_method("TPFN", 1, AML_SERIALIZED); =20
> >>> not quite sure how this method (supposed to ) work(s),
> >>> it could use nice comment explaining mechanics.
> >>> =20
> >>
> >> Windows doesn't like DerefOf (FUNC [N]), it returned wrong values. It
> >> took me a while to figure this out. My laptop TPM ACPI table uses the
> >> same trick, so I assume this is a Windows acpi bug/limitation. Instead
> >> we use a function that returns the corresponding field. =20
> >
> > Sorry, I am wrong, my laptop doesn't use such table. I don't know
> > where I saw someone using the same trick though.. =20
>=20
> fwiw, I also asked on OSR list for help but got no answer:
> http://www.osronline.com/showThread.CFM?link=3D288617
it is/might be fine if there is a workaround to make Windows work,
we should mention it in comment though (including windows versions
where it doesn't work) so in future someone else (including me and you)
won't break it by accident.

>=20
>=20
>=20
>=20
>=20
