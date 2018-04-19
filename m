Received: from eggs.gnu.org ([2001:4830:134:3::10]:34559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1f90Ef-0002EX-JZ
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 23:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haoqf@linux.vnet.ibm.com>) id 1f90Eb-0003av-4B
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 23:27:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haoqf@linux.vnet.ibm.com>)
	id 1f90Ea-0003a1-SL
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 23:27:45 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3J3Q4EZ028717
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 23:27:43 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2heekjjdn4-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 18 Apr 2018 23:27:42 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <haoqf@linux.vnet.ibm.com>;
	Wed, 18 Apr 2018 23:27:41 -0400
References: <16124cce-593c-8191-074c-19164acc3626@linux.vnet.ibm.com>
	<20180418140458.GA2723@work-vm>
From: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Date: Thu, 19 Apr 2018 11:27:18 +0800
MIME-Version: 1.0
In-Reply-To: <20180418140458.GA2723@work-vm>
Content-Type: text/plain; charset=gbk
Message-Id: <3c7d3fa5-f8be-bf8d-c855-70985d035231@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Why is there no qom_get in hmp.c?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, armbru@redhat.com, berrange@redhat.com



=D4=DA 2018/4/18 22:04, Dr. David Alan Gilbert =D0=B4=B5=C0:
> * QingFeng Hao (haoqf@linux.vnet.ibm.com) wrote:
>> Hi all,
>> I did some investigation and found that "virsh qemu-monitor-command" s=
upports qom-get,
>> but qemu hmp doesn't. However, in hmp.c there are qom_list and qom_set=
. It confused me
>> and my question is: why is this? And how can I get a property's value =
in hmp? e.g.
>> qemu-system-* -nodefaults -machine accel=3Dqtest -no-shutdown -nograph=
ic -monitor stdio -serial none -hda /root/t.qcow2
>> "info qtree" can only get a few properties.
>=20
> I did try that in 2016 (see my series from about September); but it got
> bogged down in trying to fix output visitors; it's possible the visitor
> code has been fixed since then though.
>=20
Thanks! I used your patch with a bit fix of compilation to test, which ca=
n work and
print the json format string for structure property. The prior discussion=
s seem
no any eventual conclusion with some tricks.

> The 'Show values and description when using "qom-list"' patch
> that Ricardo Perez Blanco posted would do something similar.
Yes, I saw the patch. thanks
>=20
> Dave
>=20
>> Thanks a lot!
>> --=20
>> Regards
>> QingFeng Hao
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20

--=20
Regards
QingFeng Hao
