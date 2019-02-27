Received: from eggs.gnu.org ([209.51.188.92]:59159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gyzqh-0007X6-PS
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:06:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gyzqb-0003SX-Rb
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:06:15 -0500
Date: Wed, 27 Feb 2019 15:06:05 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190227150605.7e7e9ce2.cohuck@redhat.com>
In-Reply-To: <333f78d1-48e1-3483-7c94-5cf52e1eafab@linux.ibm.com>
References: <1548768562-20007-1-git-send-email-jjherne@linux.ibm.com>
	<1548768562-20007-11-git-send-email-jjherne@linux.ibm.com>
	<735ca9ff-76e3-966f-6fbc-a72bf994b413@linux.ibm.com>
	<20190204121319.32915fd6.cohuck@redhat.com>
	<333f78d1-48e1-3483-7c94-5cf52e1eafab@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/15] s390-bios: Support for running
 format-0/1 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com

On Wed, 27 Feb 2019 08:32:58 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 2/4/19 6:13 AM, Cornelia Huck wrote:

> > What I don't understand is why we do the basic sense after an IFCC?
> > Wouldn't it make more sense to simply retry the original command in
> > that case?
> >   
> 
> I assumed it might be needed to clear status. It seems not. I'll modify that code path 
> accordingly.

Yes, a tsch should be enough to clear any pending status. It doesn't
clear available sense data, but if you get sense data on an ifcc, the
hardware/hypervisor is doing something really really strange :)
