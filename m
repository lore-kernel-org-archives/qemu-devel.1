Received: from eggs.gnu.org ([2001:4830:134:3::10]:53269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fYa8k-0001rN-Kn
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fYa8j-0005mL-Nu
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:51:26 -0400
Date: Thu, 28 Jun 2018 17:51:18 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180628165118.GH1455@redhat.com>
References: <20180628132211.8795-1-rjones@redhat.com>
	<20180628132211.8795-2-rjones@redhat.com>
	<cf457707-eaab-16f9-d1c9-3a3f6423958e@redhat.com>
	<20180628160620.GS3513@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180628160620.GS3513@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] crypto: Implement TLS Pre-Shared Keys
 (PSK).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, Jun 28, 2018 at 05:06:20PM +0100, Daniel P. Berrang=E9 wrote:
> On Thu, Jun 28, 2018 at 09:42:18AM -0500, Eric Blake wrote:
> > Does it make sense to forbid this operation on servers (since it only=
 makes
> > sense for clients)?
>=20
> We can't validate that here, because we can't guarantee that 'endpoint'
> is set before 'username' is set.
>=20
>=20
> We could enforce it in the setter for the "loaded" property as that is
> set only after every other property is set.

As far as I can see we could only warn here, since the set_loaded
function returns void.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top
