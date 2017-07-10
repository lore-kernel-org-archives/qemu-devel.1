Received: from eggs.gnu.org ([2001:4830:134:3::10]:33901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUayy-0001Bt-2L
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUayx-0005c8-AY
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:52:20 -0400
Date: Mon, 10 Jul 2017 16:52:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170710155206.GN14195@stefanha-x1.localdomain>
References: <20170706163828.24082-1-pbonzini@redhat.com>
	<20170706163828.24082-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yAzUYvkKIfeS0jQX"
Content-Disposition: inline
In-Reply-To: <20170706163828.24082-4-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/11] util: use RCU accessors for notifiers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--yAzUYvkKIfeS0jQX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 06:38:20PM +0200, Paolo Bonzini wrote:
>  void notifier_list_notify(NotifierList *list, void *data)
>  {
>      Notifier *notifier, *next;
> =20
> -    QLIST_FOREACH_SAFE(notifier, &list->notifiers, node, next) {
> +    QLIST_FOREACH_SAFE_RCU(notifier, &list->notifiers, node, next) {
>          notifier->notify(notifier, data);
>      }
>  }

Who calls rcu_read_lock() or is it unnecessary?

--yAzUYvkKIfeS0jQX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZY6KmAAoJEJykq7OBq3PIhzkIALZYdMcl4dFiJ9eBQ/VZjjFO
ROIgVT3B5cPKnxXPb7vOUt6PcjZf5GvtP0VGg7jE/LyBpsqlPQOLVZN/OWjkZWHn
DhWriYwkQtwc4pQDj4IeuEX1ixwITkvycvyowCaIxbYWtcMvMzQPpSig7zwRGaAI
6WSe8Y4wA2MTW/Jq7vRjAIKEick0MDZtRNZ9c7T8qW4LWRxUqIaDClxAMvVd+k0g
tzAIjR1JCYOqY+HYcyiIaawl57kOk6p77Y+EKbPBSsvLxC9Vi8m+hRL9wU+GH+D7
YFabJcCztICuQkvK2xPHzBV5ZM8/w4FdYT0QqHSDk4L7r0dBQBlM7hFKRFur4dc=
=71Pj
-----END PGP SIGNATURE-----

--yAzUYvkKIfeS0jQX--
