Received: from eggs.gnu.org ([2001:4830:134:3::10]:35075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fRHUf-0008J4-HV
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fRHUa-0002Gr-Il
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:31:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40582 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fRHUa-0002Gi-Cp
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 09:31:48 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A05E400ADC3
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 13:31:48 +0000 (UTC)
Date: Fri, 8 Jun 2018 14:31:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180608133146.GD31164@stefanha-x1.localdomain>
References: <20180608035511.7439-1-peterx@redhat.com>
	<20180608035511.7439-6-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="76DTJ5CE0DCVQemd"
Content-Disposition: inline
In-Reply-To: <20180608035511.7439-6-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 5/7] monitor: remove event_clock_type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--76DTJ5CE0DCVQemd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 11:55:09AM +0800, Peter Xu wrote:
> Instead, use a dynamic function to detect which clock we'll use.  The
> problem is that the old code will let monitor initialization depend on
> configure_accelerator() (that's where qtest_enabled() start to take
> effect).  After this change, we don't have such a dependency any more.
> We just need to make sure configure_accelerator() is called when we
> start to use it.  Now it's only used in monitor_qapi_event_queue() and
> monitor_qapi_event_handler(), so we're good.
>=20
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)

With Markus' suggestion:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--76DTJ5CE0DCVQemd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGoVCAAoJEJykq7OBq3PIxQIIAILMiWXEmFLNRNRu1oIFAT7L
Key6MOu+XwPWnUffshVWu4dDMNPdyfWPMS0/gZUva03pejEOC2iUmDaRz9a1Vxv7
AH28W8lmnY09K0Nu7FMnugFXsN5DIiRHdKUMYDQcsW9FxJOoig+Fp99jxyviY0En
OfOX/5+Wvk5PzYddmGzEgCQdVUlUtTQ+zYoMZzeM1f0mpXEUdQM3DWhm8FjVLKsy
DwcG+AS4/uYGj9WI5dMI4emIccgzxH0BfYnHLp/1qZd/L9Txq+xApUY94xU08LkM
gcSsuhGPF/N+5LRA0VXX1cLEVWGNAjvEpO364G/NUWai/wAdUog1m3MexUdglEU=
=yppG
-----END PGP SIGNATURE-----

--76DTJ5CE0DCVQemd--
