Received: from eggs.gnu.org ([2001:4830:134:3::10]:55267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fVv3Z-0006AT-Rp
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fVv3V-0001JG-Sl
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 04:35:05 -0400
Date: Thu, 21 Jun 2018 10:34:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180621103457.395ed157.cohuck@redhat.com>
In-Reply-To: <152953170557.8870.15609104033222049328@sif>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
	<20180619094248.08d5fed5.cohuck@redhat.com>
	<152952728499.8870.3711510048351515296@sif>
	<152953170557.8870.15609104033222049328@sif>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/113] Patch Round-up for stable 2.11.2,
 freeze on 2018-06-22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>

On Wed, 20 Jun 2018 16:55:05 -0500
Michael Roth <mdroth@linux.vnet.ibm.com> wrote:

> Quoting Michael Roth (2018-06-20 15:41:24)
> > Quoting Cornelia Huck (2018-06-19 02:42:48)  
> > > On Mon, 18 Jun 2018 20:41:26 -0500
> > > Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> > >   
> > > > Hi everyone,
> > > > 
> > > > The following new patches are queued for QEMU stable v2.11.2:
> > > > 
> > > >   https://github.com/mdroth/qemu/commits/stable-2.11-staging
> > > > 
> > > > The release is planned for 2018-06-22:
> > > > 
> > > >   https://wiki.qemu.org/Planning/2.11
> > > > 
> > > > Please respond here or CC qemu-stable@nongnu.org on any patches you
> > > > think should be included in the release.
> > > > 
> > > > Thanks!
> > > > 
> > > > ----------------------------------------------------------------
> > > > 
> > > > The following changes since commit 7c1beb52ed86191d9e965444d934adaa2531710f:
> > > > 
> > > >   Update version for 2.11.1 release (2018-02-14 14:41:05 -0600)
> > > > 
> > > > are available in the git repository at:
> > > > 
> > > >   git://github.com/mdroth/qemu.git 
> > > > 
> > > > for you to fetch changes up to acb3571f90885a2e206044b3bdc8d1dd2a0389c0:
> > > > 
> > > >   arm_gicv3_kvm: kvm_dist_get/put_priority: skip the registers banked by GICR_IPRIORITYR (2018-06-16 07:47:00 -0500)
> > > > 
> > > > ----------------------------------------------------------------  
> > > 
> > > Hi Michael,
> > > 
> > > as this series includes some s390-ccw bios patches, it needs a rebuild
> > > of the s390-ccw bios as well, probably on top of your stable branch.
> > > (IIRC we have extra patches on master, so you probably don't want to
> > > cherry-pick the latest rebuild from there.). Let me know if one of us
> > > should provide a rebuild.
> > >   
> > 
> > Thanks Cornelia, I hadn't realized that. I think rebuild from one of the
> > maintainers would definitely be preferable. We'd also want the corresponding
> > patches for pc-bios/s390-ccw reflected in the 2.11.x tree.  
> 
> Er, sorry was a bit confused. I suppose that part is covered already if
> there's no additional patches needed in the rebuild other than what's in
> 2.11.x already.

Yes, this should be all AFAICS.

> 
> 
> > another maintainer could put together a branch with those I can merge
> > those in directly.  
> 

The following changes since commit 1e13e7d93b93885d8a27fd18ec8a4b865a70e2ea:

  tpm: lookup cancel path under tpm device class (2018-06-20 20:45:08 -0500)

are available in the Git repository at:

  git://github.com/cohuck/qemu tags/s390x-20180621-211-stable

for you to fetch changes up to 728d6c602ea9fc9cfc4a2fcafb2553a1f4f400b6:

  pc-bios/s390-ccw.img: update image for stable (2018-06-21 04:22:15 -0400)

----------------------------------------------------------------
update s390-ccw.img for stable

----------------------------------------------------------------
Cornelia Huck (1):
      pc-bios/s390-ccw.img: update image for stable

 pc-bios/s390-ccw.img | Bin 26416 -> 26416 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

(or just cherry-pick from git://github.com/cohuck/qemu for-2.11-stable)
