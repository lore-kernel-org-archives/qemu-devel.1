Received: from eggs.gnu.org ([2001:4830:134:3::10]:37932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eybUf-0002D7-UL
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:01:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eybUa-0004RL-AQ
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:01:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40722 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eybUa-0004RA-62
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:01:16 -0400
References: <20180316170020.8212-1-vkuznets@redhat.com>
	<20180316170020.8212-2-vkuznets@redhat.com>
	<20180319170603.GA12962@rkaganb.sw.ru>
	<87a7v47z4r.fsf@vitty.brq.redhat.com>
	<20180320181652.GV3417@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c3ffce09-ea97-6b63-8784-3c8224a2ab46@redhat.com>
Date: Wed, 21 Mar 2018 12:01:10 +0100
MIME-Version: 1.0
In-Reply-To: <20180320181652.GV3417@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] i386/kvm: add support for Hyper-V
 reenlightenment MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org

On 20/03/2018 19:16, Eduardo Habkost wrote:
>> Suggestions? (To be honest I don't really like us adding new hv_*
>> property for every new Hyper-V feature we support. I doubt anyone needs
>> 'partial' Hyper-V emulation. It would be nice to have a single versioned
>> 'hv' feature implying everything. We may then forbid migrations to older
>> hv versions. But I don't really know the history of why we decided to go
>> with a separate hv_* for every feature we add).
> You will need "partial" emulation if you want to support
> live-migration to/from a host where the KVM or QEMU don't support
> all the features from the current host.
> 
> Is this something the current Hyper-V code already supports, or
> it's something known to be broken?

Yes, it works.

Essentially, multiple Hyper-V features are (just like multiple KVM
features) needed to support old kernels.  The difference is that new KVM
features are added quite rarely, and most of them are enabled by
default.  The opposite is true of Hyper-V, on both counts.

Paolo
