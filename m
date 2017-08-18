Received: from eggs.gnu.org ([2001:4830:134:3::10]:37548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dikWf-00043e-GI
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dikWc-00048t-FI
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:53:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dikWc-00048f-8S
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 12:53:34 -0400
References: <1502842933-8323-1-git-send-email-tianyu.lan@intel.com>
	<34042934-782b-6bcc-b9b2-de7a1816cfb7@redhat.com>
	<3ababa62-f055-5bbb-b9b9-c55ada8368dd@intel.com>
	<20170818163854.GY3108@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d02e9f04-2487-1a02-4453-5e604b0f3f2b@redhat.com>
Date: Fri, 18 Aug 2017 18:53:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170818163854.GY3108@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] x86: Skip check apic_id_limit for Xen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, rth@twiddle.net, anthony.perard@citrix.com, xen-devel@lists.xenproject.org

On 18/08/2017 18:38, Eduardo Habkost wrote:
>>> I think you still need to do a check for vIOMMU being enabled.
>>
>> Yes, this will be done in the Xen tool stack and Qemu doesn't have such
>> knowledge. Operations of create, destroy Xen vIOMMU will be done in the
>> Xen tool stack.
>
> Shouldn't we make QEMU have knowledge of the vIOMMU device, then?
> Won't QEMU need to know about it eventually?

No, it actually makes sense since Xen hosts all system-wide interrupt
sources outside QEMU, unlike KVM which only hosts the (per-CPU) local APIC.

Paolo
