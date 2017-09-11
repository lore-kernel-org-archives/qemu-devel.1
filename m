Received: from eggs.gnu.org ([2001:4830:134:3::10]:41695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drNiY-0004M2-B6
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 08:21:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1drNiT-0008Rs-L9
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 08:21:34 -0400
Date: Mon, 11 Sep 2017 14:21:24 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170911142124.316472c8.cohuck@redhat.com>
In-Reply-To: <616d2319-1198-5a20-ebf4-ac2c532352db@redhat.com>
References: <20170911110037.6567-1-lvivier@redhat.com>
	<20170911110615.GK21444@redhat.com>
	<20170911134158.1f046176.cohuck@redhat.com>
	<20170911114347.GL21444@redhat.com> <20170911120441.GB2857@work-vm>
	<616d2319-1198-5a20-ebf4-ac2c532352db@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hmp: fix "dump-quest-memory" segfault (ppc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Mon, 11 Sep 2017 14:10:14 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> On 11/09/2017 14:04, Dr. David Alan Gilbert wrote:
> > * Daniel P. Berrange (berrange@redhat.com) wrote:  
> >> On Mon, Sep 11, 2017 at 01:41:58PM +0200, Cornelia Huck wrote:  

> >>> However, if we start a qemu with no guest memory defined and then call
> >>> dump-guest-memory without filtering, we get a core dump instead of a
> >>> guest dump (s390x or x86_64, machine none).
> >>>
> >>> I can take a stab at fixing that, unless someone beats me to it.  
> >>
> >> I wonder if someone wants to write a qtest job to run dump-guest-memory
> >> across all machine types, on all targets. Seems we have enough crashiness
> >> in this code to make it worthwhile to test  
> > 
> > We do have - that's how we found this case;  it's part of test-hmp.  
> 
> The test-hmp runs by default with 0 MB of memory, the problem can only
> be found with some memory added to the machine.
> 
> Perhaps we can simply update the test to add memory?

We have several combinations that can fail here... (cf. the problem
with no memory and no filter above).

> 
> BTW, I'm not sure it is really useful to dump memory of a machine
> without CPU.

Even so, it should not segfault (and neither should dumping a guest
with no memory, even if it doesn't make sense).
