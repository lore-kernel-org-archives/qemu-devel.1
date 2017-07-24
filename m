Received: from eggs.gnu.org ([2001:4830:134:3::10]:59035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZbiQ-0003tB-Iu
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:39:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZbiN-00085I-Fv
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:39:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dZbiN-00083Y-9B
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:39:55 -0400
Date: Mon, 24 Jul 2017 12:39:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170724113952.GD2784@stefanha-x1.localdomain>
References: <20170721143149.43721-1-vsementsov@virtuozzo.com>
	<20170721143149.43721-3-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZJcv+A0YCCLh2VIg"
Content-Disposition: inline
In-Reply-To: <20170721143149.43721-3-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] monitor: improve tracing in
 handle_qmp_command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, armbru@redhat.com, den@openvz.org


--ZJcv+A0YCCLh2VIg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 21, 2017 at 05:31:49PM +0300, Vladimir Sementsov-Ogievskiy wrot=
e:
> Calculate req_json only if trace_handle_qmp_command enabled.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Is there a real-world performance issue?

(I'm not against this change but it's important to understand the
rationale for performance optimizations.)

The monitor is a control channel.  Anything using it at high frequency
with low latency expectations will be disappointed.  We should look at
such cases and decide whether the monitor really is the appropriate
interface for them.

Stefan

--ZJcv+A0YCCLh2VIg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZddyIAAoJEJykq7OBq3PIvCIH/0zcbfDrN2OUJWSIMq3XBp0I
79tvn2HggZQPwLMkVqCnqEIYjPSAsZFh1q3lK9jcxc3cymp1GyJht5JjpO9LuaDK
Jjn+Q+B4Z5zitqBcRQOnLwPmXiDr1BDV4O7GdgO++6ch0qQ5hwGd94RT/CguSckk
V1EcH9+Gz7N8ZNjvmeChY0JvsgZEU/SLdCOqsz/qAm5BKyKZbLZa1wjLijpE2Xho
+uBrzNuV1LqvR1mdy03GsWM8sNRsCDLH8eZWYvKJfXYy6OjpnfBzFh+9P6hxmfwj
MNpWxTfVVsc6EMwvwTC8ywpa5ZDqxQVEIqrSdriU0+fuR5jGzoTNtda47XYkk4w=
=9aJc
-----END PGP SIGNATURE-----

--ZJcv+A0YCCLh2VIg--
