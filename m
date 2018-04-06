Received: from eggs.gnu.org ([2001:4830:134:3::10]:51740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1f4QY9-0001t5-Ak
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1f4QY6-0001RD-81
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:33:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60314
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1f4QY6-0001Qb-3Q
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 08:32:58 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w36CWets063064
	for <qemu-devel@nongnu.org>; Fri, 6 Apr 2018 08:32:57 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2h68k4s32g-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 08:32:57 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 6 Apr 2018 13:32:55 +0100
From: Halil Pasic <pasic@linux.vnet.ibm.com>
References: <1521156300-19296-1-git-send-email-akrowiak@linux.vnet.ibm.com>
	<1521156300-19296-7-git-send-email-akrowiak@linux.vnet.ibm.com>
	<4d76348b-e1de-7d92-3434-5213d092c6d0@redhat.com>
	<ab945ab4-ee17-815b-2a59-b7608ff32eb6@linux.vnet.ibm.com>
	<0b957a5c-1a87-7952-292d-f65052bb6c5a@linux.vnet.ibm.com>
	<20180403113619.54ff1e18.cohuck@redhat.com>
	<dd4fceac-818f-14a2-62b4-94ae73e21796@linux.vnet.ibm.com>
	<ee3b89cf-c260-361f-3eb6-71371bbe827f@linux.vnet.ibm.com>
	<20180406104024.51e9e826.cohuck@redhat.com>
	<0244b89c-e8c4-72a1-9b25-d69341ec721d@redhat.com>
	<e5b5f06e-7007-1398-25c4-f37c2db5de79@linux.vnet.ibm.com>
Date: Fri, 6 Apr 2018 14:32:49 +0200
MIME-Version: 1.0
In-Reply-To: <e5b5f06e-7007-1398-25c4-f37c2db5de79@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <c8fa6b1b-379f-a884-9feb-d5c96effa304@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 6/7] s390x/kvm: handle AP instruction
 interception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: mjrosato@linux.vnet.ibm.com, peter.maydell@linaro.org, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, alex.williamson@redhat.com, eskultet@redhat.com, Pierre Morel <pmorel@linux.vnet.ibm.com>, alifm@linux.vnet.ibm.com, heiko.carstens@de.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, jjherne@linux.vnet.ibm.com, schwidefsky@de.ibm.com, pbonzini@redhat.com, bjsdjshi@linux.vnet.ibm.com, eric.auger@redhat.com, rth@twiddle.net



On 04/06/2018 02:09 PM, Halil Pasic wrote:
> Yes it is conceptually ugly. I'm 100% with you. That's why it should go
> away soon. From the practicality perspective however I would even argue that it's
> helpful to the user: tells 'oops you have forgotten something'. IMHO
> it's a shortcut of type make the problem smaller. Regarding what is
> harder and what is easier: the author is probably the most fit to decide
> that. If it is harder, it makes no sense, as this is all about cutting
> corners.

I've just realized, I have overlooked something. And that is using
what libvirt calls host-model and host-passthrough mode. There the
user does not explicitly ask for ap=on. So the user would get slapped
in the face by this 'needs vfio-ap device' message (AFAIU) after
upgrading stuff (without even knowing that AP was added) which is
extremely ugly! I need to think about this some more.
