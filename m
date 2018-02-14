Received: from eggs.gnu.org ([2001:4830:134:3::10]:36429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elzOP-0006Og-W1
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:54:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1elzOO-0001JT-IR
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:54:46 -0500
Date: Wed, 14 Feb 2018 16:27:15 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180214162715.54743e55.cohuck@redhat.com>
In-Reply-To: <a0d9f591-8f6d-4c98-8b71-cb8585c1ef12@redhat.com>
References: <1518542328-25741-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518542328-25741-4-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180214111522.677d77bc.cohuck@redhat.com>
	<a0d9f591-8f6d-4c98-8b71-cb8585c1ef12@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 3/3] qmp: add architecture specific cpu
 data for query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org, agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On Wed, 14 Feb 2018 09:15:23 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 02/14/2018 04:15 AM, Cornelia Huck wrote:
> > On Tue, 13 Feb 2018 18:18:48 +0100
> > Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com> wrote:
> >   
> 
> >> A suggestion was made on the mailing list to enhance the QAPI
> >> code generation to support two layers of unions. This would
> >> allow to specify the common fields once and avoid the duplication
> >> in the leaf unions.
> >>
> >> On the other hand, the slow query-cpus should be deprecated
> >> along with the slow CpuInfo type and eventually be removed.
> >> Assuming that new architectures will not be added at high
> >> rates, we could live with the duplication for the time being.  
> > 
> > What would be a realistic timeframe for deprecation/removal of
> > query-cpus, considering the libvirt usage? Are we aware of other users?  
> 
> Well, if we want to start the clock ticking, this series also needs to 
> touch qemu-doc.texi to start the deprecation clock, then we go at least 
> two more releases with support for both old and new commands.
> 

I'd like to know first what libvirt plans to do -- no sense in starting
deprecation if we're still stuck with it for a while.
