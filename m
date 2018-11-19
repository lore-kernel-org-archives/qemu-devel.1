Received: from eggs.gnu.org ([2001:4830:134:3::10]:33523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gOsg3-0005AA-3G
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 18:09:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gOsg0-0000tX-1P
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 18:09:59 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:44648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gOsfz-0000t6-Ro
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 18:09:55 -0500
Date: Tue, 20 Nov 2018 00:09:53 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181119230953.6z6ottolkfygao2s@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114143014.GB3103@stefanha-x1.localdomain>
	<b17fd075-7142-d7db-0df7-16938b5bd245@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 05/41] slirp: use a callback
 structure to interface with qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, rjones@redhat.com, renzo@cs.unibo.it

Philippe Mathieu-Daud=C3=A9, le mer. 14 nov. 2018 14:10:15 +0100, a ecrit=
:
> With the const qualifier:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Stefan Hajnoczi, le mer. 14 nov. 2018 14:30:14 +0000, a ecrit:
> On Wed, Nov 14, 2018 at 04:36:07PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > -typedef void (*slirp_output)(void *opaque, const uint8_t *pkt, int p=
kt_len);
> > +typedef struct SlirpCb {
> > +    void (*output)(void *opaque, const uint8_t *pkt, int pkt_len);
> > +} SlirpCb;
>=20
> Please include doc comments for each SlirpCb callback introduced by thi=
s
> series.  Otherwise it will be hard for other people to use libslirp.

I have added both and pushed to my tree, thanks!

Samuel
