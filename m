Received: from eggs.gnu.org ([2001:4830:134:3::10]:53186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1faIwk-0003jW-Gs
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1faIwh-00058I-DF
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:54:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1faIwh-00052h-46
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 06:54:07 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w63AnV4k115110
	for <qemu-devel@nongnu.org>; Tue, 3 Jul 2018 06:53:52 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k06sqtjty-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 06:53:52 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 3 Jul 2018 11:53:49 +0100
References: <20180615142108.27814-1-kwolf@redhat.com>
	<20180615142108.27814-26-kwolf@redhat.com>
	<7a310b92-f8cb-b68b-d882-9b2959794347@de.ibm.com>
	<20180622125502.GF4366@localhost.localdomain>
	<ea6a2d92-8f69-d02e-e62b-0e71ed5e25f2@de.ibm.com>
	<20180622142513.GH4366@localhost.localdomain>
	<20180622143146.GQ23296@redhat.com> <20180625095322.GC18580@redhat.com>
	<20180625114106.GJ5024@localhost.localdomain>
	<20180625114528.GL16514@angien.pipo.sk>
	<20180702080411.GA4299@localhost.localdomain>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 3 Jul 2018 12:53:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180702080411.GA4299@localhost.localdomain>
Content-Language: en-US
Message-Id: <60f6bf3c-6cad-c86f-01d7-8c376a6ccfe0@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PULL 25/26] block: Remove deprecated
 -drive option serial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>
Cc: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org



On 07/02/2018 10:04 AM, Kevin Wolf wrote:
> Am 25.06.2018 um 13:45 hat Peter Krempa geschrieben:
>> On Mon, Jun 25, 2018 at 13:41:06 +0200, Kevin Wolf wrote:
>>> Am 25.06.2018 um 11:53 hat Daniel P. Berrang=E9 geschrieben:
>>>> On Fri, Jun 22, 2018 at 03:31:46PM +0100, Daniel P. Berrang=E9 wrote=
:
>>>>> On Fri, Jun 22, 2018 at 04:25:13PM +0200, Kevin Wolf wrote:
>>>>>> Am 22.06.2018 um 15:36 hat Christian Borntraeger geschrieben:
>>
>> [...]
>>
>>>
>>> Thanks!
>>>
>>> I'll look into werror/rerror support for usb-storage. It shouldn't be
>>> too hard, though it's strictly speaking a separate problem related to
>>> using -blockdev rather than option deprecation.
>>>
>>> If Peter wants to wait for QEMU support before converting werror/rerr=
or
>>
>> Definitely. I don't want to keep around yet another hack that will
>> satisfy one specific case and then add another capability for it. We
>> should then gate the moving of the feature based on the presence of
>> werror for usb-storage.
>>
>>> to -device, maybe it would make sense to split your patch for v2 so t=
hat
>>> geometry and serial can get fixed right away?
>>
>> Yes this can be done right away.
>=20
> Has serial/gemoetry been fixed meanwhile and will it make it into the
> next release?

I cannot find an archive that has it, but it is on the libvirt mailing
list as "[libvirt] [PATCH v3] qemu: format serial and geometry on fronten=
d disk device".
Review seems done, but it has missed libvirt 4.5 which was released today=
.=20

Christian
