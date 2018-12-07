Received: from eggs.gnu.org ([2001:4830:134:3::10]:33381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gVFGk-00051n-60
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gVFGc-0004IL-5c
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 07:30:07 -0500
Date: Fri, 7 Dec 2018 13:29:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181207132946.00df1f5a.cohuck@redhat.com>
In-Reply-To: <5d274f2c-23a2-0c4f-9f2d-07cbe529c5ac@de.ibm.com>
References: <20181205145131.28467-1-cohuck@redhat.com>
	<5d274f2c-23a2-0c4f-9f2d-07cbe529c5ac@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] vfio-ap: flag as compatible with
 balloon
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Alex Williamson <alex.williamson@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Fri, 7 Dec 2018 13:17:02 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 05.12.2018 15:51, Cornelia Huck wrote:
> > vfio-ap devices do not pin any pages in the host. Therefore, they
> > are belived to be compatible with memory ballooning.
> > 
> > Flag them as compatible, so both vfio-ap and a balloon can be
> > used simultaneously.
> > 
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>  
> 
> Does it make sense to add cc stable for 3.1?

Can do that, given that s390x systems really rely on the ballooner in
general.
