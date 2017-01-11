Received: from eggs.gnu.org ([2001:4830:134:3::10]:33473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRHXn-0002Jf-LF
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:58:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRHXk-0000lO-KB
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:58:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cRHXk-0000lE-EF
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 06:58:16 -0500
Date: Wed, 11 Jan 2017 09:58:12 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170111115812.GA3315@thinpad.lan.raisama.net>
References: <1482866480-26208-1-git-send-email-ehabkost@redhat.com>
	<1482866480-26208-5-git-send-email-ehabkost@redhat.com>
	<20170104115656.GB14961@amt.cnet>
	<20170104133916.GG3315@thinpad.lan.raisama.net>
	<20170104195917.GM3315@thinpad.lan.raisama.net>
	<20170104222623.GA21789@amt.cnet>
	<20170105013631.GO3315@thinpad.lan.raisama.net>
	<20170105104830.GB6299@amt.cnet>
	<4006fc1d-f4f8-12dd-05e7-950cc839aae4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4006fc1d-f4f8-12dd-05e7-950cc839aae4@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>, libvir-list@redhat.com

On Tue, Jan 10, 2017 at 05:36:48PM +0100, Paolo Bonzini wrote:
> 
> 
> On 05/01/2017 11:48, Marcelo Tosatti wrote:
> >> Host A has TSC scaling, host B doesn't have TSC scaling. We want
> >> to be able to start the VM on host A, and migrate to B. In this
> >> case, the only possible solution is to use B's frequency when
> >> starting the VM. The QEMU process doesn't have enough information
> >> to make that decision.
> > That is a good point. But again, its a special case and 
> > should be supported by -cpu xxx,tsc-frequency=zzzz.
> 
> I don't think this is a scenario that can work reliably.  The computed
> TSC frequency may vary by 0.5% or so on every boot (e.g. you may get
> 2497000 kHz or 2511000 kHz for a 2.5 GHz TSC).  You can start the VM on
> host A, reboot host B, and then you'll be unable to migrate.

Right, so it means invtsc migration without TSC scaling will be
possible in practice only if we tolerate a small variance on TSC
frequency on migration. The question is: should we? Can we
tolerate a 0.5% variance on TSC frequency and still expose invtsc
to the guest?

-- 
Eduardo
