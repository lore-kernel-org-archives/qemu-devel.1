Received: from eggs.gnu.org ([2001:4830:134:3::10]:35121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e86zR-0007Yi-Gy
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1e86zM-0000D0-Gn
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:56:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1e86zM-0000CE-67
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:56:04 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9RFtjl5104207
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 11:55:56 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dv79hhr15-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 11:55:55 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 27 Oct 2017 16:55:53 +0100
References: <1509114613-10601-1-git-send-email-walling@linux.vnet.ibm.com>
	<5d039f30-4896-fef3-3b1c-a2be4edcf13b@linux.vnet.ibm.com>
	<2773f2f1-6b0f-855d-b51e-7e8d5ecd67ab@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 27 Oct 2017 17:55:49 +0200
MIME-Version: 1.0
In-Reply-To: <2773f2f1-6b0f-855d-b51e-7e8d5ecd67ab@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <989d044a-93fd-35b3-30f5-f210ca5dc44f@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] s390-ccw: print carriage return with
 new lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 10/27/2017 05:47 PM, Collin L. Walling wrote:
>>
>=20
> I wanted to do the same, however str is void can cannot be indexed dire=
ctly.
> We'd have to do some nasty casting first, so I figured having *p made t=
hings
> look=C2=A0cleaner.

I did not consider that, sorry. (One could rename p to str AFAIR to expre=
ss
that we are actually scanning the parameter and that the local is just fo=
r
avoiding the cast). But I really think we should go with Alex's proposal.

Halil
