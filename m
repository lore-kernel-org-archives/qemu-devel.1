Received: from eggs.gnu.org ([2001:4830:134:3::10]:51937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e7j8F-0006k3-Cj
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e7j8C-0008SO-LW
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:27:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e7j8C-0008R0-EA
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 10:27:36 -0400
Date: Thu, 26 Oct 2017 17:27:31 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171026172631-mutt-send-email-mst@kernel.org>
References: <1502842933-8323-1-git-send-email-tianyu.lan@intel.com>
	<34042934-782b-6bcc-b9b2-de7a1816cfb7@redhat.com>
	<3ababa62-f055-5bbb-b9b9-c55ada8368dd@intel.com>
	<20170818163854.GY3108@localhost.localdomain>
	<471a4bdc-d381-4a70-0107-3150df6f5cf6@intel.com>
	<20171026121943.GB26955@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171026121943.GB26955@localhost.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] x86: Skip check apic_id_limit for Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>, qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, anthony.perard@citrix.com, Paolo Bonzini <pbonzini@redhat.com>, rth@twiddle.net

On Thu, Oct 26, 2017 at 02:19:43PM +0200, Eduardo Habkost wrote:
> On Mon, Aug 21, 2017 at 10:22:15AM +0800, Lan Tianyu wrote:
> > On 2017=E5=B9=B408=E6=9C=8819=E6=97=A5 00:38, Eduardo Habkost wrote:
> > > On Thu, Aug 17, 2017 at 09:37:10AM +0800, Lan Tianyu wrote:
> > >> On 2017=E5=B9=B408=E6=9C=8816=E6=97=A5 19:21, Paolo Bonzini wrote:
> > >>> On 16/08/2017 02:22, Lan Tianyu wrote:
> > >>>> Xen vIOMMU device model will be in Xen hypervisor. Skip vIOMMU
> > >>>> check for Xen here when vcpu number is more than 255.
> > >>>
> > >>> I think you still need to do a check for vIOMMU being enabled.
> > >>
> > >> Yes, this will be done in the Xen tool stack and Qemu doesn't have=
 such
> > >> knowledge. Operations of create, destroy Xen vIOMMU will be done i=
n the
> > >> Xen tool stack.
> > >=20
> > > Shouldn't we make QEMU have knowledge of the vIOMMU device, then?
> > > Won't QEMU need to know about it eventually?
> > >=20
> >=20
> > Hi Eduardo:
> >      Thanks for your review.
> >      Xen has some guest modes which doesn't use Qemu and we tried to
> > make Xen vIOMMU framework compatible with all guest modes. So far, we
> > are adding interrupt remapping function for Xen vIOMMU and find qemu
> > doesn't need to know Xen vIOMMU. The check of vcpu number > 255 here
> > will be done in Xen side and so skip the check in Qemu to avoid block=
ing
> > Xen creating >255 vcpus.
> >      We may make Qemu have knowledge of the vIOMMU device if it's
> > necessary when adding new function.
>=20
> I was expecting it to go through the PC tree, but I will queue it
> on x86-next instead.

I was waiting for an ack from you or Paolo as you participated in the
discussion. But sure, go ahead

Acked-by: Michael S. Tsirkin <mst@redhat.com>



> --=20
> Eduardo
