Received: from eggs.gnu.org ([2001:4830:134:3::10]:45807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1emM9B-000330-AP
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 11:12:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1emM96-0000cS-8z
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 11:12:33 -0500
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
	<1517864246-11101-12-git-send-email-walling@linux.vnet.ibm.com>
	<8259c694-3f9a-ce9e-9d1d-252568f3e73a@redhat.com>
	<ad1e16df-8ebe-5271-b62c-76924c758cbc@linux.vnet.ibm.com>
	<30b25d5a-2525-c34c-a862-7b5bcbbcffe3@redhat.com>
	<90cf5fb5-ea0f-51aa-4d2b-0bef0d3925c5@linux.vnet.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <458ba5c9-7ac4-7716-3010-f60b942b1856@redhat.com>
Date: Thu, 15 Feb 2018 17:12:09 +0100
MIME-Version: 1.0
In-Reply-To: <90cf5fb5-ea0f-51aa-4d2b-0bef0d3925c5@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 11/12] s390-ccw: clear
 pending irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: frankja@linux.vnet.ibm.com, cohuck@redhat.com, alifm@linux.vnet.ibm.com, mihajlov@linux.vnet.ibm.com, borntraeger@de.ibm.com

>=20
> Ah, I understand the problem now. We can't have a multiple irqs of the=20
> *same* *type*
> pending at the same time, but we /can/ have multiple irqs of *different=
*=20
> *types* pending
> at the same time (i.e. a ckc and service signal).

Indeed, at least for these types of external interrupts.

(if I remember correctly, previous TCG versions did this wrong but I
fixed it :) )

>=20
> Thanks for clearing this up for me.=C2=A0 I was over thinking the probl=
em and=20
> I agree that
> a print would be the easiest solution. :)
>=20


--=20

Thanks,

David / dhildenb
