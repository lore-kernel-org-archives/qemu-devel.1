Received: from eggs.gnu.org ([209.51.188.92]:42722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gyecU-0003LM-FC
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 10:26:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gyecS-00057L-S2
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 10:26:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gyecQ-00055S-Up
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 10:26:08 -0500
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
	<1549562254-41157-18-git-send-email-pbonzini@redhat.com>
	<20190225084428.c7qon3btox2jvxq2@steredhat>
	<30737edd-4b8c-a458-27c6-cd3fb5da22c3@redhat.com>
	<875zt6y88o.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bd83fecf-9ce5-9675-80e1-92c905cd1461@redhat.com>
Date: Tue, 26 Feb 2019 16:25:50 +0100
MIME-Version: 1.0
In-Reply-To: <875zt6y88o.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/51] i386: express dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, Yang Zhong <yang.zhong@intel.com>, thuth@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org

On 26/02/19 14:44, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 25/02/19 09:44, Stefano Garzarella wrote:
>>>>  config I440FX
>>>>      bool
>>>> +    select PC_PCI
>>>> +    select PC_ACPI
>>>> +    select ACPI_SMBUS
>>>> +    select PCI_PIIX
>>>> +    select FDC
>>> Should we move "select FDC" under "config PC"?
>>>
>>> I'm not able to build the Q35 machine without enable FDC, since some fdc
>>> functions are used in hw/i386/pc.c (eg. isa_fdc_get_drive_type())
>>
>> Yes, that's a good idea.  I mistakenly thought that Q35 could be built
>> without FDC.
> 
> Could we add stubs to make it buildable that way?

Of course I'm ecstatic that one benefit of Kconfig (finding suboptimal
dependencies) is already being realized _before_ it lands, but not now.
 However, those kind of cleanups can wait for 4.1. :)

Note that we're doing the most important cleanups (e.g. not having to
bring PCI into boards that don't need it), but overall this series will
be about 120 patches and it's already a half miracle that everything was
done in <2 months and it will be already in 4.0.

Paolo
