Received: from eggs.gnu.org ([2001:4830:134:3::10]:46577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYtpR-00029s-FF
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:20:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYtpP-0006uN-H7
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:20:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eYtpP-0006tq-A8
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 08:20:31 -0500
Date: Tue, 9 Jan 2018 13:20:20 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180109132020.GB31400@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-18-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-18-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 17/27] qmp: add new event "command-dropped"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 04:45:47PM +0800, Peter Xu wrote:
> This event will be emitted if one QMP command is dropped.  Along,
> declare an enum for the reasons.
>=20
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  qapi-schema.json | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>=20
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 531fd4c0db..447ab25572 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -3222,3 +3222,40 @@
>  # Since: 2.11
>  ##
>  { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'=
} }
> +
> +##
> +# @CommandDropReason:
> +#
> +# Reasons that caused one command to be dropped.
> +#
> +# @queue-full: the queue of command is full. This can only occur when

s/the queue of command is full/the command queue is full/

--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaVMGUAAoJEJykq7OBq3PIRQwIAMMqhNszHbUTG8fXqsMJvljj
3LW3t8T/ozezSLPzAyxRfWKGE6mZ3R9oUOR8Pl5yzOI8sTm/NTQdytQE1TXlbVby
iyS+ZvWYR7K6khIeSi1Naso9fWSFl8G+RBshzcLufmoq8D4C/SB7aLBjf69F11/q
AJyBkwFlaqWInCHmsRy5jd2jgjNUKG8zkvP58fup/eZaSK9Z2ZnfYwIGmGeSwtU0
brC6xdpJEj696IG2xNCDXFwm+7Wp5IIefhspYIR2R8Afk1H1ZM8t0GC3yrSmjhyo
ijbenHMVwahaG03iMspT7/nwO1t0uBdE8UdfwnOGyi8ICEDVz52PcloNygUneGQ=
=Zj8Y
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
