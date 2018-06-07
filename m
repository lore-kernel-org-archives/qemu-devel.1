Received: from eggs.gnu.org ([2001:4830:134:3::10]:50601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fQzdd-0004EZ-Dy
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:27:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1fQzdc-0003X2-IJ
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 14:27:57 -0400
Date: Thu, 7 Jun 2018 20:27:43 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
Message-ID: <20180607182743.GC1933@paraplu>
References: <20180606121624.GD2661@work-vm>
	<2d572c2f-8dda-87db-ec26-6f2230375424@redhat.com>
	<20180606140233.GF2660@work-vm>
	<66366ae1-1db8-7121-bfcc-f2096d0c954f@redhat.com>
	<20180606144140.GH2660@work-vm>
	<cea4f615-c768-7a2f-3849-5dd00c37b537@redhat.com>
	<20180606172523.3816a882@kitsune.suse.cz>
	<a1d7851c-e01f-4190-cc8f-af98531e6379@redhat.com>
	<20180606203339.0085207d@kitsune.suse.cz>
	<20180606183653.GU7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180606183653.GU7451@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Jun 06, 2018 at 03:36:53PM -0300, Eduardo Habkost wrote:
> On Wed, Jun 06, 2018 at 08:33:39PM +0200, Michal Such=E1nek wrote:
> [...]
> > Lastly we are missing a developer of a management layer committed to
> > support such appliances.
>=20
> This is important.  Without developers of management tools
> willing to help specify the requirements and implement the
> feature, all the work in the lower layers would be useless.

FWIW, I'm following along from the OpenStack 'Nova' (it allows you to
provision VMs / QEMU instances) point of view.

Here is a bug (filed by Eduardo) that is tracking what needs to fixed in
Nova:

    https://bugzilla.redhat.com/show_bug.cgi?id=3D1581414 -- OpenStack
    shouldn't break if the default machine-type in QEMU is "q35"

Refer to comment#6 and comment#11 for some analysis as to where Nova
makes assumptions for machine types.  (There is one instance of it.)

Related: Elsewhere on this KM-long thread, Dan Berrang=E9 and myself have
noted how Nova allows configuring machine types today -- either via
setting a config attribute (in /etc/nova/nova.conf) per Compute node
(where QEMU processes are launched) or via setting a metadata property
per template disk image, which is used to launch Nova instances (VMs).

--=20
/kashyap
