Received: from eggs.gnu.org ([2001:4830:134:3::10]:42290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e4frk-0001R0-2e
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e4frh-0000j2-02
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:22:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e4frg-0000hm-Qn
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:21:56 -0400
Date: Wed, 18 Oct 2017 07:21:51 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171018071906-mutt-send-email-mst@kernel.org>
References: <69fd8746-b2bd-31d0-4d70-792f40ef2d79@amd.com>
	<20170908131555.GD32645@redhat.com>
	<9BF693FD-B1CD-4813-86B4-4A909D8847A1@amd.com>
	<20170908145201.GJ32645@redhat.com>
	<82d6b8f0-7101-1d59-5489-43b66107fbe0@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82d6b8f0-7101-1d59-5489-43b66107fbe0@amd.com>
Subject: Re: [Qemu-devel] libvirt/QEMU/SEV interaction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brijesh Singh <brijesh.singh@amd.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, "Relph, Richard" <Richard.Relph@amd.com>, "libvir-list@redhat.com" <libvir-list@redhat.com>, "Lendacky, Thomas" <Thomas.Lendacky@amd.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Fri, Sep 08, 2017 at 10:48:10AM -0500, Brijesh Singh wrote:
> > >      > 11. GO verifies the measurement and if measurement matches then it may
> > >      >  give a secret blob -- which must be injected into the guest before
> > >      >  libvirt starts the VM. If verification failed, GO will request cloud
> > >      >  provider to destroy the VM.

I realised I'm missing something here: how does GO limit the
secret to the specific VM? For example, what prevents hypervisor
from launching two VMs with the same GO's DH, getting measurement
from 1st one but injecting the secret into the second one?

Thanks,

-- 
MST
