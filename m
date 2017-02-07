Received: from eggs.gnu.org ([2001:4830:134:3::10]:51968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cbBza-0004Ww-N5
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 15:03:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cbBzX-0002Bm-Kq
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 15:03:58 -0500
Received: from mx5-phx2.redhat.com ([209.132.183.37]:51906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cbBzX-000299-Dq
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 15:03:55 -0500
Date: Tue, 7 Feb 2017 15:03:55 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <1174725609.1298917.1486497835239.JavaMail.zimbra@redhat.com>
In-Reply-To: <3ce84650-5d49-4db3-b71a-b71a37c0bd98@redhat.com>
References: <20170202145141.17138-1-marcandre.lureau@redhat.com>
	<20170202145141.17138-7-marcandre.lureau@redhat.com>
	<3ce84650-5d49-4db3-b71a-b71a37c0bd98@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/22] char: add a /chardevs container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, eblake@redhat.com

Hi

----- Original Message -----
>=20
>=20
> On 02/02/2017 15:51, Marc-Andr=C3=A9 Lureau wrote:
> > +    if (QTAILQ_IN_USE(chr, next)) {
> > +        QTAILQ_REMOVE(&chardevs, chr, next);
> > +    }
> > +    if (OBJECT(chr)->parent) {
> > +        object_unparent(OBJECT(chr));
> > +    } else {
> > +        object_unref(OBJECT(chr));
> > +    }
>=20
> What's the case where the "else" is used?  Probably qemu_chr_delete
> callers should be changed to use object_unparent or object_unref directly=
.

I thought about that, but calling object_unparent() seems weird, since call=
ers aren't much aware of the fact that chardev are added or not to a contai=
ner (useless distinction imho). I wish the last object_unref() would automa=
tically unparent, if the object has a parent. Would that be acceptable?
