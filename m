Received: from eggs.gnu.org ([2001:4830:134:3::10]:35837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZf9L-0001qh-7a
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:56:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gZf9G-0006ly-96
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:56:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:3379)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gZf9G-0006lT-3F
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 11:56:42 -0500
Date: Wed, 19 Dec 2018 11:56:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181219115341-mutt-send-email-mst@kernel.org>
References: <1544465415-207855-1-git-send-email-imammedo@redhat.com>
	<20181219113611-mutt-send-email-mst@kernel.org>
	<20181219164517.GN20465@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181219164517.GN20465@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/9] tests: apci: consolidate and cleanup
 ACPI test code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Samuel Ortiz <sameo@linux.intel.com>

On Wed, Dec 19, 2018 at 04:45:17PM +0000, Daniel P. Berrang=E9 wrote:
> On Wed, Dec 19, 2018 at 11:38:36AM -0500, Michael S. Tsirkin wrote:
> > On Mon, Dec 10, 2018 at 07:10:06PM +0100, Igor Mammedov wrote:
> > > While working on adding tests for virt/arm board (uefi/XSDT/64-bit =
table pointers),
> > > I found it's rather difficult to deal with mixed ACPI testing code =
that we've
> > > collected so far. So instead of just adding a pile of XSDT hacks on=
 top, here
> > > goes small refactoring series:
> > >    * that removes dead code
> > >    * replaces reading tables with a fetch per table everywhere inst=
ead of
> > >      mix of field by field and whole table
> > >    * consolidates the way tables are read (reduces code duplication=
)
> > >    * test no longer depends on ACPI structures from QEMU (i.e. does=
n't affected
> > >      by mistakes there)=20
> > >    * fixiex FACS not beint compared against reference tables
> > > Overall test is reduced on ~170LOC and hopefully it makes easier to=
 add more
> > > stuff on top.
> >=20
> > So this was posted outside the merge window - do you still want
> > it merged? If yes pls repost.
>=20
> Huh, QEMU development does not have merge windows. Subsystem maintainer=
s
> should review patch series at any time & queue it if it is acceptable.
> The freeze process only applies to maintainers sending pull requests fo=
r
> merge to git mater.  Contributors shouldn't be expected to resubmit
> patches in this case.
>=20
> Regards,
> Daniel

Yea, I try to help drive-by contributors by tracking their patches even
during the freeze. Merged some of these in the 1st pull req.  But Igor
is a co-maintainer of the ACPI subsystem. Shouldn't be a problem.

> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
