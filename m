Received: from eggs.gnu.org ([209.51.188.92]:59455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gzkqo-00042i-5K
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gzkqn-0001Fe-El
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 11:17:30 -0500
Date: Fri, 1 Mar 2019 16:17:24 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20190301161724.GB18260@stefanha-x1.localdomain>
References: <20190227172256.30368-1-kwolf@redhat.com>
	<20190227172256.30368-4-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
In-Reply-To: <20190227172256.30368-4-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 03/20] qcow2: Extend spec for
 external data files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 27, 2019 at 06:22:39PM +0100, Kevin Wolf wrote:
> -                    Bits 2-63:  Reserved (set to 0)
> +                    Bit 2:      External data file bit.  If this bit is set, an
> +                                external data file is used. Guest clusters are
> +                                then stored in the external data file. For such
> +                                images, clusters in the external data file are
> +                                not refcounted. The offset field in the
> +                                Standard Cluster Descriptor must match the
> +                                guest offset and neither compressed clusters
> +                                nor internal snapshots are supported.
> +
> +                                An external data file name header extension may
> +                                be present if this bit is set.

This sentence is clearer if the header extension name is made prominent:

  An "external data file name" header extension

Or

  An External Data File Name header extension

(In the previous paragraph Standard Cluster Descriptor is also
capitalized.)

> @@ -148,6 +170,7 @@ be stored. Each extension has a structure like the following:
>                          0x6803f857 - Feature name table
>                          0x23852875 - Bitmaps extension
>                          0x0537be77 - Full disk encryption header pointer
> +                        0x44415441 - External data file name

This new header extension isn't described in this patch?

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJceVsUAAoJEJykq7OBq3PIN5AH/3T09NoqIUgayevo6gH1McUQ
f6Lq4jEThHORoeVeahUJP0L5juMF0LE1ti0sTAtGB4hSzFXwwrE0OHWkcXFRjXtp
8ax89g0z4UKifPuz5dduN+V58tZnnR5BfISabK0l9/q0q7PT8J8vZo6dwCjPtJFF
NfBnk6RqiH6+BONmLt9LUKHI2z5zQUNcH/VDMsXhX1MT/569OtrPVrWpBc72aBZj
o5lZY62g2W5qj7npnh1GjpaiqkRxQ5Zcp3saSYxSZqPjBcJYvFY2fDgfBGVVwrA3
ShJXqkbvkh0BS+1/wmFx4jt8ZFkNbEeDhmSiJj8lGha0rxo7isVoyEs0xQOxWwY=
=FV8z
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
