Received: from eggs.gnu.org ([2001:4830:134:3::10]:39782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePRUr-0007oH-QK
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:16:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePRUo-0000OC-Fx
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:16:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePRUo-0000Na-9v
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:16:10 -0500
Date: Thu, 14 Dec 2017 11:16:02 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214111602.GE14433@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-18-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ep0oHQY+/Gbo/zt0"
Content-Disposition: inline
In-Reply-To: <20171205055200.16305-18-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v5 17/26] qmp: add new event "request-dropped"
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


--ep0oHQY+/Gbo/zt0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2017 at 01:51:51PM +0800, Peter Xu wrote:
> +##
> +# @RequestDropReason:
> +#
> +# Reasons that caused one command to be dropped.
> +#
> +# @queue-full: the queue of request is full.
> +#
> +# Since: 2.12
> +##
> +{ 'enum': 'RequestDropReason',

qapi-schema.json calls them "commands", not "requests".  Please rename
it CommandDropReason for consistency and update the documentation.

> +  'data': [ 'queue-full' ] }
> +
> +##
> +# @REQUEST_DROPPED:
> +#
> +# Emitted when one QMP request is dropped due to some reason.
> +# REQUEST_DROPPED is only emitted when the oob capability is enabled.

Please make it clear that requests can only be dropped when the oob
capability is enabled.

  Emitted when a command is dropped due to some reason.  Commands can
  only be dropped when the oob capability is enabled.

--ep0oHQY+/Gbo/zt0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMl1yAAoJEJykq7OBq3PIE5YH/1ejroAJtBn5sSmiVIyeFaKr
UlQ+dq4eC3TeQZXPtZcfQTr2s5GVCtnxGhbVK/YzXpuuhHoB+mQkKOxY6YXfQ+1g
rdd64Qroi9MQ32JwxpyMw9NC5bsm4BAaNmwI8O8fqOAUOnUw27NV825wNusiMM23
u16LurQFMDSWNOOXCHjV6q7GQZ4cNm7NGKgJO0iWwzdw3y3IPs00uoG6j4FarI//
WrUKrBOlg+BXxdy6KmeU4svXW747IoBBPb6BSInN1ogQbEtBMY0YqBm3fpx3dmTK
GX3YXp1XU5WpEzhI9w602o15M4PiLrvSe9E80GV08/VaaRv1HKiw32cVU2LKdeg=
=uJzA
-----END PGP SIGNATURE-----

--ep0oHQY+/Gbo/zt0--
