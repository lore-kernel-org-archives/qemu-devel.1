Received: from eggs.gnu.org ([2001:4830:134:3::10]:50022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePRkY-0004kU-Sy
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ePRkT-0007aU-DN
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:32:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ePRkT-0007a2-62
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 06:32:21 -0500
Date: Thu, 14 Dec 2017 11:32:09 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171214113209.GF14433@stefanha-x1.localdomain>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-18-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ChQOR20MqfxkMJg9"
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


--ChQOR20MqfxkMJg9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 05, 2017 at 01:51:51PM +0800, Peter Xu wrote:
> +##
> +# @RequestDropReason:
> +#
> +# Reasons that caused one command to be dropped.
> +#
> +# @queue-full: the queue of request is full.

Please add:

  This can only occur when the client sends a new non-oob command before
  the response to the previous non-oob command has been received.

This way simple clients that only send 1 command at a time don't need to
worry about queue-full.  I think this documents the behavior implemented
by this patch series.

--ChQOR20MqfxkMJg9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMmE5AAoJEJykq7OBq3PIMZoH/3qOwjDjcoA4O2LQO54IY5TZ
+WPHhw/o8ff0dPQUyOzJxlI6Z9c0117T3HPJI49FjrPytOuWzyeAsOMMojdLK89s
fSpvy7gT4ffX2zGcxzJaOSjnCKalJ4eukvGXIyMVy7gQS2trzHd2XiuXMpO02Tki
Nvb3S2tRLmKYTkOcViD1GFYoLO8HTGTU2Q/eREmvnVWZgyBJ73WrLeBFibQhCGcG
NtaN5tkJUqD+miFJRuGmV1JbAETd8XCItNkQM2hGOjL86W+EbD4oEoRxmX59cBhv
IHDb0bNeZ10fTs4/3xwv3mrvadQvNO6OVxReliNwGAgMHT9nWrjsreND9h1o/KA=
=OVUx
-----END PGP SIGNATURE-----

--ChQOR20MqfxkMJg9--
