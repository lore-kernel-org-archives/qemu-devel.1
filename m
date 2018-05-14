Received: from eggs.gnu.org ([2001:4830:134:3::10]:52644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fID4b-0007Rb-Of
	for qemu-devel@nongnu.org; Mon, 14 May 2018 08:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fID4X-0003WE-5o
	for qemu-devel@nongnu.org; Mon, 14 May 2018 08:59:29 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:38535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fID4W-0003Vz-Ty
	for qemu-devel@nongnu.org; Mon, 14 May 2018 08:59:25 -0400
Received: by mail-wr0-x242.google.com with SMTP id 94-v6so12246362wrf.5
	for <qemu-devel@nongnu.org>; Mon, 14 May 2018 05:59:24 -0700 (PDT)
Date: Mon, 14 May 2018 13:59:21 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180514125921.GA5182@stefanha-x1.localdomain>
References: <1520930033-18885-1-git-send-email-junyan.he@intel.com>
	<1520930033-18885-3-git-send-email-junyan.he@intel.com>
	<433eb0d1-c6b2-ff49-26b6-664636cfe5b0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <433eb0d1-c6b2-ff49-26b6-664636cfe5b0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/10] RFC: Implement qcow2's snapshot
 dependent saving function.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: junyan.he@intel.com, qemu-devel@nongnu.org, kwolf@redhat.com, famz@redhat.com, quintela@redhat.com, crosthwaite.peter@gmail.com, dgilbert@redhat.com, mreitz@redhat.com, Pavel Dovgaluk <Pavel.Dovgaluk@ispras.ru>, pbonzini@redhat.com, rth@twiddle.net


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 08, 2018 at 09:50:00AM -0500, Eric Blake wrote:
> On 03/13/2018 03:33 AM, junyan.he@intel.com wrote:
> > From: Junyan He <junyan.he@intel.com>
> >=20
> > For qcow2 format, we can increase the cluster's reference count of
> > dependent snapshot content and link the offset to the L2 table of
> > the new snapshot point. This way can avoid obvious snapshot's dependent
> > relationship, so when we delete some snapshot point, just decrease the
> > cluster count and no need to check further.
> >=20
> > Signed-off-by: Junyan He <junyan.he@intel.com>
> > ---
> >   block/qcow2-snapshot.c | 154 ++++++++++++++++++++++++++++++++++++++++=
+++++++++
> >   block/qcow2.c          |   2 +
> >   block/qcow2.h          |   7 +++
> >   3 files changed, 163 insertions(+)
>=20
> It sounds like you are trying to modify the qcow2 spec to store more
> information into the internal snapshot table (and if you aren't, why not?=
 If
> an internal snapshot depends on another one and we don't record that
> information in the qcow2 metadata, then we are pushing the burden of
> tracking inter-relationships onto management apps, and risk corruption if
> you load a snapshot without also visiting its dependencies).  It is
> absolutely essential that such modifications be reflected in
> docs/interop/qcow2.txt first, to make sure we agree on the implementation.
> What's more, there is already another parallel proposal that is also want=
ing
> to tweak qcow2 files:
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg05231.html
>=20
> We need to make sure both additions are coordinated.

I think the relationship doesn't need to be stored.  The point of this
snapshot clone operation is to share some of the clusters of the parent
snapshot (using qcow2's existing cluster reference counts).  Cloning
avoids having to write a duplicate copy of those clusters.

Stefan

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa+YgpAAoJEJykq7OBq3PIZqMH/iE/oy5uAdsGA+TiBnx1i0NI
/GMBUxOtbXOaWuZfHoa27MtGcr8MoakI701mNwD6Rr8jc7f71Mb57hjg1ASuh9Bx
/OwWOVUIY314i7+3pgMKzFvjb9yUqhFYa7x+25nKGi2u/+dq0qql+lnmZ0zzMdrq
q2TkczaROXeK36V5HxBK8/rZTsZUuJxL4K9d4qqCgtPpWSOE4lXjb8gITTtFmOTv
wIRiX7UxwtC8J5+xl+cBwxFt4LcUWr9jMH4sIFVvtVqZKxRpVUuxVryMy7ppxvRc
PUXmq7Q2YZ0MGAsqBT1RHkuio49fx1YuA7nb470lDnIVzvk0WSFQGDDAjjffTu8=
=qzQa
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
