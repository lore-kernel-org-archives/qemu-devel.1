Received: from eggs.gnu.org ([2001:4830:134:3::10]:39219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY9Ik-0006st-Ll
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:11:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fY9Ij-0004hw-QY
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:11:58 -0400
Date: Wed, 27 Jun 2018 13:11:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180627121149.GN5955@stefanha-x1.localdomain>
References: <1528759585-51780-1-git-send-email-wangjie88@huawei.com>
	<20180618155045.GB9785@stefanha-x1.localdomain>
	<631d637f-d959-54fd-8d93-808ee937e885@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/JIF1IJL1ITjxcV4"
Content-Disposition: inline
In-Reply-To: <631d637f-d959-54fd-8d93-808ee937e885@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v2] util/async: avoid NULL pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "WangJie (Pluto)" <wangjie88@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com


--/JIF1IJL1ITjxcV4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 26, 2018 at 10:51:50AM +0800, WangJie (Pluto) wrote:
> Thanks Stefan, will you push it to master branch?

Hi,
I have replaced this patch with "[PATCH v4] linux-aio: properly bubble
up errors from initialization".  It solves the issue at initialization
time so aio_get_linux_aio() callers don't need to check for NULL.

Kevin pointed out the other patch.  Sorry that work was duplicated, it
seems that both you and the other author worked on this bug at the same
time.

Please feel free to review "[PATCH v4] linux-aio: properly bubble up
errors from initialization" and reply on that email thread if you have
any concerns.

Stefan

--/JIF1IJL1ITjxcV4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbM38FAAoJEJykq7OBq3PI4HUIAIz9sQ0nss1m+hAX4fTKfTcl
R1dCtfnEj6OqqJosQnWjnOoKq8uTBcHsUXQszM5KqB8fGaqpOd4GCw+ZCGV4UlPM
MzVHOs5t5ym+8sARUkzwSb5PKqVOL8rSfqUe3M0r+mRx4yHIPwBw1E7tJwpPgjbD
pERVcyPqE4oEvVU/JmEWY/27lpRyt830cHepFia0o33y2z6e48+eRR3iESREZaOS
yOxRwbFlbikKhboaGtGTBllo1UJdWrnV6UqpKda3pybXW5CBWOrz4Qpw+GYd1hSk
sBN9kiCSjwDr78LK/YyFbxJJGFHcTbFEhrVlFY9Hz2J33DfXY02MikXDn9gNz8s=
=//1G
-----END PGP SIGNATURE-----

--/JIF1IJL1ITjxcV4--
