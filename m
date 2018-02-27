Received: from eggs.gnu.org ([2001:4830:134:3::10]:34278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eqgnz-0000w5-Mt
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:04:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eqgnw-0006zf-Eu
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:04:35 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35152
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1eqgnv-0006zD-PX
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:04:32 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1RF3xNh027242
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 10:04:31 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gd9dx8t96-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 10:04:25 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Tue, 27 Feb 2018 10:04:20 -0500
References: <1519641757-12396-1-git-send-email-thuth@redhat.com>
	<1519641757-12396-7-git-send-email-thuth@redhat.com>
	<20180226194857.01ce4a8c.cohuck@redhat.com>
	<b6664df2-eec4-7e35-1498-be27b5cc3e79@linux.vnet.ibm.com>
	<dcfd4bf5-fd36-52cc-8b66-87a68e80cc48@linux.vnet.ibm.com>
	<20180227101240.761cc93f.cohuck@redhat.com>
	<06458ee3-030e-5635-1893-004adedf6151@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2018 10:04:17 -0500
MIME-Version: 1.0
In-Reply-To: <06458ee3-030e-5635-1893-004adedf6151@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <0f196cc3-a2c0-66b9-9bfa-96fded82e0b7@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PULL-for-s390x 06/14] s390-ccw:
 parse and set boot menu options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 02/27/2018 04:22 AM, Thomas Huth wrote:
> On 27.02.2018 10:12, Cornelia Huck wrote:
>> On Mon, 26 Feb 2018 14:44:45 -0500
>> "Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:
>>
>>> On 02/26/2018 02:29 PM, Collin L. Walling wrote:
>>>> On 02/26/2018 01:48 PM, Cornelia Huck wrote:
>>>>> On Mon, 26 Feb 2018 11:42:29 +0100
>>>>> Thomas Huth <thuth@redhat.com> wrote:
> [...]
>>>>>> +=C2=A0=C2=A0=C2=A0 switch (ipl->iplb.pbt) {
>>>>>> +=C2=A0=C2=A0=C2=A0 case S390_IPL_TYPE_CCW:
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>>> +=C2=A0=C2=A0=C2=A0 default:
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("boot men=
u is not supported for this device
>>>>>> type.");
>>>>> If I specify both a bootindex for a device and a -kernel parameter,=
 I
>>>>> get this error message. Looks a tad odd, but not sure how to avoid =
it.
>>>> Hmm... perhaps an additional check if no IPLB, then skip trying to s=
et
>>>> any boot menu data?
> [...]
>> How shall we proceed? I'd be willing to pull this now and then apply
>> fixups on top, or we can have a respin. Thomas?
> Since this is about a change in hw/s390x/ and not about
> pc-bios/s390-ccw/ (i.e. no need to rebuild the firmware binaries for
> this), I think I'd rather prefer a fix-up patch on top instead of a re-=
spin.
>
>   Thomas
>
I'll get right on it and post to the qemu lists.

--=20
- Collin L Walling
