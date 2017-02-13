Received: from eggs.gnu.org ([2001:4830:134:3::10]:51868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdHEk-0003xC-Th
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:04:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cdHEg-0006do-TJ
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:04:14 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cdHEg-0006dd-O8
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:04:10 -0500
Received: by mail-wr0-x242.google.com with SMTP id k90so24218607wrc.3
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 06:04:10 -0800 (PST)
Date: Mon, 13 Feb 2017 14:04:07 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170213140407.GF10361@stefanha-x1.localdomain>
References: <20170204143245.15974-1-famz@redhat.com>
	<20170207151455.GH8583@stefanha-x1.localdomain>
	<982135c3-51c5-d6d4-d3f1-328ec766a07e@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Content-Disposition: inline
In-Reply-To: <982135c3-51c5-d6d4-d3f1-328ec766a07e@imgtec.com>
Subject: Re: [Qemu-devel] [PATCH] Makefile: Make "install" depend on
 "trace-events-all"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Gilmore <Doug.Gilmore@imgtec.com>
Cc: qemu-devel@nongnu.org


--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 07, 2017 at 02:25:31PM -0800, Doug Gilmore wrote:
> On 02/07/2017 07:14 AM, Stefan Hajnoczi wrote:
> > On Sat, Feb 04, 2017 at 10:32:45PM +0800, Fam Zheng wrote:
> >> We install this file to data dir but since 0ab8ed18 it's no longer
> >> required by any objects during "make". List it explicitly as a depended
> >> target of install and fix the broken "make install" command.
> >>
> >> Signed-off-by: Fam Zheng <famz@redhat.com>
> >> ---
> >>  Makefile | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > Thanks, applied to my tracing tree:
> > https://github.com/stefanha/qemu/commits/tracing
> >=20
> > Stefan
> >=20
> Are there plans to commit this change?
>=20
> AFAICS, ToT builds are broken without this change.

Hi Doug,
I've been mostly offline due to illness but am back now.  The pull
request will be sent today.

Stefan

--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYobzXAAoJEJykq7OBq3PIM6MIAJIzEzX1F9CLW2FmNn49s+Rt
ZQdXMOq9Uw3bFQjqpOF0hQwsz/cGb4CFDFzOhIsru0/mwKa/tm12HjJjgJPjZslu
GEsZfN/Q8WwckvN+k2JbSEiuCGJWFKSZKvZj/PZRIh2qJZHFl48jaPZ5xwmDXg0L
mlIFML7riaJW3YgZFOYkNw55JteDSoTw5IDWEoSAQpRH0wAbKTErurirJTziGh6O
6ptzvwdKftcu3MlcwaALzWQoDzd9U4kThC63RNXNyJFBbFeTRm57Faorr4f//ppP
RMxtHUIhbq3t9OMkqAxVGCVCb3k6+Vs8vegLlD1gNXAGwN8otGG6fgeWOLrTKYo=
=L7kU
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--
