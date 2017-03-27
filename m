Received: from eggs.gnu.org ([2001:4830:134:3::10]:34026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1csXPs-0003VR-O0
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1csXPn-0002JH-QL
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:22:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:39012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1csXPn-0002Gy-KJ
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:22:43 -0400
References: <1490624810-44752-1-git-send-email-agraf@suse.de>
	<20170327154636.GI28530@thinpad.lan.raisama.net>
From: Alexander Graf <agraf@suse.de>
Message-ID: <437e1004-b9b2-e9c0-cc89-5c926eb0b306@suse.de>
Date: Mon, 27 Mar 2017 18:22:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170327154636.GI28530@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386: Allow monitor / mwait cpuid override
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, kvm@vger.kernel.org



On 27/03/2017 17:46, Eduardo Habkost wrote:
> On Mon, Mar 27, 2017 at 04:26:50PM +0200, Alexander Graf wrote:
>> KVM allows trap and emulate (read: NOP) of the MONITOR and MWAIT
>> instructions. There is work undergoing to enable actual execution
>> of these inside of KVM, but nobody really wants to expose the feature
>> to the guest by default, as it would eat up all of the host CPU.
>
> Isn't this something that should be reported using
> KVM_GET_EMULATED_CPUID? (QEMU still doesn't know how to use
> KVM_GET_EMULATED_CPUID, however.)
>
>>
>> So today there is no streamlined way to actually notify the guest that
>> it's ok to execute MONITOR / MWAIT, even when we want to explicitly
>> leave the guest in guest context.
>
> I'm not familiar with the variables involved in this decision.
> How exactly would somebody (human or software) determine if it's
> really ok to let the guest execute MONITOR / MWAIT?
>
> Under what circumstances do you expect this to be used? Is this
> just for debugging and development?
>
>>
>> This patch adds a new -cpu parameter called "mwait" which - when
>> enabled - force enables the MONITOR / MWAIT CPUID flag, even when
>> the underlying accel framework does not explicitly advertise support.
>>
>
> If you really want something that makes QEMU ignore what the
> accel code is reporting, I would prefer a syntax that could be
> used for other features too, like "-cpu ...,monitor=force".

Is there any QOM property that does this yet? I can't seem to find any 
tri-state (on/off/force) parsers and I want to make sure I don't 
reinvent the wheel.


Alex
