Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A2DC04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 05:58:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E975420879
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 05:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E975420879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51513 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ3yo-000738-7b
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 01:58:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hQ3ww-0005v9-D6
	for qemu-devel@nongnu.org; Mon, 13 May 2019 01:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hQ3wu-0002zU-TY
	for qemu-devel@nongnu.org; Mon, 13 May 2019 01:56:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49424)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hQ3wu-0002yp-L2; Mon, 13 May 2019 01:56:32 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C968E307D91E;
	Mon, 13 May 2019 05:56:30 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-122.ams2.redhat.com [10.36.116.122])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F1A735D9CC;
	Mon, 13 May 2019 05:56:23 +0000 (UTC)
To: Collin Walling <walling@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, 
	qemu-s390x@nongnu.org, cohuck@redhat.com, rth@twiddle.net,
	david@redhat.com, pasic@linux.ibm.com, mst@redhat.com, pbonzini@redhat.com
References: <1556749903-19221-1-git-send-email-walling@linux.ibm.com>
	<4f5c8f1a-8898-c5e3-0b96-065a1ac21476@de.ibm.com>
	<c26d831b-1ef5-ad6d-f0ce-4f3c7c0993c0@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; keydata=
	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
Organization: Red Hat
Message-ID: <f997a54e-7865-727d-6d1d-f7a18047024f@redhat.com>
Date: Mon, 13 May 2019 07:56:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c26d831b-1ef5-ad6d-f0ce-4f3c7c0993c0@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 13 May 2019 05:56:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4] s390: diagnose 318 info
 reset and migration support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/05/2019 22.50, Collin Walling wrote:
> On 5/9/19 5:58 AM, Christian Borntraeger wrote:
>>
>>
>> On 02.05.19 00:31, Collin Walling wrote:
>>> DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
>>> be intercepted by SIE and handled via KVM. Let's introduce some
>>> functions to communicate between QEMU and KVM via ioctls. These
>>> will be used to get/set the diag318 related information (also known
>>> as the "Control Program Code" or "CPC"), as well as check the system
>>> if KVM supports handling this instruction.
>>>
>>> The availability of this instruction is determined by byte 134, bit 0
>>> of the Read Info block. This coincidentally expands into the space us=
ed
>>> for CPU entries, which means VMs running with the diag318 capability
>>> will have a reduced maximum CPU count. To alleviate this, let's
>>> calculate
>>> the actual max CPU entry space by subtracting the size of Read Info f=
rom
>>> the SCCB size then dividing that number by the size of a CPU entry. I=
f
>>> this value is less than the value denoted by S390_MAX_CPUS, then let'=
s
>>> reduce the max cpus for s390 from 248 to 240 in an effort to anticipa=
te
>>> this potentially happening again in the future.
>>>
>>> In order to simplify the migration and system reset requirements of
>>> the diag318 data, let's introduce it as a device class and include
>>> a VMStateDescription.
>>>
>>> Diag318 is reset on during modified clear and load normal.
>>>
>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>> ---
>>> =C2=A0 hw/s390x/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 +
>>> =C2=A0 hw/s390x/diag318.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 100
>>> +++++++++++++++++++++++++++++++++++++++++++
>>> =C2=A0 hw/s390x/diag318.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 39 +++++++++++++++++
>>> =C2=A0 hw/s390x/s390-virtio-ccw.c=C2=A0=C2=A0 |=C2=A0 23 ++++++++++
>>> =C2=A0 hw/s390x/sclp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +++
>>> =C2=A0 include/hw/s390x/sclp.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 2 +
>>> =C2=A0 linux-headers/asm-s390/kvm.h |=C2=A0=C2=A0 4 ++
>>> =C2=A0 target/s390x/kvm-stub.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
15 +++++++
>>> =C2=A0 target/s390x/kvm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 32 ++++++++++++++
>>> =C2=A0 target/s390x/kvm_s390x.h=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
 3 ++
>>> =C2=A0 10 files changed, 224 insertions(+)
>>> =C2=A0 create mode 100644 hw/s390x/diag318.c
>>> =C2=A0 create mode 100644 hw/s390x/diag318.h
>>>
>>> diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
>>> index e02ed80..93621dc 100644
>>> --- a/hw/s390x/Makefile.objs
>>> +++ b/hw/s390x/Makefile.objs
>>> @@ -34,3 +34,4 @@ obj-$(CONFIG_KVM) +=3D s390-stattrib-kvm.o
>>> =C2=A0 obj-y +=3D s390-ccw.o
>>> =C2=A0 obj-y +=3D ap-device.o
>>> =C2=A0 obj-y +=3D ap-bridge.o
>>> +obj-y +=3D diag318.o
>>> diff --git a/hw/s390x/diag318.c b/hw/s390x/diag318.c
>>> new file mode 100644
>>> index 0000000..94b44da
>>> --- /dev/null
>>> +++ b/hw/s390x/diag318.c
>>> @@ -0,0 +1,100 @@
>>> +/*
>>> + * DIAGNOSE 0x318 functions for reset and migration
>>> + *
>>> + * Copyright IBM, Corp. 2019
>>> + *
>>> + * Authors:
>>> + *=C2=A0 Collin Walling <walling@linux.ibm.com>
>>> + *
>>> + * This work is licensed under the terms of the GNU GPL, version 2
>>> or (at your
>>> + * option) any later version. See the COPYING file in the top-level
>>> directory.
>>> + */
>>> +
>>> +#include "hw/s390x/diag318.h"
>>> +#include "qapi/error.h"
>>> +#include "kvm_s390x.h"
>>> +#include "sysemu/kvm.h"
>>> +
>>> +static int diag318_post_load(void *opaque, int version_id)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 DIAG318State *d =3D opaque;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 kvm_s390_set_cpc(d->cpc);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 /* It is not necessary to retain a copy of the cp=
c after
>>> migration. */
>>> +=C2=A0=C2=A0=C2=A0 d->cpc =3D 0;
>>
>> But we also do not need to zero it out? Can't you just drop these 2
>> lines?
>>
>>
>=20
> Absolutely. I'll drop them.
>=20
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> +static int diag318_pre_save(void *opaque)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 DIAG318State *d =3D opaque;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 kvm_s390_get_cpc(&d->cpc);
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> +static bool diag318_needed(void *opaque)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 DIAG318State *d =3D opaque;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 return d->enabled;
>>> +}
>>
>> I would like to have a cpumodel entry that allows to disable that
>> feature. And we should
>> then check for this.
>>
>=20
> Noted.
>=20
>>> +
>>> +const VMStateDescription vmstate_diag318 =3D {
>>> +=C2=A0=C2=A0=C2=A0 .name =3D "vmstate_diag318",
>>> +=C2=A0=C2=A0=C2=A0 .post_load =3D diag318_post_load,
>>> +=C2=A0=C2=A0=C2=A0 .pre_save =3D diag318_pre_save,
>>> +=C2=A0=C2=A0=C2=A0 .version_id =3D 1,
>>> +=C2=A0=C2=A0=C2=A0 .minimum_version_id =3D 1,
>>> +=C2=A0=C2=A0=C2=A0 .needed =3D diag318_needed,
>>> +=C2=A0=C2=A0=C2=A0 .fields =3D (VMStateField[]) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_UINT64(cpc, DIAG3=
18State),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VMSTATE_END_OF_LIST()
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +};
>>> +
>>> +static void s390_diag318_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 DIAG318State *d =3D DIAG318(dev);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (kvm_s390_has_diag318()) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 d->enabled =3D true;
>>> +=C2=A0=C2=A0=C2=A0 }
>>
>> same here -> cpumodel
>> Then we can get rid of the enabled bool.
>=20
> Noted.
>=20
> [...]
>>> =C2=A0 =C2=A0 static void s390_cpu_plug(HotplugHandler *hotplug_dev,
>>> @@ -570,6 +585,7 @@ static void machine_set_loadparm(Object *obj,
>>> const char *val, Error **errp)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ms->loadparm[i=
] =3D ' '; /* pad right with spaces */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 }
>>> +
>>> =C2=A0 static inline void s390_machine_initfn(Object *obj)
>>> =C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_property_add_bool(obj, "aes-key=
-wrap",
>>> @@ -652,6 +668,13 @@ static void
>>> ccw_machine_4_0_instance_options(MachineState *machine)
>>> =C2=A0 =C2=A0 static void ccw_machine_4_0_class_options(MachineClass =
*mc)
>>> =C2=A0 {
>>> +=C2=A0=C2=A0=C2=A0 /*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Read Info might reveal more bytes used to=
 detect facilities,
>>> thus
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * reducing the number of CPU entries. Let's=
 reduce the max CPUs by
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 * an arbitrary number in effort to anticipa=
te future facility
>>> bytes.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> +=C2=A0=C2=A0=C2=A0 if ((SCCB_SIZE - sizeof(ReadInfo)) / sizeof(CPUEn=
try) <
>>> S390_MAX_CPUS)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc->max_cpus =3D S390_MAX=
_CPUS - 8;
>>
>> Maybe this should depend on the presence of this feature in the cpumod=
el?
>>
>=20
> That's a good idea. This would allow the user to fine tune their VM to
> either allow the original max 248 _or_ enable the diag318 instruction.

Please also not that ccw_machine_4_0_class_options() is called from
ccw_machine_3_1_class_options() and thus all older machine class option
functions - you have to make sure to restore the 248 for them.

As a test, please check that you can migrate a s390-ccw-virtio-3.1
machine with 248 CPUs from a qemu without your patch to a QEMU with your
patch and back.

 Thomas

