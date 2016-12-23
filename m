Received: from eggs.gnu.org ([2001:4830:134:3::10]:49354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cKLkN-0004xG-N2
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 04:02:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cKLkK-0008MT-Mc
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 04:02:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cKLkK-0008M5-Gq
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 04:02:36 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20161222155915.7232-1-pbonzini@redhat.com>
	<CAFEAcA_gQ4pMcfVevAEiY6LfoW_HzR8DARHb2QpGFEA2hTAMHw@mail.gmail.com>
	<cfe1e535-a28c-ebfa-b60f-f411a5e6cdd0@redhat.com>
	<20161222174202.GM3808@thinpad.lan.raisama.net>
	<b33af478-d0af-e450-ac89-e25ab2a5c4f9@redhat.com>
Date: Fri, 23 Dec 2016 10:02:33 +0100
In-Reply-To: <b33af478-d0af-e450-ac89-e25ab2a5c4f9@redhat.com> (Paolo
	Bonzini's message of "Thu, 22 Dec 2016 18:45:58 +0100")
Message-ID: <8737hfm312.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [RFC PATCH 00/11] Stubs cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 22/12/2016 18:42, Eduardo Habkost wrote:
>> On Thu, Dec 22, 2016 at 06:32:24PM +0100, Paolo Bonzini wrote:
>>>
>>>
>>> On 22/12/2016 18:30, Peter Maydell wrote:
>>>> On 22 December 2016 at 15:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>>> This moves out of libqemustub.a those functions which can be handled
>>>>> simply by $(call lnot), like we already do for pci-stub.c or kvm-stub.c.
>>>>> libqemustub.a keep the more complex cases where a small part of the
>>>>> executables we build needs an implementation of a small subset of an API.
>>>>
>>>> So why is doing it this way round better? (I don't have a strong
>>>> opinion here, but you don't really give a rationale for this change.)
>>>
>>> I don't really have a strong opinion here either, hence the RFC.
>>> However, one advantage is that it keeps things visible to the right
>>> maintainer.
>> 
>> Can't we just move the files to subdirectories where they are
>> visible to the maintainers, but keep using stub-obj-y/libqemustub
>> to build/link them?
>> 
>> I find libqemustub/stub-obj-y much easier to use than manually
>> setting obj-$(call lnot ...).
>
> Yes, that would work too.  It's a pity that we cannot just use weak
> symbols, as that would work fine with obj-y.

Can you explain again why we can't use weak symbols?

[...]
