Received: from eggs.gnu.org ([2001:4830:134:3::10]:36241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fijM3-0002Jg-Jo
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 12:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fijM0-0004XR-GT
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 12:43:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36988 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1fijM0-0004Uq-9j
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 12:43:04 -0400
Date: Thu, 26 Jul 2018 10:42:52 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180726104252.3d162f34@t450s.home>
In-Reply-To: <20180726191315-mutt-send-email-mst@kernel.org>
References: <DB5PR05MB11605C65D7D734C9354F0421D54F0@DB5PR05MB1160.eurprd05.prod.outlook.com>
	<1407239306.11199051.1530240887935.JavaMail.zimbra@redhat.com>
	<20180705194311-mutt-send-email-mst@kernel.org>
	<DB5PR05MB1160D84E747DA480435B6605D5440@DB5PR05MB1160.eurprd05.prod.outlook.com>
	<DB5PR05MB1160BB381473C723C8336EC2D55A0@DB5PR05MB1160.eurprd05.prod.outlook.com>
	<AM5PR0501MB2499CB4F2D01BCDA47C0ACB6C95A0@AM5PR0501MB2499.eurprd05.prod.outlook.com>
	<DB5PR05MB1160093E018FD91787E80A79D5590@DB5PR05MB1160.eurprd05.prod.outlook.com>
	<20180726145214.GD17777@stefanha-x1.localdomain>
	<488bdc8d-e36c-ad3e-f7b3-a45a78a99dda@gmail.com>
	<20180726191315-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Question: SRIOV support over Win Hyper-V VM
 running in QEMU process on Linux host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Tal Attaly <talat@mellanox.com>, Stefan Hajnoczi <stefanha@gmail.com>, Knut Omang <knut.omang@oracle.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Elijah Shakkour <elijahs@mellanox.com>

On Thu, 26 Jul 2018 19:14:45 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Jul 26, 2018 at 06:51:13PM +0300, Marcel Apfelbaum wrote:
> > Hi
> > 
> > On 07/26/2018 05:52 PM, Stefan Hajnoczi wrote:  
> > > On Thu, Jul 12, 2018 at 07:33:14AM +0000, Elijah Shakkour wrote:  
> > > > Hey,
> > > > 
> > > > Our team is adding a NIC functional  emulation to QEMU.
> > > > One of the features we are adding to this NIC is SRIOV.
> > > > 
> > > > Here is the error message I get when checking SRIOV support of  our emulated NIC on Win2016 server (the hyper-v VM).
> > > > "
> > > > SR-IOV cannot be used on this system as the PCI Express hardware does not support Access Control Services (ACS) at any root port.  
> > 
> > QEMU's emulated PCI Express Root Ports do not support ACS yet, however I am
> > not sure ACS is a prerequisite
> > for SR-IOV.

ACS is certainly not a prerequisite for SR-IOV.
 
> Looks like windows blocks dev assignment in nested VMs without it.
> Thinking about it, doesn't vfio do the same by default? I think vfio has
> a flag to override this though.

IOMMU grouping in Linux takes isolation via ACS and device specific
mechanisms into account, limiting the granularity with which a
userspace driver can claim ownership of devices, but it doesn't
actually prevent enabling SR-IOV on the endpoint.  It just makes it
less useful if your intention is to use SR-IOV for device assignment.
The only overrides for this are out-of-tree.  Thanks,

Alex
