Received: from eggs.gnu.org ([2001:4830:134:3::10]:38977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eNDzx-0002F7-AK
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 03:27:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eNDzs-0001oE-Sv
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 03:27:09 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36686)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eNDzs-0001mD-Jg
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 03:27:04 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB88Q7tI061905
	for <qemu-devel@nongnu.org>; Fri, 8 Dec 2017 03:27:02 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eqn90evuh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 03:27:01 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 8 Dec 2017 08:26:58 -0000
References: <49485e7e-f950-58c5-af56-b336b4d4f0e3@linux.vnet.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 8 Dec 2017 09:26:55 +0100
MIME-Version: 1.0
In-Reply-To: <49485e7e-f950-58c5-af56-b336b4d4f0e3@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Message-Id: <1db2e4a2-929c-ba19-a8d6-892c05ecf7a4@de.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Interactive Boot Menu: New Fields in IPLB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-s390x@nongnu.org
Cc: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>



On 12/08/2017 12:56 AM, Collin L. Walling wrote:
> Hello,
>=20
> I'd like to bring up a formal discussion regarding the utilization of r=
eserved space
> in the IPL Parameter Blocks for s390x guests. Particularly the followin=
g:
>=20
> =C2=A0* How should we approach "claiming" bytes so that we do not obstr=
uct
> =C2=A0=C2=A0 future development?

We need to talk to our architecture folks after all this is used across a=
ll operating systems.
