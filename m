Received: from eggs.gnu.org ([2001:4830:134:3::10]:36737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fhvAU-0006Uu-K0
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:07:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fhvAR-00050T-EC
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 07:07:50 -0400
Date: Tue, 24 Jul 2018 13:07:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180724130743.4c7decdb.cohuck@redhat.com>
In-Reply-To: <20180724114004.67bc1281.cohuck@redhat.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
	<20180723201748.25573-6-mdroth@linux.vnet.ibm.com>
	<153238409419.10934.1652388192245648682@sif>
	<20180724114004.67bc1281.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/99] s390-ccw: force diag 308 subcode to
 unsigned long
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>

On Tue, 24 Jul 2018 11:40:04 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Mon, 23 Jul 2018 17:14:54 -0500
> Michael Roth <mdroth@linux.vnet.ibm.com> wrote:
> 
> > Quoting Michael Roth (2018-07-23 15:16:14)  
> > > From: Cornelia Huck <cohuck@redhat.com>
> > > 
> > > We currently pass an integer as the subcode parameter. However,
> > > the upper bits of the register containing the subcode need to
> > > be 0, which is not guaranteed unless we explicitly specify the
> > > subcode to be an unsigned long value.
> > > 
> > > Fixes: d046c51dad3 ("pc-bios/s390-ccw: Get device address via diag 308/6")
> > > Cc: qemu-stable@nongnu.org
> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > > Tested-by: Thomas Huth <thuth@redhat.com>
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > > (cherry picked from commit 63d8b5ace31c1e1f3996fe4cd551d6d377594d5a)
> > > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>    
> > 
> > Hi Cornelia,
> > 
> > Would you be able to do an s390 BIOS build for this one as well?  
> 
> Sure, will do a build for 2.12-stable.

Here we go:

The following changes since commit e8488edcb3768f08cda7c3cc00def6b1b2f6c615:

  tcg/i386: Mark xmm registers call-clobbered (2018-07-23 14:24:17 -0500)

are available in the Git repository at:

  git://github.com/cohuck/qemu tags/s390x-20180724-212-stable

for you to fetch changes up to c16427177a67bc86aa7560331143bfc9c885b27d:

  pc-bios/s390-ccw.img: update image for stable (2018-07-24 06:08:42 -0400)

----------------------------------------------------------------
update s390-ccw.img for stable

----------------------------------------------------------------
Cornelia Huck (1):
      pc-bios/s390-ccw.img: update image for stable

 pc-bios/s390-ccw.img | Bin 30520 -> 30520 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

(for-2.12-stable branch)
