Received: from eggs.gnu.org ([2001:4830:134:3::10]:57764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fTZgX-0001H1-5G
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:21:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fTZgU-00006z-1U
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:21:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44436 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fTZgT-0008Vj-SN
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 17:21:33 -0400
References: <20180612184616.90838-1-mst@redhat.com>
	<20180614081800.GH6355@redhat.com>
	<2219a7fd-b496-6653-b79a-c20136727f98@redhat.com>
	<20180614165313.GT7451@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f708d976-e79e-a004-d8ca-2d28912c30c0@redhat.com>
Date: Thu, 14 Jun 2018 23:21:29 +0200
MIME-Version: 1.0
In-Reply-To: <20180614165313.GT7451@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] kvm: x86 CPU power management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On 14/06/2018 18:53, Eduardo Habkost wrote:
>>
>> A separate issue is whether the same flag should control both
>> KVM_CAP_X86_DISABLE_EXITS and the monitor/mwait CPUID leaf.  Eduardo,
>> what do you think?
> Making "-cpu host" be affected by a host-side option is
> acceptable to me.  A "-cpu" option would be more appropriate if
> we decide to allow monitor/mwait be enabled for other CPU models
> too.

Sounds fair enough, we should probably add a note in the documentation
of "-cpu host" though.

Paolo
