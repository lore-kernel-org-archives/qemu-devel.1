Received: from eggs.gnu.org ([2001:4830:134:3::10]:48422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVeMi-0007Ru-RT
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:45:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fVeMf-0003PL-Q7
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:45:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54388 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fVeMf-0003OD-KQ
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:45:41 -0400
References: <20180615222855.44421-1-mst@redhat.com>
	<20180615222855.44421-2-mst@redhat.com>
	<b59883c6-1dc0-4e81-439c-587c8f2d3e83@redhat.com>
	<20180619233509-mutt-send-email-mst@kernel.org>
	<75758aed-81ab-d320-595d-3c7832faa8d8@redhat.com>
	<20180620172212-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <31e37743-6a12-c271-1218-c2f1745851fb@redhat.com>
Date: Wed, 20 Jun 2018 16:45:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180620172212-mutt-send-email-mst@kernel.org>
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

On 20/06/2018 16:29, Michael S. Tsirkin wrote:
> On Wed, Jun 20, 2018 at 04:20:40PM +0200, Paolo Bonzini wrote:
>> On 19/06/2018 22:43, Michael S. Tsirkin wrote:
>>>
>>>> 2) Maybe -hostresource?
>>>
>>> Is ability to cause high latency for other threads really a resource?
>>
>> The "resource" here is host CPU time.
> 
> Right but then everything we do is a host resource in that sense.
> Host network, host disk ...

Yes of course.  These options control how (and how much) QEMU uses those
resources.

>> In general, a vCPU with
>> KVM_CPU_X86_DISABLE_EXITS will use more host CPU time and block
>> overcommitting, just like mlock does for memory.
> 
> What bothers me is that it does not block overcommit as such.
> It has a side effect that if something does end up
> running on the same CPU, that something will get bad
> latency jitter. 
>
> I agree there's similarity here around overcommit.
> 
> That's why I suggested -dedicated as an antonym to -overcommit.
> 
> But I'm fine with -disable-overcommit or -dedicated-host-resource too.

Both of those are quite a mouthful.  I somewhat prefer "-overcommit" to
"-dedicated", though "-hostresource" it's still my favorite mostly
because it's the most future-proof.

Paolo
