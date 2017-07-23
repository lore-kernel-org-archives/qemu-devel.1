Received: from eggs.gnu.org ([2001:4830:134:3::10]:55050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZK3z-00081F-6u
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zuban32s@gmail.com>) id 1dZK3y-0004vT-BM
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:49:03 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zuban32s@gmail.com>) id 1dZK3y-0004uL-4z
	for qemu-devel@nongnu.org; Sun, 23 Jul 2017 12:49:02 -0400
Received: by mail-pg0-x244.google.com with SMTP id z1so9649544pgs.0
	for <qemu-devel@nongnu.org>; Sun, 23 Jul 2017 09:49:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <64a3e4dd-3021-c033-0a55-2408a6c07fae@redhat.com>
References: <1500761743-1669-1-git-send-email-zuban32s@gmail.com>
	<1500761743-1669-3-git-send-email-zuban32s@gmail.com>
	<64a3e4dd-3021-c033-0a55-2408a6c07fae@redhat.com>
From: Alexander Bezzubikov <zuban32s@gmail.com>
Date: Sun, 23 Jul 2017 19:49:00 +0300
Message-ID: <CAKSfGUD-jZH2sgS2SkURdhL1f1PiWHVEER2KUx=DV-0rFw9bRw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH v2 2/6] hw/i386: allow SHPC for Q35
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, kraxel@redhat.com, seabios@seabios.org

2017-07-23 18:59 GMT+03:00 Marcel Apfelbaum <marcel@redhat.com>:

> On 23/07/2017 1:15, Aleksandr Bezzubikov wrote:
>
>> Unmask previously masked SHPC feature in _OSC method.
>>
>> Signed-off-by: Aleksandr Bezzubikov <zuban32s@gmail.com>
>> ---
>>   hw/i386/acpi-build.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
>> index 6b7bade..0d99585 100644
>> --- a/hw/i386/acpi-build.c
>> +++ b/hw/i386/acpi-build.c
>> @@ -1850,7 +1850,7 @@ static Aml *build_q35_osc_method(void)
>>        * Always allow native PME, AER (no dependencies)
>>        * Never allow SHPC (no SHPC controller in this system)
>>
>
> Seems the above comment is not longer correct :)
>
Just missed it, will fix in v3.


>
> Thanks,
> Marcel
>
>
>        */
>> -    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1D), a_ctrl));
>> +    aml_append(if_ctx, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
>>         if_ctx2 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(1))));
>>       /* Unknown revision */
>>
>>
>


-- 
Alexander Bezzubikov
