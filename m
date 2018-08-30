Received: from eggs.gnu.org ([2001:4830:134:3::10]:41364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fvNQb-0002pF-Ur
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 09:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fvNOu-0001F7-PU
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 09:54:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fvNOu-0001EO-GT
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 09:54:20 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w7UDsGAd072417
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 09:54:18 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2m6gjakvcg-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 09:54:17 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 30 Aug 2018 07:54:10 -0600
References: <20180810153223.28409-1-marcandre.lureau@redhat.com>
	<20180810153223.28409-2-marcandre.lureau@redhat.com>
	<CAJ+F1CJFOer5vAy63eQ_YKx2jnq=TC7X9ChkC-=qA=QHZv9kXA@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu, 30 Aug 2018 09:54:05 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJFOer5vAy63eQ_YKx2jnq=TC7X9ChkC-=qA=QHZv9kXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <bddfd186-b4ab-5007-4936-a31bc701d1c4@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 1/6] hw/i386: add pc-i440fx-3.1 &
 pc-q35-3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On 08/28/2018 10:05 AM, Marc-Andr=C3=A9 Lureau wrote:
> ping
> On Fri, Aug 10, 2018 at 5:34 PM Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
>> The following patch is going to add compatiblity parameters.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>   include/hw/compat.h  |  4 +++-
>>   include/hw/i386/pc.h |  5 ++++-
>>   hw/i386/pc_piix.c    | 13 ++++++++++++-
>>   hw/i386/pc_q35.c     | 12 +++++++++++-
>>   4 files changed, 30 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/hw/compat.h b/include/hw/compat.h
>> index c08f4040bb..f8e596969a 100644
>> --- a/include/hw/compat.h
>> +++ b/include/hw/compat.h
>> @@ -1,7 +1,9 @@
>>   #ifndef HW_COMPAT_H
>>   #define HW_COMPAT_H
>>
>> -#define HW_COMPAT_2_12 \
>> +#define HW_COMPAT_3_0
Should probably be 3_1 now?
>> +
>> +#define HW_COMPAT_2_12                          \
>>       {\
>>           .driver   =3D "migration",\
>>           .property =3D "decompress-error-check",\
>> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
>> index 6894f37df1..09b0365a8e 100644
>> --- a/include/hw/i386/pc.h
>> +++ b/include/hw/i386/pc.h
>> @@ -294,7 +294,10 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
>>   int e820_get_num_entries(void);
>>   bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>>
>> -#define PC_COMPAT_2_12 \
>> +#define PC_COMPAT_3_0 \
Same here?
>> +    HW_COMPAT_3_0
>> +
>> +#define PC_COMPAT_2_12                          \
>>       HW_COMPAT_2_12 \
>>       {\
>>           .driver   =3D TYPE_X86_CPU,\
>> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
>> index dc09466b3e..7db1fa88ef 100644
>> --- a/hw/i386/pc_piix.c
>> +++ b/hw/i386/pc_piix.c
>> @@ -428,13 +428,24 @@ static void pc_i440fx_machine_options(MachineCla=
ss *m)
>>       machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
>>   }
>>
>> -static void pc_i440fx_3_0_machine_options(MachineClass *m)
>> +static void pc_i440fx_3_1_machine_options(MachineClass *m)
>>   {
>>       pc_i440fx_machine_options(m);
>>       m->alias =3D "pc";
>>       m->is_default =3D 1;
>>   }
>>
>> +DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1", NULL,
>> +                      pc_i440fx_3_1_machine_options);
>> +
>> +static void pc_i440fx_3_0_machine_options(MachineClass *m)
should this be the 3_1=C2=A0 rather than the one above?
>> +{
>> +    pc_i440fx_machine_options(m);
>> +    m->is_default =3D 0;
>> +    m->alias =3D NULL;
>> +    SET_MACHINE_COMPAT(m, PC_COMPAT_3_0);
>> +}
>> +
>>   DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
>>                         pc_i440fx_3_0_machine_options);
>>
>> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
>> index 532241e3f8..cb1980a088 100644
>> --- a/hw/i386/pc_q35.c
>> +++ b/hw/i386/pc_q35.c
>> @@ -311,12 +311,22 @@ static void pc_q35_machine_options(MachineClass =
*m)
>>       m->max_cpus =3D 288;
>>   }
>>
>> -static void pc_q35_3_0_machine_options(MachineClass *m)
>> +static void pc_q35_3_1_machine_options(MachineClass *m)
>>   {
>>       pc_q35_machine_options(m);
>>       m->alias =3D "q35";
>>   }
>>
>> +DEFINE_Q35_MACHINE(v3_1, "pc-q35-3.1", NULL,
>> +                   pc_q35_3_1_machine_options);
>> +
>> +static void pc_q35_3_0_machine_options(MachineClass *m)
>> +{
>> +    pc_q35_machine_options(m);
>> +    m->alias =3D NULL;
>> +    SET_MACHINE_COMPAT(m, PC_COMPAT_3_0);
>> +}
>> +
>>   DEFINE_Q35_MACHINE(v3_0, "pc-q35-3.0", NULL,
>>                       pc_q35_3_0_machine_options);
>>
>> --
>> 2.18.0.547.g1d89318c48
>>
>>
>
