Received: from eggs.gnu.org ([2001:4830:134:3::10]:41112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fAHSy-00076G-Fn
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 12:03:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fAHSv-0007Sm-A8
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 12:03:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39376
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fAHSv-0007SP-3U
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 12:03:49 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3MFsvWX038798
	for <qemu-devel@nongnu.org>; Sun, 22 Apr 2018 12:03:48 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2hgk2886e5-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 22 Apr 2018 12:03:47 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Sun, 22 Apr 2018 17:03:46 +0100
References: <1523819244-29954-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1523819244-29954-4-git-send-email-akrowiak@linux.vnet.ibm.com>
	<819cba2d-32d7-6a5c-978f-1c6aa04872fa@linux.vnet.ibm.com>
	<6436e788-ccc7-d292-6807-6dfa3d1bc49f@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Sun, 22 Apr 2018 18:03:39 +0200
MIME-Version: 1.0
In-Reply-To: <6436e788-ccc7-d292-6807-6dfa3d1bc49f@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <53ccfcdb-0e4b-cc79-8ba8-d115fe7675ad@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 3/5] s390x/cpumodel: Set up CPU model
 for AP device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: mjrosato@linux.vnet.ibm.com, peter.maydell@linaro.org, alifm@linux.vnet.ibm.com, eskultet@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, alex.williamson@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net



On 04/22/2018 05:52 PM, Tony Krowiak wrote:
>>> +=C2=A0=C2=A0=C2=A0 FEAT_INIT("apqci", S390_FEAT_TYPE_STFL, 12, "Quer=
y AP Configuration=C2=A0facility"),
>>
>> Why=C2=A0did=C2=A0you=C2=A0change=C2=A0this=C2=A0form=C2=A0qci=C2=A0to=
=C2=A0apqci.=C2=A0Too=C2=A0may=C2=A0people=C2=A0found=C2=A0the
>> qci=C2=A0good?
>=20
> I changed it by request and I thought it made sense to do so. Maybe we =
should=C2=A0just
> take=C2=A0a=C2=A0vote.

Sorry I've missed that request. Could you give me a link into the mail ar=
chive?
I would like to examine the discussion.

Thanks,
Halil
