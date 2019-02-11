Received: from eggs.gnu.org ([209.51.188.92]:53767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gt9ag-0005T8-U2
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:17:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gt9ag-0006ik-1R
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 06:17:34 -0500
References: <1548956828-10210-1-git-send-email-thuth@redhat.com>
	<20190131185621.28815291.cohuck@redhat.com>
	<538ee62b-293d-f053-4bd2-76bf166388e1@redhat.com>
	<c60dd137-ca05-85cd-78ca-d22c79ccd85e@redhat.com>
	<aee584b8-90f1-3f10-25dd-5b38d1f46142@redhat.com>
	<cfe20aba-2f80-f8cb-66df-f9958bdf61f6@redhat.com>
	<20190201092356.295925c2.cohuck@redhat.com>
	<20190211114859.76109aa3.cohuck@redhat.com>
	<746bc346-26ce-e096-d8a4-fe78bf7912c1@redhat.com>
	<20190211120432.42373d08.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <025ce67d-f39e-b44b-8606-647f8695cbe5@redhat.com>
Date: Mon, 11 Feb 2019 12:17:26 +0100
MIME-Version: 1.0
In-Reply-To: <20190211120432.42373d08.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/s390x: Fix the function arguments in
 the pci stub file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, qemu-devel@nongnu.org

On 2019-02-11 12:04, Cornelia Huck wrote:
> On Mon, 11 Feb 2019 11:54:45 +0100
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> On 2019-02-11 11:48, Cornelia Huck wrote:
>>> On Fri, 1 Feb 2019 09:23:56 +0100
>>> Cornelia Huck <cohuck@redhat.com> wrote:
>>>   
>>>> On Fri, 1 Feb 2019 07:46:40 +0100
>>>> Thomas Huth <thuth@redhat.com> wrote:  
>>>   
>>>>> So I see two options now:
>>>>>
>>>>> 1) Finally really make the device optional, at least for new machine
>>>>> types, so we can really disable CONFIG_PCI and get a working executable.
>>>>>
>>>>> 2) Scratch the idea completely to make this optional, always link the
>>>>> s390-pci-bus.o and s390-pci-inst.o files unconditionally, and remove the
>>>>> s390-pci-stub.c file.
>>>>>
>>>>> I assume options 2 is preferred, since we likely rather want to move
>>>>> into the PCI direction in the long run, instead of ignoring it...    
>>>>
>>>> I think both options are viable, but option 1 is of course more work.
>>>> The win there is that we could disable an entire subsystem.
>>>>
>>>> I guess that the basic questions are: How important is it that
>>>> subsystems can be compiled out, and do we see a use case for a pci-less
>>>> s390 machine in the future? We really don't want to spend much time on
>>>> something of dubious use...  
>>>
>>> Any thoughts on this?
>>>
>>> I'm currently tending towards option 2 (and can cook up a patch for
>>> that). Unless someone is already working on option 1 :)  
>>
>> Since nobody currently has a need to completely disable PCI, I think we
>> should go with option 2.
> 
> Hm... I'm wondering if we also should move S390_FEAT_ZPCI from the max
> cpu model to the qemu cpu model (is there any reason not to turn it on
> by default in tcg?)

Migration compatibility? Wouldn't that cause problems when migrating
back to older versions of QEMU?

 Thomas
