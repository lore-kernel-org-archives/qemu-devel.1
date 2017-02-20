Received: from eggs.gnu.org ([2001:4830:134:3::10]:52850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cfnTZ-0006Cz-34
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cfnTY-0004X7-84
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:53:57 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1487161136-9018-1-git-send-email-armbru@redhat.com>
	<575ab227-e44e-8d66-7b58-3e68e1df8491@redhat.com>
	<878tp7tx98.fsf@dusky.pond.sub.org>
	<ca73f39c-04b2-ce0b-1f80-5eef0e4861ce@redhat.com>
	<87poidkqv4.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <35ce9aed-b82a-3270-a4a9-12f2e1782b9d@redhat.com>
Date: Mon, 20 Feb 2017 13:53:49 +0100
MIME-Version: 1.0
In-Reply-To: <87poidkqv4.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] hw: Deprecate unwanted use -drive
 if=scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com



On 20/02/2017 13:07, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> On 15/02/2017 14:10, Markus Armbruster wrote:
>>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>>
>>>> On 15/02/2017 13:18, Markus Armbruster wrote:
>>>>> Drives defined with if=scsi get connected to buses created with
>>>>> -device, unlike other interface types.  Deprecate this usage.
>>>>>
>>>>> There is no good default SCSI HBA for PC machines.  Deprecate if=scsi
>>>>> there entirely.
>>>>>
>>>>> Before this series, frontends for -drive if=scsi get created by SCSI
>>>>> HBAs.  Frontends for other interface types get created by machine
>>>>> initialization.
>>>>>
>>>>> After this series, they get created by machine initialization, except
>>>>> for deprecated cases, which get created by new function
>>>>> scsi_legacy_handle_cmdline().
>>>>>
>>>>> Based on "[PATCH v3 0/8] More sensible default for -drive interface
>>>>> type".
>>>>>
>>>>> v2:
>>>>> * Trivially rebased
>>>>> * PATCH 2: Suppress warning for default drives
>>>>> * PATCH 3: Update user manual and qemu-iotests/051.pc.out
>>>>>
>>>>> Markus Armbruster (3):
>>>>>   hw/scsi: Concentrate -drive if=scsi auto-create in one place
>>>>>   hw: Deprecate -drive if=scsi with non-onboard HBAs
>>>>>   hw/i386: Deprecate -drive if=scsi with PC machine types
>>>>>
>>>>>  hw/arm/realview.c             |  2 +-
>>>>>  hw/arm/versatilepb.c          |  2 +-
>>>>>  hw/i386/pc.c                  |  6 +++++
>>>>>  hw/scsi/esp-pci.c             |  3 ---
>>>>>  hw/scsi/esp.c                 |  6 -----
>>>>>  hw/scsi/lsi53c895a.c          | 10 +++++---
>>>>>  hw/scsi/megasas.c             |  4 ----
>>>>>  hw/scsi/mptsas.c              |  4 ----
>>>>>  hw/scsi/scsi-bus.c            | 56 +++++++++++++++++++++++++++++++++++++------
>>>>>  hw/scsi/spapr_vscsi.c         |  5 ++--
>>>>>  hw/scsi/virtio-scsi.c         |  8 -------
>>>>>  include/hw/pci/pci.h          |  2 ++
>>>>>  include/hw/scsi/scsi.h        |  3 ++-
>>>>>  qemu-options.hx               |  5 ----
>>>>>  tests/qemu-iotests/051.pc.out | 12 ++++++----
>>>>>  vl.c                          | 10 ++++++++
>>>>>  16 files changed, 88 insertions(+), 50 deletions(-)
>>>>>
>>>>
>>>> Because of the ESC characters in 051.pc.out, please send the pull
>>>> request for this yourself.
>>>
>>> Is that an Acked-by?
>>
>> Not a sufficient one because the patch touches files outside my area of
>> maintenance, but for hw/scsi you can treat it as one.
> 
> Okay, that covers PATCH 1/3.
> 
> What about PATCH 3/3?  It's actually your idea...

Yep, hw/i386 too I guess.

Paolo
