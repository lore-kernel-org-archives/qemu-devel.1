Received: from eggs.gnu.org ([2001:4830:134:3::10]:44256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fVe6o-0005Ct-UD
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fVe6j-0006CV-JY
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:29:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33696 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fVe6j-0006CL-DO
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:29:13 -0400
Date: Wed, 20 Jun 2018 17:29:11 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180620172212-mutt-send-email-mst@kernel.org>
References: <20180615222855.44421-1-mst@redhat.com>
	<20180615222855.44421-2-mst@redhat.com>
	<b59883c6-1dc0-4e81-439c-587c8f2d3e83@redhat.com>
	<20180619233509-mutt-send-email-mst@kernel.org>
	<75758aed-81ab-d320-595d-3c7832faa8d8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75758aed-81ab-d320-595d-3c7832faa8d8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] kvm: support -dedicated
 cpu-pm=on|off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org

On Wed, Jun 20, 2018 at 04:20:40PM +0200, Paolo Bonzini wrote:
> On 19/06/2018 22:43, Michael S. Tsirkin wrote:
> > 
> >> 2) Maybe -hostresource?
> >
> > Is ability to cause high latency for other threads really a resource?
> 
> The "resource" here is host CPU time.

Right but then everything we do is a host resource in that sense.
Host network, host disk ...

> In general, a vCPU with
> KVM_CPU_X86_DISABLE_EXITS will use more host CPU time and block
> overcommitting, just like mlock does for memory.

What bothers me is that it does not block overcommit as such.
It has a side effect that if something does end up
running on the same CPU, that something will get bad
latency jitter. 

> 
> Paolo

I agree there's similarity here around overcommit.

That's why I suggested -dedicated as an antonym to -overcommit.

But I'm fine with -disable-overcommit or -dedicated-host-resource too.

Or, how about

-locked

?


> > The issues in question:
> > 1. a malicious guest can cause high latency for others sharing the host cpu.
> > 2. to host scheduler cpu looks busier than it really is.
