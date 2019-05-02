Received: from eggs.gnu.org ([209.51.188.92]:54898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMDLI-0003nB-KN
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hMDLE-0002a2-Vm
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:09:46 -0400
Date: Thu, 2 May 2019 17:09:28 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190502170928.001c01df@Igors-MacBook-Pro>
In-Reply-To: <a765e3ac-45e6-310e-aa66-7036b5717a26@linux.intel.com>
References: <1553849325-44201-1-git-send-email-like.xu@linux.intel.com>
	<1553849325-44201-3-git-send-email-like.xu@linux.intel.com>
	<20190404162555.0a2267ee@redhat.com>
	<a765e3ac-45e6-310e-aa66-7036b5717a26@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/9] cpu/topology: add general support for
 machine properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Like Xu <like.xu@linux.intel.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org, "Dr.
	David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, like.xu@intel.com, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 30 Apr 2019 15:30:31 +0800
Like Xu <like.xu@linux.intel.com> wrote:

> On 2019/4/4 22:25, Igor Mammedov wrote:
> > On Fri, 29 Mar 2019 16:48:38 +0800
> > Like Xu <like.xu@linux.intel.com> wrote:
> > 

[...]

> 
> The division of responsibility for this case (refactoring 
> qemu_init_vcpu) seems to be a poisonous apple.
> 
> The prerequisite for setting cpu-> nr_cores / nr_threads from the parent 
> is that the CPU has been created, so if any process during 
> initialization needs this topo information, it will use the default 
> values form cpu_common_initfn() instead of user-configured parameters.

can you point to concrete place that needs access to nr_cores / nr_threads
before cpu is 'realized'?

 
> We may not want to repeat those assignment operations using the new 
> values and what do you think, Igor?
> 
> <snipp>
> 
