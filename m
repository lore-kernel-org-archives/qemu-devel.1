Received: from eggs.gnu.org ([2001:4830:134:3::10]:51412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dXfQZ-0004xH-CK
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 23:13:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dXfQU-0008TZ-Da
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 23:13:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37881
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dXfQU-0008TE-8U
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 23:13:26 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6J38gJm018644
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 23:13:24 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2bskq6mugr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 23:13:24 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 18 Jul 2017 23:13:24 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
	[9.57.199.108])
	by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	v6J3DLYI21495940
	for <qemu-devel@nongnu.org>; Wed, 19 Jul 2017 03:13:21 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B182FB2046
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 23:10:50 -0400 (EDT)
Received: from [9.197.255.203] (unknown [9.197.255.203])
	by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP id 1EC0DB204E
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 23:10:49 -0400 (EDT)
References: <20170718142455.32676-1-cohuck@redhat.com>
	<20170718142455.32676-9-cohuck@redhat.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Wed, 19 Jul 2017 11:13:18 +0800
MIME-Version: 1.0
In-Reply-To: <20170718142455.32676-9-cohuck@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <b78375d1-7ffa-8195-946a-e123e260e831@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v2 8/9] s390x/kvm: msi route fixup for
 non-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I think moving the new code on the top of this function would make it=20
more readable.


=D4=DA 2017/7/18 =CF=C2=CE=E710:24, Cornelia Huck =D0=B4=B5=C0:
> +    } else {
> +        DPRINTF("fixup_msi_route on non-pci machine?!\n");
> +        return -ENODEV;
> +    }
