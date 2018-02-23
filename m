Received: from eggs.gnu.org ([2001:4830:134:3::10]:34560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1epEpJ-0005tC-K1
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1epEpG-0004vV-I3
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:59:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37624)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1epEpG-0004uB-8Q
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 09:59:54 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1NExIgv096471
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:59:53 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gam85jxmx-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 09:59:52 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Fri, 23 Feb 2018 09:59:50 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
References: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
	<29048432-906e-5fbe-d927-0814b0c24e4d@de.ibm.com>
	<d31eb692-fd5e-7e83-1fa3-66d66f631043@linux.vnet.ibm.com>
	<25e410d1-3b6a-1178-d46c-87f247eacea9@linux.vnet.ibm.com>
	<11d66e11-7a56-c5d0-f285-2a532e85fcf8@de.ibm.com>
	<450ee50a-660b-6ec8-7de4-e5c9ce8fa26a@linux.vnet.ibm.com>
	<173adc8c-f251-73e4-9cda-f278b2483186@linux.vnet.ibm.com>
	<f599e3d7-0c82-f841-ae18-9a6a3a010030@redhat.com>
	<bae827ac-1b24-70c6-2bfe-6e9f95136917@de.ibm.com>
	<fcbfab45-e231-038e-696c-607a42683124@linux.vnet.ibm.com>
Date: Fri, 23 Feb 2018 09:59:48 -0500
MIME-Version: 1.0
In-Reply-To: <fcbfab45-e231-038e-696c-607a42683124@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <7f741104-f121-3c4b-7850-bb72f2d43a7b@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v8 00/13] Interactive Boot
 Menu for DASD and SCSI Guests on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, frankja@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, david@redhat.com

On 02/23/2018 09:57 AM, Collin L. Walling wrote:
> On 02/23/2018 05:11 AM, Christian Borntraeger wrote:
>>
>> On 02/23/2018 11:07 AM, Thomas Huth wrote:
>>> On 22.02.2018 20:40, Collin L. Walling wrote:
>>>> On 02/22/2018 11:45 AM, Collin L. Walling wrote:
>>>>> On 02/22/2018 10:44 AM, Christian Borntraeger wrote:
>>>>>> On 02/22/2018 04:40 PM, Collin L. Walling wrote:
>>>>>>> On 02/22/2018 07:23 AM, Viktor Mihajlovski wrote:
>>>>>>>> On 22.02.2018 12:51, Christian Borntraeger wrote:
>>>>>>>>> Series
>>>>>>>>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>>>>> Thanks!!!
>>>>>>>
>>>>>>>>> menu on scsi and dasd bootmaps tested successfully.
>>>>>>>>>
>>>>>>>>> There is one thing that we might want to fix (can be an addon
>>>>>>>>> patch since this is a non-customer
>>>>>>>>> scenario (no libvirt)).
>>>>>>>>>
>>>>>>>>> If you start QEMU manually without a bootindex, the -boot menu=3D=
on
>>>>>>>>> is ignored
>>>>>>>>> if no drive has a bootindex.
>>>>>>>>>
>>>>>>>>> For example:
>>>>>>>>>
>>>>>>>>> -drive file=3D/dev/dasda,if=3Dnone,id=3Dd1 -device
>>>>>>>>> virtio-blk-ccw,drive=3Dd1,bootindex=3D1 -boot menu=3Don
>>>>>>>>> does work
>>>>>>>>>
>>>>>>>>> -drive file=3D/dev/dasda -boot menu=3Don
>>>>>>>>> does not
>>>>>>>>>
>>>>>>>>> instead it prints:
>>>>>>>>> qemu-system-s390x: boot menu is not supported for this device=20
>>>>>>>>> type.
>>>>>>>>>
>>>>>>>>> and the boots up the default entry.
>>>>>>>>>
>>>>>>>> That should indeed be a separate patch, as it would move logic
>>>>>>>> currently
>>>>>>>> in the BIOS up to QEMU (find the first defined virtio disk and
>>>>>>>> select it
>>>>>>>> as boot disk).
>>>>>>>> In fact it's more complicated than that, because it would have t=
o
>>>>>>>> properly account for -boot order=3D[acdn] and produce the respec=
tive
>>>>>>>> IPLB.
>>>>>>>> While it makes sense, I wouldn't rush that in but rather change=20
>>>>>>>> the
>>>>>>>> error message to indicate that -device bootindex is needed to=20
>>>>>>>> activate
>>>>>>>> the menu, at least for the time being.
>>>>>>>> [...]
>>>>>>>>
>>>>>>> I can look into it.=C2=A0 Theoretically, the easier fix should ju=
st
>>>>>>> involve parsing all
>>>>>>> of the -device commands and looking for a "bootindex=3D1" field. =
The
>>>>>>> Qemu options
>>>>>>> code already handles a bulk of this work, so it's just a matter o=
f
>>>>>>> putting it all
>>>>>>> together.
>>>>>>>
>>>>>>> Shall I whip something up and post what I have as a reply to this
>>>>>>> email chain?
>>>>>> In fact, it should already be there.
>>>>>>
>>>>>> static bool s390_gen_initial_iplb(S390IPLState *ipl)
>>>>>> {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceState *dev_st;
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev_st =3D get_boot_device(0);
>>>>>>
>>>>>> --> if this returns 0 we have no bootindex statement anywhere and=20
>>>>>> the
>>>>>> BIOS will IPL the default
>>>>>> disk.
>>>>>>
>>>>>>
>>>>> Makes sense.=C2=A0 I'm working on making this patch look as clean a=
s
>>>>> possible. The fact that no boot menu
>>>>> options present means we fallback to using zipl values for CCW bein=
g
>>>>> tied into the switch statement
>>>>> is making things a bit tricky. Just have to think the logic through=
 a
>>>>> bit.=C2=A0 Will get back to you once
>>>>> I have something good.
>>>>>
>>>> This should do the trick (this can also be squished painlessly into=20
>>>> 6/13
>>>> if desired)
>>> Patch looks fine to me. I can either take it directly like this, or i=
n
>>> case you have to respin (depends on the problem that Christian report=
ed
>>> with the Ubuntu guest), I'm also fine if you squash it into an earlie=
r
>>> patch instead.
>> FWIW, my problem (a menu happens even without -boot menu=3Don or=20
>> loadparm) also
>> happens with other guests (e.g. fedora).
>>
>>
> Is this on guests using DASD?=C2=A0 If so, a boot menu will appear if t=
he=20
> appropriate zipl configuration
> values are set (even if no -boot menu or loadparm).=C2=A0 Patch 12/13 g=
oes=20
> into more detail.
>
> Is this not wanted behavior?
>
Just noticed other email chain -- ignore me.

--=20
- Collin L Walling
