Received: from eggs.gnu.org ([2001:4830:134:3::10]:34858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cP5dW-0008JB-OM
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mtosatti@redhat.com>) id 1cP5dT-0001HD-Mi
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:51:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1cP5dT-0001H3-Gs
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 05:51:07 -0500
Date: Thu, 5 Jan 2017 08:50:48 -0200
From: Marcelo Tosatti <mtosatti@redhat.com>
Message-ID: <20170105105046.GC6299@amt.cnet>
References: <1482866480-26208-1-git-send-email-ehabkost@redhat.com>
	<1482866480-26208-5-git-send-email-ehabkost@redhat.com>
	<20170104115656.GB14961@amt.cnet>
	<20170104133916.GG3315@thinpad.lan.raisama.net>
	<20170104195917.GM3315@thinpad.lan.raisama.net>
	<20170104222623.GA21789@amt.cnet>
	<20170105013631.GO3315@thinpad.lan.raisama.net>
	<20170105104830.GB6299@amt.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170105104830.GB6299@amt.cnet>
Subject: Re: [Qemu-devel] TSC frequency configuration & invtsc migration
 (was Re: [PATCH 4/4] kvm: Allow migration with invtsc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>, libvir-list@redhat.com

On Thu, Jan 05, 2017 at 08:48:32AM -0200, Marcelo Tosatti wrote:
> > Note that even if we follow your suggestion and implement an
> > alternative version of patch 4/4 to cover your use case, I will
> > strongly recommend libvirt developers to support configuring TSC
> > frequency if they want to support invtsc + migration without
> > surprising/unpredictable restrictions on migratability.
> 
> Well, alright. If you make the TSC frequency of the host
> available to mgmt software as you describe, and write the steps mgmt
> software should take, i'm good.
> 
> Thanks for the help Eduardo.
> 

I'll be happy to not have to add a weird script to 

1. Query the host TSC frequency.
2. Pass that to -cpu xxx,tsc-frequency=ZZZ

To my migration scripts. 

Probably easy to make that the default behaviour...
