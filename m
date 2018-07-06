Received: from eggs.gnu.org ([2001:4830:134:3::10]:49846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fbRuX-000247-6Q
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:40:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fbRuT-0000rD-Tc
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:40:37 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54296
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1fbRuT-0000qt-EX
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 10:40:33 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w66Ecw1M127506
	for <qemu-devel@nongnu.org>; Fri, 6 Jul 2018 10:40:32 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2k290qbnk7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 10:40:32 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Fri, 6 Jul 2018 08:40:31 -0600
Reply-To: jjherne@linux.ibm.com
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-11-git-send-email-jjherne@linux.ibm.com>
	<20180706100346.3dda6b10.cohuck@redhat.com>
	<81699814-1e9a-7031-ca3f-4d4d5c58906a@linux.ibm.com>
	<20180706142631.664474ec.cohuck@redhat.com>
	<a33b6f31-cd56-4ceb-2130-862a07611eb6@linux.ibm.com>
	<20180706151559.1429f2ad.cohuck@redhat.com>
	<ebfe4d75-3e9e-6bba-3e4e-370a1fdc5747@linux.ibm.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Fri, 6 Jul 2018 10:40:26 -0400
MIME-Version: 1.0
In-Reply-To: <ebfe4d75-3e9e-6bba-3e4e-370a1fdc5747@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <35363ed9-7cf5-6c0e-ff72-a45b96028e2f@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [RFC 10/15] s390-bios: Support for
 running format-0/1 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: bjsdjshi@linux.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com

On 07/06/2018 09:33 AM, Halil Pasic wrote:
>=20
>=20
> On 07/06/2018 03:15 PM, Cornelia Huck wrote:
>> On Fri, 6 Jul 2018 15:03:49 +0200
>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>
>>> On 07/06/2018 02:26 PM, Cornelia Huck wrote:
>>>> On Fri, 6 Jul 2018 13:42:25 +0200
>>>> Halil Pasic <pasic@linux.ibm.com> wrote:
>>>>> On 07/06/2018 10:03 AM, Cornelia Huck wrote:
>>>>>> On Thu,=C2=A0 5 Jul 2018 13:25:38 -0400
>>>>>> "Jason J. Herne" <jjherne@linux.ibm.com> wrote:
>>>>>>> +=C2=A0=C2=A0=C2=A0 rc =3D ssch(schid, &orb);
>>>>>>> +=C2=A0=C2=A0=C2=A0 if (rc) {
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print_int("ssch faile=
d with rc=3D", rc);
>>
>> One nit: make this 'cc' instead of 'rc'?
>>
>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return rc;
>>>>>>
>>>>>> Are you doing anything like retrying on cc 1/2? It's probably fine=
 to
>>>>>> give up on cc 3.
>>>>>
>>>>> We are in IPL context. We should have exclusive access to the DASD
>>>>> we are IPL-ing from, or not? My understanding was that if the layer=
s
>>>>> below us don't violate the rules, we should never observe cc 1 or 2
>>>>> here. Or am I wrong?
>>>>
>>>> cc 2 probably not (nobody should be doing a halt or a clear), but cc=
 1
>>>> if there's some unsolicited status pending?
>>>
>>> AFAIK we are supposed to give up then. The status was supposed to be
>>> cleared away on the reset which precedes IPL. If the device presented
>>> an unsolicited status between reset and starting the IPL IO on the
>>> channel I think the IPL should fail.
>>
>> I very dimly remember efforts to make (non-QEMU) IPL more robust, but =
I
>> think that was more about IFCCs and the like.
>>
>> Anyway, it is probably not worth spending too much time on. Being able
>> to IPL from vfio-ccw handled dasd is already very nice :)
>>
>=20
> PoP does not say much, and the internal documentation is, well internal.
> Maybe we could do more on IFCC but we don't have to. One other thing
> where we could do more is diagnostic info. But I really think this is
> good enough for the first shot.
>=20

My thought was similar to what Halil says. We just cleared any=20
unsolicited status. If that condition persists or we hit some crazy=20
timing window where device characteristics have changed then we likely=20
should re-drive the whole process anyway.

Also, given that this is a vfio-ccw device I suspect we are far enough=20
isolated from the "real" device that the host kernel will handle those=20
unsolicited interrupts and we won't ever see them. Can anyone confirm or=20
deny that?

For IPL, I kind of feel this is not worth worrying about because the=20
window is very small and it is only a very temporary problem for IPL (a=20
one-shot operation). Feel free to disagree :)

--=20
-- Jason J. Herne (jjherne@linux.ibm.com)
