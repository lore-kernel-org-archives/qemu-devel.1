Received: from eggs.gnu.org ([2001:4830:134:3::10]:42212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZZxk-0004R9-RQ
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:15:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cZZxg-00030A-RR
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 04:15:24 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1485778972-20924-1-git-send-email-thuth@redhat.com>
	<87lgtnd4k0.fsf@dusky.pond.sub.org>
Date: Fri, 03 Feb 2017 10:15:17 +0100
In-Reply-To: <87lgtnd4k0.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 03 Feb 2017 10:09:03 +0100")
Message-ID: <87efzfbpp6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] hw/core/or-irq: Mark the device with
 cannot_instantiate_with_device_add_yet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

Markus Armbruster <armbru@redhat.com> writes:

> Thomas Huth <thuth@redhat.com> writes:
>
>> The "or-irq" device needs to be wired up in source code, there is no
>> way the user can add this device with the "-device" parameter or the
>> "device_add" monitor command yet.

Well, the user can (I tried), but it won't do squat then.

>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  v2: Changed patch description and comment
>>
>>  hw/core/or-irq.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/hw/core/or-irq.c b/hw/core/or-irq.c
>> index 1ac090d..808c8d1 100644
>> --- a/hw/core/or-irq.c
>> +++ b/hw/core/or-irq.c
>> @@ -89,6 +89,9 @@ static void or_irq_class_init(ObjectClass *klass, void *data)
>>      dc->props = or_irq_properties;
>>      dc->realize = or_irq_realize;
>>      dc->vmsd = &vmstate_or_irq;
>> +
>> +    /* Reason: Needs to be wired up in source code, e.g. see stm32f205_soc.c */
>
> This line is a bit long, and it could be shortened easily: drop "in
> source code", or replace it by "to work".  This is how similar comments
> elsewhere are phrased.
>
>> +    dc->cannot_instantiate_with_device_add_yet = true;
>>  }
>>  
>>  static const TypeInfo or_irq_type_info = {
>
> Preferably with the comment touched up:

Commit message, too.

> Reviewed-by: Markus Armbruster <armbru@redhat.com>
