Received: from eggs.gnu.org ([2001:4830:134:3::10]:53191)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <riel@redhat.com>) id 1dNMGQ-0002IE-SD
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:44:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <riel@redhat.com>) id 1dNMGN-0007Mo-R3
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:44:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <riel@redhat.com>) id 1dNMGN-0007Jy-LJ
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 12:44:23 -0400
Message-ID: <1497977049.20270.100.camel@redhat.com>
From: Rik van Riel <riel@redhat.com>
Date: Tue, 20 Jun 2017 12:44:09 -0400
In-Reply-To: <b92af473-f00e-b956-ea97-eb4626601789@intel.com>
References: <1497004901-30593-1-git-send-email-wei.w.wang@intel.com>
	<1497004901-30593-5-git-send-email-wei.w.wang@intel.com>
	<b92af473-f00e-b956-ea97-eb4626601789@intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-TDh63EvNZF5vpHsR7dYQ"
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v11 4/6] mm: function to offer a page block
 on the free list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dave Hansen <dave.hansen@intel.com>, Wei Wang <wei.w.wang@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, david@redhat.com, cornelia.huck@de.ibm.com, akpm@linux-foundation.org, mgorman@techsingularity.net, aarcange@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com
Cc: Nitesh Narayan Lal <nilal@redhat.com>


--=-TDh63EvNZF5vpHsR7dYQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2017-06-12 at 07:10 -0700, Dave Hansen wrote:

> The hypervisor is going to throw away the contents of these pages,
> right?=C2=A0=C2=A0As soon as the spinlock is released, someone can alloca=
te a
> page, and put good data in it.=C2=A0=C2=A0What keeps the hypervisor from
> throwing
> away good data?

That looks like it may be the wrong API, then?

We already have hooks called arch_free_page and
arch_alloc_page in the VM, which are called when
pages are freed, and allocated, respectively.

Nitesh Lal (on the CC list) is working on a way
to efficiently batch recently freed pages for
free page hinting to the hypervisor.

If that is done efficiently enough (eg. with
MADV_FREE on the hypervisor side for lazy freeing,
and lazy later re-use of the pages), do we still
need the harder to use batch interface from this
patch?

--=20
All rights reversed
--=-TDh63EvNZF5vpHsR7dYQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJZSVDaAAoJEM553pKExN6DemQIAMAsYzL7/wDfstjbSE2Z71w9
alzJ2n2LqI2pfKZYODaamSye2uq/tl38iefZnERfPAaIl1Lfjr1gp1ccw7y7Y1PV
p9kdwZPdMolL50cmhtM507Csc8Pl78zBAiY7Rr6VKUqqzJPOkBah0Xwjv0bedrfV
uYk589971LqP2XuqO3FX8AIz70mVGwOzOHOL/I5ycJ+LOkVX9Y+4l8EO/kRtOjsH
jjjCCXEmWUAYTAc0OTxz5xb9uahZwtWfFl2wg+yWE5/isOMqyjrv730Ezfl/kncv
ac2vj9rnQTijdGvzPz0vK8dbsndNYtU/npy9O4QD7AuFo11t/xaWhJjoyJXx1Ho=
=6nRH
-----END PGP SIGNATURE-----

--=-TDh63EvNZF5vpHsR7dYQ--
