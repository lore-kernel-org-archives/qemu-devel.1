Received: from eggs.gnu.org ([209.51.188.92]:48956)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hFzlH-0004Fs-Qz
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hFzlF-0006dB-QO
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:26:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hFzlF-0006cK-9H
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 07:26:53 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 504623082E1F
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 11:26:52 +0000 (UTC)
References: <20181119182330.17147-1-pbonzini@redhat.com>
	<20181120114422.GA5072@work-vm>
	<f6c43c98-1319-85bb-c379-72d8caacf68d@redhat.com>
	<c348ffd5-a044-bc12-d1a7-50b7ab543045@redhat.com>
	<55adf1ce-7f21-bff0-c75a-2b7abd2b110e@redhat.com>
	<1892546178.13440598.1555144001543.JavaMail.zimbra@redhat.com>
	<20190415112247.GH2852@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <535b9d65-2414-d53e-8170-6985a4e15a66@redhat.com>
Date: Mon, 15 Apr 2019 13:26:47 +0200
MIME-Version: 1.0
In-Reply-To: <20190415112247.GH2852@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] R: Re: [PATCH v2] target/i386: kvm: add VMX
 migration blocker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Cole Robinson <crobinso@redhat.com>, qemu-devel@nongnu.org

On 15/04/19 13:22, Dr. David Alan Gilbert wrote:
> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>>
>> ----- Cole Robinson <crobinso@redhat.com> ha scritto:
>>> On 4/12/19 3:47 AM, Paolo Bonzini wrote:
>>>> On 10/04/19 20:26, Cole Robinson wrote:
>>>>> On 11/20/18 6:44 AM, Dr. David Alan Gilbert wrote:
>>>>>> * Paolo Bonzini (pbonzini@redhat.com) wrote:
>>>>>>> Nested VMX does not support live migration yet.  Add a blocker
>>>>>>> until that is worked out.
>>>>>>>
>>>>>>> Nested SVM only does not support it, but unfortunately it is
>>>>>>> enabled by default for -cpu host so we cannot really disable it.
>>>>>>>
>>>>>>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>>>>>>
>>>>>> So I'm OK with this, but it does need a release note warning whenever it
>>>>>> goes in, because it'll surprise those who've already enabled nesting
>>>>>> but don't use it on all their VMs.
>>>>>>
>>>>>
>>>>> We are hitting this in Fedora 30. Now that nested VMX is enabled by
>>>>> default at the kernel level, and virt-manager/boxes will use the
>>>>> equivalent of -cpu host by default, libvirt managedsave (migrate to
>>>>> file) and virt-manager snapshots (savevm) are rejected for default
>>>>> created VMs on intel. That's quite unfortunate.
>>>>>
>>>>> Any ideas on how to resolve this?
>>>>
>>>> I think the simplest solution is just to finish implementation of nested
>>>> VMX live migration and backport it to Fedora 30.
>>>>
>>>
>>> That would simplify things :) Any guess on the timeframe? This is kernel
>>> work I presume?
>>
>> No, the kernel part is already in. As a contingency plan, you could just revert this QEMU patch.
> 
> With a new-enough kernel, how hard is it to detect that this actual
> migration is safe?

Not hard, but it would fail whenever the KVM kernel module is loaded, so
pretty much for all Linux guests.

Paolo
