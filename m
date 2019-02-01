Received: from eggs.gnu.org ([209.51.188.92]:32949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gpVko-0003au-UR
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gpVkn-0003fg-Vr
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 05:08:58 -0500
Date: Fri, 1 Feb 2019 18:08:47 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190201100847.GC30277@stefanha-x1.localdomain>
References: <20190131151914.164903-1-sgarzare@redhat.com>
	<20190131151914.164903-4-sgarzare@redhat.com>
	<20190201045831.GD23131@stefanha-x1.localdomain>
	<20190201095430.qemq2viy4enwk62y@steredhat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
Content-Disposition: inline
In-Reply-To: <20190201095430.qemq2viy4enwk62y@steredhat>
Subject: Re: [Qemu-devel] [PATCH v2 3/5] virtio-blk: add DISCARD and WRITE
 ZEROES features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 01, 2019 at 10:54:30AM +0100, Stefano Garzarella wrote:
> On Fri, Feb 01, 2019 at 12:58:31PM +0800, Stefan Hajnoczi wrote:
> > On Thu, Jan 31, 2019 at 04:19:12PM +0100, Stefano Garzarella wrote:
> Only a question about options: I used a single option "dwz_max_sectors"
> for both "max_discard_sectors" and "max_write_zeroes_sectors".
> Since I'll include two options to enable/disable discard and
> write_zeroes features, do you think make sense to split this
> configurable option in two?

Yes, please.  Eventually a user will want full control so it makes sense
to expose what virtio offers instead of coming up with higher-level
options.

Stefan

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcVBqvAAoJEJykq7OBq3PIGmgH/jE4LKhXpAmeLb4aY53HHOqB
6FwV6WP9FcUG20LmANf4kG1WEteVfxUncActxjx42Q8J4OHK3tGDAt/P3/sfbaqL
J2BEnACSLY9CqRw7aQjZCNS3uaQjBAHT9QFWPqXwcuYRbjw0AxbpL5nafN0A23cG
NJl9JxHQDJ2+tNPYSm/3B3tXB0wnBMMedUIpgTFk6rcIYaTolRY/w2GY8a0SB3sJ
lC+uwSCjEJFTk+xhm+34QwSurG9Oup7x5usXEwRjnHKWg+e/ToFfuXKtfLGDCuZq
2a5acrbuCUaOHGMrjbdsTzXRbdcmOnP1JwY+4EkKHGWtozDq5E/0aBAqAtNe2vs=
=UlBV
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
