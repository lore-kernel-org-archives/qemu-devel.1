Received: from eggs.gnu.org ([2001:4830:134:3::10]:47535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fSOxK-0002oI-K2
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fSOxH-0003He-Ij
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:42:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56898 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fSOxH-0003HW-Bv
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:42:03 -0400
References: <20180608000540.276617-1-mst@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5baa09d4-3ede-62e8-9e2f-ed0dd0258711@redhat.com>
Date: Mon, 11 Jun 2018 17:41:58 +0200
MIME-Version: 1.0
In-Reply-To: <20180608000540.276617-1-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] kvm: support -realtime cpu-pm=on|off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org

On 08/06/2018 02:06, Michael S. Tsirkin wrote:
> With this flag, kvm allows guest to control host CPU power state.  This
> increases latency for other processes using same host CPU in an
> unpredictable way, but if decreases idle entry/exit times for the
> running VCPU.
> 
> Follow-up patches will expose this capability to guest
> (using mwait leaf).
> 
> Based on a patch by Wanpeng Li <kernellwp@gmail.com> .
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Looks good apart from the "= false" that checkpatch complains about.

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo
