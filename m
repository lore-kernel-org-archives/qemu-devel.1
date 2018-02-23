Received: from eggs.gnu.org ([2001:4830:134:3::10]:35735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1epEt9-0000iZ-7n
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:03:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1epEt6-00084s-58
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:03:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1epEt5-00084X-Q4
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:03:52 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1NExFnG046385
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 10:03:50 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2game1am59-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 10:03:50 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Fri, 23 Feb 2018 10:03:48 -0500
References: <1519241752-28083-1-git-send-email-walling@linux.vnet.ibm.com>
	<3b160f2d-8c32-7b0a-3afc-0519c02cee81@de.ibm.com>
	<5fd04c0d-ad1e-13a7-4e5a-5f28662479a7@redhat.com>
	<68148fff-0c6e-0470-a0e5-0379ecfd3dd8@linux.vnet.ibm.com>
	<e685de9a-d216-3d73-0ea3-b0d193a7f79e@redhat.com>
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Fri, 23 Feb 2018 10:03:45 -0500
MIME-Version: 1.0
In-Reply-To: <e685de9a-d216-3d73-0ea3-b0d193a7f79e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <31ed867c-8ce4-576a-8e17-4cad1e7877c1@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 00/13] Interactive Boot Menu for DASD
 and SCSI Guests on s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.vnet.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com

On 02/23/2018 08:33 AM, Thomas Huth wrote:
> On 23.02.2018 12:50, Viktor Mihajlovski wrote:
>> On 23.02.2018 11:17, Thomas Huth wrote:
>>> On 23.02.2018 09:53, Christian Borntraeger wrote:
>>>> Hmmm, on my ubuntu 16.04 guest, I get the boot menu with no timeout =
even if I do not
>>>> specify loadparm or boot menu:
>>>>
>>>> qemu-kvm -drive file=3D/var/lib/libvirt/qemu/image.zhyp140,if=3Dnone=
,id=3Dd1 -device virtio-blk-ccw,drive=3Dd1,bootindex=3D1
>>> I can reproduce this now, too. FWIW: It only happens with
>>> virtio-blk-ccw, not with virtio-scsi-ccw (that's why I did not notice=
 it
>>> first). Collin, can you reproduce this, too?
>>>
>>>   Thomas
>>> The idea is to support the zipl boot menu on ECKD disks (which have a=
 timeout by themselves)
>> even without switching the boot menu on. This is to have the same beha=
vior as one would see
>> on LPAR or z/VM.
>> The issue is that the boot code tries to interpret the program table o=
f SCSI bootmaps as if
>> a boot menu has been specified.
> Ok, thanks for the explanation, makes sense now.
>
> Collin, could you please spin a v9 with the required changes included?
>
>   Thanks,
>    Thomas
>
>
I see.=C2=A0 I overlooked that we could treat a SCSI device as a CCW devi=
ce.=C2=A0=20
The proposed change makes sense.
I'll respin 9 and reply to this chain.

--=20
- Collin L Walling
