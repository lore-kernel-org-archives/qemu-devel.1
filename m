Received: from eggs.gnu.org ([2001:4830:134:3::10]:52548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK7RP-0000HC-3m
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 12:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK7RK-0005OP-7E
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 12:46:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK7RK-0005O8-1T
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 12:46:02 -0500
References: <20161222155915.7232-1-pbonzini@redhat.com>
	<CAFEAcA_gQ4pMcfVevAEiY6LfoW_HzR8DARHb2QpGFEA2hTAMHw@mail.gmail.com>
	<cfe1e535-a28c-ebfa-b60f-f411a5e6cdd0@redhat.com>
	<20161222174202.GM3808@thinpad.lan.raisama.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b33af478-d0af-e450-ac89-e25ab2a5c4f9@redhat.com>
Date: Thu, 22 Dec 2016 18:45:58 +0100
MIME-Version: 1.0
In-Reply-To: <20161222174202.GM3808@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 00/11] Stubs cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>



On 22/12/2016 18:42, Eduardo Habkost wrote:
> On Thu, Dec 22, 2016 at 06:32:24PM +0100, Paolo Bonzini wrote:
>>
>>
>> On 22/12/2016 18:30, Peter Maydell wrote:
>>> On 22 December 2016 at 15:59, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>> This moves out of libqemustub.a those functions which can be handled
>>>> simply by $(call lnot), like we already do for pci-stub.c or kvm-stub.c.
>>>> libqemustub.a keep the more complex cases where a small part of the
>>>> executables we build needs an implementation of a small subset of an API.
>>>
>>> So why is doing it this way round better? (I don't have a strong
>>> opinion here, but you don't really give a rationale for this change.)
>>
>> I don't really have a strong opinion here either, hence the RFC.
>> However, one advantage is that it keeps things visible to the right
>> maintainer.
> 
> Can't we just move the files to subdirectories where they are
> visible to the maintainers, but keep using stub-obj-y/libqemustub
> to build/link them?
> 
> I find libqemustub/stub-obj-y much easier to use than manually
> setting obj-$(call lnot ...).

Yes, that would work too.  It's a pity that we cannot just use weak
symbols, as that would work fine with obj-y.

It would be a bit ugly to have to add "stub-obj-y += foo/" in the parent
directory.  But maybe we can replace that with a "subdir-y += foo/" and
just do a single recursion for all variables.  Fam, you did the current
implementation of unnest-vars, what do you think?  Would it also be simpler?

Paolo
