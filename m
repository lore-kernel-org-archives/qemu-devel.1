Received: from eggs.gnu.org ([2001:4830:134:3::10]:54593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cQzRk-0007lH-FS
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:38:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cQzRh-00071o-D3
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:38:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cQzRh-00071f-6x
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 11:38:49 -0500
References: <1482866480-26208-5-git-send-email-ehabkost@redhat.com>
	<20170104115656.GB14961@amt.cnet>
	<20170104133916.GG3315@thinpad.lan.raisama.net>
	<20170104195917.GM3315@thinpad.lan.raisama.net>
	<20170104222623.GA21789@amt.cnet>
	<20170105013631.GO3315@thinpad.lan.raisama.net>
	<20170105104830.GB6299@amt.cnet>
	<20170105121950.GP3315@thinpad.lan.raisama.net>
	<20170105123351.GF3292@redhat.com>
	<20170105124857.GQ3315@thinpad.lan.raisama.net>
	<20170105130032.GJ3292@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1ec51249-59c8-582b-d3cb-3389606649ce@redhat.com>
Date: Tue, 10 Jan 2017 17:38:45 +0100
MIME-Version: 1.0
In-Reply-To: <20170105130032.GJ3292@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] TSC frequency configuration & invtsc
 migration (was Re: [PATCH 4/4] kvm: Allow migration with invtsc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>



On 05/01/2017 14:00, Daniel P. Berrange wrote:
>> If you do this unconditionally, you have another problem: if
>> tsc-frequency is set explicitly, migration is only possible if
>> TSC frequency of the destination matches[1], or if TSC scaling is
>> supported by the destination. It's a good idea to set a TSC
>> frequency only if invtsc is enabled explicitly in the config.
> 
> If we don't set tsc-frequency and the TSC frequency doesn't
> match, does that mean the guest migration succeed, but suddenly
> sees different TSC frequency ?

That's the reason why kvmclock exists (or more precisely, the reason why
kvmclock is still useful even when hosts have invtsc).

Paolo

> I guess we we allowed that historically we can't break that
> now, so setting it only if invtsc is set seems reasonable.
