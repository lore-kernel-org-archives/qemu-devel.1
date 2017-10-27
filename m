Received: from eggs.gnu.org ([2001:4830:134:3::10]:60128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e85PX-0005rL-RL
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1e85PU-0001gl-Je
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:14:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52762
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1e85PU-0001fc-DK
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 10:14:56 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9REAJCg100120
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 10:14:53 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dv43qysud-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 10:14:52 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 27 Oct 2017 15:14:51 +0100
References: <1509043965-5852-1-git-send-email-walling@linux.vnet.ibm.com>
	<5edd8fdc-e2b2-2112-afaf-30b63e738e33@suse.de>
	<b062faac-e5d8-29f8-a6df-f1559340a76a@linux.vnet.ibm.com>
	<501f20dd-26f5-8b14-8f1a-eb2a8e198018@suse.de>
	<47a2b07d-0692-5375-e6f7-16a53d56a0f1@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 27 Oct 2017 16:14:47 +0200
MIME-Version: 1.0
In-Reply-To: <47a2b07d-0692-5375-e6f7-16a53d56a0f1@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <8dbf396c-b104-2ef8-0152-6b9d3995be7c@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] s390-ccw: print carriage return with
 new lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, cohuck@redhat.com
Cc: thuth@redhat.com, bwalk@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, pasic@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, rth@twiddle.net



On 10/26/2017 10:54 PM, Collin L. Walling wrote:
> On 10/26/2017 04:48 PM, Alexander Graf wrote:
>>
>> On 26.10.17 22:37, Collin L. Walling wrote:
>>> On 10/26/2017 04:25 PM, Alexander Graf wrote:
>>>> On 26.10.17 20:52, Collin L. Walling wrote:
>>>>> The sclp console in the s390 bios writes raw data,
>>>>> leading console emulators (such as virsh console) to
>>>>> treat a new line ('\n') as just a new line instead
>>>>> of as a Unix line feed. Because of this, output
>>>>> appears in a "stair case" pattern.
>>>>>
>>>>> Let's print \r\n on every occurrence of a new line
>>>>> in the string passed to write to amend this issue.
>>>>>
>>>>> This is in sync with the guest Linux code in
>>>>> drivers/s390/char/sclp_vt220.c which also does a line feed
>>>>> conversion=C2=A0 in the console part of the driver.
>>>>>
>>>>> This fixes the s390-ccw and s390-netboot output like
>>>>> $ virsh start test --console
>>>>> Domain test started
>>>>> Connected to domain test
>>>>> Escape character is ^]
>>>>> Network boot starting...
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Using MAC address: 02:01:02:03:04:05
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Requesting information via DHCP:=C2=A0 010
>>>>>
>>>>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>>>>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 pc-bios/s390-ccw/sclp.c | 16 +++++++++++++---
>>>>> =C2=A0=C2=A0 1 file changed, 13 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
>>>>> index 486fce1..f8ad5ae 100644
>>>>> --- a/pc-bios/s390-ccw/sclp.c
>>>>> +++ b/pc-bios/s390-ccw/sclp.c
>>>>> @@ -68,17 +68,27 @@ void sclp_setup(void)
>>>>> =C2=A0=C2=A0 long write(int fd, const void *str, size_t len)
>>>>> =C2=A0=C2=A0 {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WriteEventData *sccb =3D (void=
 *)_sccb;
>>>>> +=C2=A0=C2=A0=C2=A0 const char *p =3D str;
>>>>> +=C2=A0=C2=A0=C2=A0 size_t data_len =3D 0;
>>>>> +=C2=A0=C2=A0=C2=A0 size_t i;
>>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fd !=3D 1 && fd !=3D=
 2) {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return=
 -EIO;
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 sccb->h.length =3D sizeof(WriteEve=
ntData) + len;
>>>>> +=C2=A0=C2=A0=C2=A0 for (i =3D len; i > 0; i--) {
>>>> Where did the bounds check go? If you write(max) before, you were
>>>> writing max bytes. If you do it now, you end up writing max + n byte=
s
>>>> and potentially overflow the array, no?
>>>>
>>>>
>>>> Alex
>>> I wasn't a fan of the code aesthetics and being that the SCCB write b=
uffer
>>> allows about 4k bytes of data to be written to it, I felt it was safe=
 to
>>> remove it.=C2=A0 It's unlikely we'd be writing that much data in the =
bios, plus
>>> that check did not exist prior to this fixup.
>>>
>>> Though, reading that out loud, it probably isn't the best idea to sac=
rifice
>>> code robustness for code aesthetics.
>>>
>>> for (i =3D len; i > 0; i--) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 if (data_len > SCCB_DATA_LEN - 1) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 return -SOME_ERROR
>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0 if (*p =3D=3D '\n') {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 sccb->data[data_len++] =3D=
 '\r';
>>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0 sccb->data[data_len++] =3D *p;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 p++;
>>> }
>>>
>>> What do you think?
>> Normally write() would just write less bytes than it was requested to
>> write and tell you that in the return value. So how about
>>
>> for (i =3D 0; i < len; i++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0 if ((data_len + 1) >=3D SCCB_DATA_LEN) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We would overflow =
the sccb buffer, abort early */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len =3D i;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 if (*p =3D=3D '\n') {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Terminal emulators=
 might need \r\n, so generate it */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sccb->data[data_len++=
] =3D '\r';
>> =C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 sccb->data[data_len++] =3D *p;
>> =C2=A0=C2=A0=C2=A0=C2=A0 p++;
>> }
>>
>>
>> Alex
>>
> Makes sense to me.=C2=A0 I'll let this patch sit on the list for a litt=
le
> while longer before fixing up for v3 in case Imight have missed
> something else :)

Alex version looks sane. Can you post the patch today? soft freeze is app=
roaching soon.
