Received: from eggs.gnu.org ([2001:4830:134:3::10]:37628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ewrPN-0004vZ-EA
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1ewrPL-00065g-8C
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:36:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1ewrPK-00065J-VS
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:36:39 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2GFaU8u000990
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 11:36:37 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2grdubrcfv-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 11:36:37 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 16 Mar 2018 15:36:34 -0000
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-6-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4deae7b2-ae8a-f5a9-7979-0dcd20894729@linux.vnet.ibm.com>
	<d0443435-a2d2-e256-3663-4e591f0e48bf@linux.vnet.ibm.com>
	<fe9a2f52-6833-df90-b2e9-96e8db047904@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 16:36:27 +0100
MIME-Version: 1.0
In-Reply-To: <fe9a2f52-6833-df90-b2e9-96e8db047904@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <b3ffd5a5-4bf2-c620-9bf6-6e1404d9ab54@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/7] s390x/vfio: ap: Introduce VFIO AP
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: mjrosato@linux.vnet.ibm.com, peter.maydell@linaro.org, alifm@linux.vnet.ibm.com, eskultet@redhat.com, david@redhat.com, cohuck@redhat.com, heiko.carstens@de.ibm.com, alex.williamson@redhat.com, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net



On 03/16/2018 04:29 PM, Tony Krowiak wrote:
>>> However=C2=A0it=C2=A0is=C2=A0a=C2=A0general=C2=A0switch=C2=A0for=C2=A0=
the=C2=A0VM.
>>> It=C2=A0looks=C2=A0strange=C2=A0to=C2=A0have=C2=A0this=C2=A0inside=C2=
=A0the=C2=A0realize=C2=A0callback
>>>
>> I=C2=A0kind=C2=A0of=C2=A0semi=C2=A0agree.
>>
>> The=C2=A0previous=C2=A0solution=C2=A0(having=C2=A0this=C2=A0transparen=
t=C2=A0for=C2=A0QEMU)=C2=A0had
>> benefits.=C2=A0Why=C2=A0did=C2=A0we=C2=A0move=C2=A0away=C2=A0from=C2=A0=
that=C2=A0again?
> This was done to address the multitude of objections and opinions relat=
ed=C2=A0to
> how/when/where ECA_APIE is set. Pierre summed it up best with his comme=
nt=C2=A0"we
> need to separate the CPU feature defining 'if AP instructions are avail=
able'
> from the QEMU property defining 'How we provide the instructions'. I ag=
ree=C2=A0and
> this=C2=A0is=C2=A0how=C2=A0I=C2=A0chose=C2=A0to=C2=A0implement=C2=A0tha=
t.

It's even more separated if the one is controlled via a
userspace facing interface (cpu models) and the other
is controlled via an in-kernel interface (e.g. like
done previously in vfio open AFAIR).

I can not accept this answer. I don't recall the multitude
and I think I've showed that the 'need to separate' argument
does not work.

Regards,
Halil
