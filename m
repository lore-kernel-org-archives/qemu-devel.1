Received: from eggs.gnu.org ([2001:4830:134:3::10]:40158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fAHR3-0005vC-Fq
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 12:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fAHR0-00067N-CD
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 12:01:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fAHR0-00065K-4g
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 12:01:50 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3MG13Qw118661
	for <qemu-devel@nongnu.org>; Sun, 22 Apr 2018 12:01:47 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hgk2cr2y5-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 22 Apr 2018 12:01:47 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Sun, 22 Apr 2018 17:01:44 +0100
References: <1523819244-29954-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1523819244-29954-4-git-send-email-akrowiak@linux.vnet.ibm.com>
	<819cba2d-32d7-6a5c-978f-1c6aa04872fa@linux.vnet.ibm.com>
	<bf3ac9e4-1f53-0372-450d-1a84f780d25e@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Sun, 22 Apr 2018 18:01:39 +0200
MIME-Version: 1.0
In-Reply-To: <bf3ac9e4-1f53-0372-450d-1a84f780d25e@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Message-Id: <204d8b6e-0068-d8de-ebe6-2598d136997d@linux.ibm.com>
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



On 04/22/2018 05:43 PM, Tony Krowiak wrote:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0FEAT_INIT_MISC("ap",=C2=A0"AP=C2=A0facilitie=
s=C2=A0installed"),
>>
>> Why plural ('facilities')? Would not s/facilities/instructions be more=
 end-user
>> friendly?
>=20
> It's a matter of opinion. I prefer facilities because AP is comprised o=
f not=C2=A0only
> instructions,=C2=A0but=C2=A0also=C2=A0AP=C2=A0processors.

Please elaborate. You mean processors like AP cards? If yes what if the m=
atrix is
empty (e.g. the state we decided is the default when no further action is=
 taken
(assign queues to the vfio-ap kernel driver, set up an mdev, -device vfio=
-ap on
qemu cmd line))?

I just wanted to point out that this plural is very vague. Not speaking a=
bout that
QCI should be an AP facility too, but is not included in this 'features' =
and is not
covered by this cpu model feature. It has it's own cpu model feature and =
even a
dedicated STFLE bit.

Regards,
Halil
