Received: from eggs.gnu.org ([2001:4830:134:3::10]:52515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f4QZZ-00032H-Gp
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:34:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f4QZW-0002EH-DJ
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:34:29 -0400
Date: Fri, 6 Apr 2018 14:34:17 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180406143417.4f829607.cohuck@redhat.com>
In-Reply-To: <f766fb2e-f5b9-c117-fc2a-b51c485d6742@de.ibm.com>
References: <1522940844-12336-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<f766fb2e-f5b9-c117-fc2a-b51c485d6742@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] s390: Fix virtio-scsi IPL quirks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, agraf@suse.de, rth@twiddle.net, david@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org

On Fri, 6 Apr 2018 14:30:45 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 04/05/2018 05:07 PM, Viktor Mihajlovski wrote:
> > IPL from virtio-scsi currently uses a non-standard parameter
> > type definition to pass boot parameters from QEMU to the
> > BIOS.
> > 
> > There are two potential issues with this approach:
> > o If the guest operating systems requests a re-ipl of type CCW
> >   where the boot device is a virtio-scsi HBA, this goes unnoticed
> >   by QEMU. The BIOS will detect that it's IPLing from a SCSI
> >   device, but it will boot the first LUN found, which might not
> >   be the one used for the initial boot.
> > o The guest operating system can be confused by an unknown
> >   IPL parameter block type. If the OS hasn't previously used 
> >   diag308 to store the IPL info but is changed to do so, a
> >   user-observable change in behavior will happen.
> > 
> > The following patches address the issues above. 
> > 
> > Viktor Mihajlovski (3):
> >   s390: Refactor IPL parameter block generation
> >   s390: Ensure IPL from SCSI works as expected
> >   s390: Do not pass inofficial IPL type to the guest
> > 
> >  hw/s390x/ipl.c             | 112 ++++++++++++++++++++++++++++++++-------------
> >  pc-bios/s390-ccw/bootmap.c |   7 +++
> >  pc-bios/s390-ccw/iplb.h    |  15 +++++-
> >  3 files changed, 100 insertions(+), 34 deletions(-)
> >   
> 
> Test looks good so far.

OK, I'll queue this to s390-fixes, then. I won't send a pull request
before Monday, so there's still a chance to fix this should problems
show up.

Thanks for testing!
