Received: from eggs.gnu.org ([2001:4830:134:3::10]:35222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRJXZ-0004dw-Rp
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 09:06:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRJXV-0002C0-Tf
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 09:06:13 -0500
Received: from mail-wj0-x242.google.com ([2a00:1450:400c:c01::242]:35864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cRJXV-0002B9-N8
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 09:06:09 -0500
Received: by mail-wj0-x242.google.com with SMTP id dh1so10653503wjb.3
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 06:06:09 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170104115656.GB14961@amt.cnet>
	<20170104133916.GG3315@thinpad.lan.raisama.net>
	<20170104195917.GM3315@thinpad.lan.raisama.net>
	<20170104222623.GA21789@amt.cnet>
	<20170105013631.GO3315@thinpad.lan.raisama.net>
	<20170105104830.GB6299@amt.cnet>
	<20170105121950.GP3315@thinpad.lan.raisama.net>
	<20170106103126.GA1575@amt.cnet>
	<20170108202851.GZ3315@thinpad.lan.raisama.net>
	<d9ff1970-7d2d-6a49-b93e-27fe2817f412@redhat.com>
	<20170111132653.GB3315@thinpad.lan.raisama.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fcb2f7b5-93ad-9a48-1669-936b3925c923@redhat.com>
Date: Wed, 11 Jan 2017 15:06:07 +0100
MIME-Version: 1.0
In-Reply-To: <20170111132653.GB3315@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Exporting kvm_max_guest_tsc_khz to userspace (was
 Re: [PATCH 4/4] kvm: Allow migration with invtsc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>, libvir-list@redhat.com



On 11/01/2017 14:26, Eduardo Habkost wrote:
> On Mon, Jan 09, 2017 at 03:58:11PM +0100, Paolo Bonzini wrote:
>>
>>
>> On 08/01/2017 21:28, Eduardo Habkost wrote:
>>>> Well just export KVM_GET_TSC_KHZ in a QMP command right? Its pretty
>>>> easy.
>>>>
>>>> Let me know if you need any help coding or testing.
>>> I just found out that KVM doesn't provide something that QEMU and
>>> libvirt need: the value of kvm_max_guest_tsc_khz. Without it, we
>>> have no way to know if a given VM is really migratable to a host.
>>>
>>> Could we add a KVM_CAP_MAX_TSC_KHZ capability for that?
>>
>> The ratio is really quite high, 256x the host frequency for AMD and
>> 65536x for Intel.  Anything below 2^32 Hz (above that, there would
>> probably be other failures) is safe.
> 
> 2^32 Hz (~4.3 GHz) sounds like a limit likely to be hit by future
> CPUs. Which kind of failures do you think we could see?

Just integer overflows.  Current CPUs have been at 3.9 GHz for a while now.

Paolo
