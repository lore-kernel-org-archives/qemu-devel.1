Received: from eggs.gnu.org ([2001:4830:134:3::10]:41959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVdya-0007N9-6Y
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVdyV-00033w-8v
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:20:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37344 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fVdyV-00033q-1t
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:20:43 -0400
References: <20180615222855.44421-1-mst@redhat.com>
	<20180615222855.44421-2-mst@redhat.com>
	<b59883c6-1dc0-4e81-439c-587c8f2d3e83@redhat.com>
	<20180619233509-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <75758aed-81ab-d320-595d-3c7832faa8d8@redhat.com>
Date: Wed, 20 Jun 2018 16:20:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180619233509-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org

On 19/06/2018 22:43, Michael S. Tsirkin wrote:
> 
>> 2) Maybe -hostresource?
>
> Is ability to cause high latency for other threads really a resource?

The "resource" here is host CPU time.  In general, a vCPU with
KVM_CPU_X86_DISABLE_EXITS will use more host CPU time and block
overcommitting, just like mlock does for memory.

Paolo

> The issues in question:
> 1. a malicious guest can cause high latency for others sharing the host cpu.
> 2. to host scheduler cpu looks busier than it really is.
