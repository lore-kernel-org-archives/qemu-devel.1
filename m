Received: from eggs.gnu.org ([209.51.188.92]:57594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hLPJQ-0007th-2d
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:44:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hLPJP-0005y8-2U
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 05:44:32 -0400
Date: Tue, 30 Apr 2019 11:44:26 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190430114426.5e805d30.cohuck@redhat.com>
In-Reply-To: <099881e7-b0a9-055a-ba3e-2ebb66b4e15c@linux.ibm.com>
References: <1556543381-12671-1-git-send-email-jjherne@linux.ibm.com>
	<20190429154003.7f8fc423.cohuck@redhat.com>
	<ef10a003-3eb8-df60-bfb1-bc99bfd6b7af@de.ibm.com>
	<099881e7-b0a9-055a-ba3e-2ebb66b4e15c@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390-bios: Skip bootmap signature entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com, alifm@linux.ibm.com, Stefan Haberland <sth@linux.vnet.ibm.com>

On Tue, 30 Apr 2019 11:24:27 +0200
Peter Oberparleiter <oberpar@linux.ibm.com> wrote:

> On 29.04.2019 15:45, Christian Borntraeger wrote:
> > 
> > 
> > On 29.04.19 15:40, Cornelia Huck wrote:  
> >> On Mon, 29 Apr 2019 09:09:41 -0400
> >> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
> >>  
> >>> Newer versions of zipl have the ability to write signature entries to the boot
> >>> script for secure boot. We don't yet support secure boot, but we need to skip
> >>> over signature entries while reading the boot script in order to maintain our
> >>> ability to boot guest operating systems that have a secure bootloader.
> >>>
> >>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> >>> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> >>> ---
> >>>  pc-bios/s390-ccw/bootmap.c | 19 +++++++++++++++++--
> >>>  pc-bios/s390-ccw/bootmap.h | 10 ++++++----
> >>>  2 files changed, 23 insertions(+), 6 deletions(-)  
> >>
> >> Skipping something that we don't have support for yet, but that doesn't
> >> hinder normal operation sounds reasonable; but can you point me to the
> >> relevant commit implementing this in zipl or some documentation? I
> >> haven't been able to find something like that in the s390-tools git
> >> tree.  
> > 
> > the s390-tools update is currently in preparation, adding Stefan and Peter.  
> 
> Here's the link to the s390-tools commit that introduces the new
> signature component to zipl:
> 
> https://github.com/ibm-s390-tools/s390-tools/commit/7c7e10ed8fb048efc4e0cd91b0f6fa704fba128e
> 
> 

Thanks!
