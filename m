Received: from eggs.gnu.org ([2001:4830:134:3::10]:59406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ea0Gl-00021s-3K
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:25:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ea0Gh-0005ux-Lj
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:25:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ea0Gh-0005tR-35
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:25:15 -0500
Date: Fri, 12 Jan 2018 14:22:28 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180112142228.GD11423@stefanha-x1.localdomain>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-17-peterx@redhat.com>
	<20180108170916.GH11758@stefanha-x1.localdomain>
	<20180112060515.GJ2551@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Content-Disposition: inline
In-Reply-To: <20180112060515.GJ2551@xz-mi>
Subject: Re: [Qemu-devel] [RFC v6 16/27] monitor: separate QMP parser and
 dispatcher
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


--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2018 at 02:05:15PM +0800, Peter Xu wrote:
> On Mon, Jan 08, 2018 at 05:09:16PM +0000, Stefan Hajnoczi wrote:
> > On Tue, Dec 19, 2017 at 04:45:46PM +0800, Peter Xu wrote:
> >=20
> > > +     */
> > > +    bool need_resume;
> >=20
> > This isn't really a per-request decision so a QMPRequest field is not
> > necessary.  If "oob" is enabled then we dispatch commands without
> > waiting.  If "oob" is disabled then we complete the current command
> > before dispatching the next one.
>=20
> I explicitly added this to make sure the suspend and resume will be
> paired up.  Actually there is at least one exception, which is the
> initial "qmp_capabilities" command especially when used to enable the
> OOB capability. For that case, OOB is not enabled before execution,
> while OOB is enabled during the execution and after running the
> command.  If without this field, monitor can hang.

Good point, your approach avoids bugs.  It's safest to leave it as is.

--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaWMSkAAoJEJykq7OBq3PIV6kIAMOS/YqY8dLlHnBIqRmGaxPG
1qqpG46zjdff2/7QPpFaOd7OTbs0TPO5iB69kDkWIRSV3inKPEB1+C8iY0rpTOzC
SBVQhD5C5MjAHgpxvIlmpeFDd6tfLZbUKrlQ/cjmQ8qAOXRLu7eaz+7/CUZ0vHQ5
WvcWJU6dxpv1zMg7Y+IyDgnO31BXJZnbNULNlnMBcpkS8bcX6dljKowQiuby0cfI
8wMbwUmG0ARJ7j8K9orRZxTdJzTbdVZj/qTrrDK7iA3m4sBkWdpEWJRDVTnF1lvz
594cSEgzCb0cBPfgi1ai7fyiT/tD6q4ll6xSJSwTd58kJX5T3jpRAkaxB8/lPds=
=jUfO
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--
