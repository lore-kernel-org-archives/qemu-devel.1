Received: from eggs.gnu.org ([2001:4830:134:3::10]:53680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dIXFC-0000qO-FT
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:27:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dIXF7-00028E-Hj
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:27:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37522)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dIXF7-00027s-C7
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 05:27:09 -0400
Date: Wed, 7 Jun 2017 05:27:07 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <2020123289.30850450.1496827627184.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAFEAcA8FpdJEt2M5jHQjRE5OcHQ=XQoL=q3O=5ptBnc2UfN7Xw@mail.gmail.com>
References: <20170607074632.13162-1-marcandre.lureau@redhat.com>
	<20170607074632.13162-3-marcandre.lureau@redhat.com>
	<CAFEAcA8FpdJEt2M5jHQjRE5OcHQ=XQoL=q3O=5ptBnc2UfN7Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/5] coccinelle: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi

----- Original Message -----
> On 7 June 2017 at 08:46, Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.=
com>
> wrote:
> > The coccinelle/round.cocci script doesn't catch hard coded values.
> >
> > I used the following script over qemu code base:
> >
> > (
> > - ((e1) + 3) / (4)
> > + DIV_ROUND_UP(e1,4)
> > |
> > - ((e1) + (3)) / (4)
> > + DIV_ROUND_UP(e1,4)
>=20
> Why do we need both of these? Is it just "coccinelle is weird" ? :-)

I am total newbie to coccinnelle-land, but I think this one is useless dupl=
ication

>=20
> > |
> > - ((e1) + 7) / (8)
> > + DIV_ROUND_UP(e1,8)
> > |
> > - ((e1) + (7)) / (8)
> > + DIV_ROUND_UP(e1,8)
> > |
> > - ((e1) + 15) / (16)
> > + DIV_ROUND_UP(e1,16)
> > |
> > - ((e1) + (15)) / (16)
> > + DIV_ROUND_UP(e1,16)
> > |
> > - ((e1) + 31) / (32)
> > + DIV_ROUND_UP(e1,32)
> > |
> > - ((e1) + (31)) / (32)
> > + DIV_ROUND_UP(e1,32)
> > )
>=20
> > -                     next_op =3D op_pointer + ((oplen + 7) / 8);
> > +                     next_op =3D op_pointer + (DIV_ROUND_UP(oplen, 8))=
;
>=20
> I think there's a coccinelle trick for making it drop
> now-unnecessary brackets in substitutions like this, but I forget
> what it is. Maybe it's as simple as having substitutions for
>=20

> > - (((e1) + 7) / (8))
> > + DIV_ROUND_UP(e1,8)
>=20
> as well?


I think you need a second rule:
@@
expression e1;
expression e2;
@@
-(DIV_ROUND_UP(e1,e2))
+DIV_ROUND_UP(e1,e2)


I will fix it in second version.
