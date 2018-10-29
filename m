Received: from eggs.gnu.org ([2001:4830:134:3::10]:53205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH7Iw-0001rQ-Pg
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH7Iu-0004tN-UP
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:10:02 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37904)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gH7Is-0004oq-Pc
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 09:09:59 -0400
Received: by mail-ot1-x343.google.com with SMTP id f24so1706332otl.5
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 06:09:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181024112525.wdysex6exqd5aued@kamzik.brq.redhat.com>
References: <20181024085602.16611-1-eric.auger@redhat.com>
	<20181024112525.wdysex6exqd5aued@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 13:09:34 +0000
Message-ID: <CAFEAcA8aEMUjPs=Y4-Zra___T15HryY4NDgxxqXMHhSQ4_+sLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: Set VIRT_COMPAT_3_0 compat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: Eric Auger <eric.auger@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 24 October 2018 at 12:25, Andrew Jones <drjones@redhat.com> wrote:
> On Wed, Oct 24, 2018 at 10:56:02AM +0200, Eric Auger wrote:
>> We are missing the VIRT_COMPAT_3_0 definition and setting.
>> Let's add them.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>> ---
>>  hw/arm/virt.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index 9f677825f9..a2b8d8f7c2 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -1871,6 +1871,9 @@ static void virt_machine_3_1_options(MachineClass *mc)
>>  }
>>  DEFINE_VIRT_MACHINE_AS_LATEST(3, 1)
>>
>> +#define VIRT_COMPAT_3_0 \
>> +    HW_COMPAT_3_0
>> +
>>  static void virt_3_0_instance_init(Object *obj)
>>  {
>>      virt_3_1_instance_init(obj);
>> @@ -1879,6 +1882,7 @@ static void virt_3_0_instance_init(Object *obj)
>>  static void virt_machine_3_0_options(MachineClass *mc)
>>  {
>>      virt_machine_3_1_options(mc);
>> +    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_3_0);
>>  }
>>  DEFINE_VIRT_MACHINE(3, 0)
>>
>> --
>> 2.17.2
>>
>>
>
> Oops, I should have done this with the 3.1 machine type. Thanks for the
> catching and patching.
>
> Reviewed-by: Andrew Jones <drjones@redhat.com>



Applied to target-arm.next, thanks.

-- PMM
