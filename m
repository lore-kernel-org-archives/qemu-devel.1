Received: from eggs.gnu.org ([209.51.188.92]:46391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hBJib-0008Lv-J9
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hBJiY-00080T-BU
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:44:47 -0400
Date: Tue, 2 Apr 2019 15:44:37 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190402154437.6cb10f0d.cohuck@redhat.com>
In-Reply-To: <7c196819-c0b1-9c8d-b43d-786189c82cac@linux.ibm.com>
References: <20190301093949.27955-1-cohuck@redhat.com>
	<7c196819-c0b1-9c8d-b43d-786189c82cac@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/2] vfio-ccw: support hsch/csch (QEMU
 part)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Thu, 21 Mar 2019 21:49:54 -0400
Eric Farman <farman@linux.ibm.com> wrote:

> On 3/1/19 4:39 AM, Cornelia Huck wrote:
> > 
> > [I'm not quite happy with how this async processing hooks up in css.c;
> > ideas welcome.]  
> 
> I guess I'm not unhappy with it, but it does look a little odd.  Not 
> sure I have a better idea right now...  Will ponder that for a while.

If we don't come up with something better right now, we can still change
this later, I think.
