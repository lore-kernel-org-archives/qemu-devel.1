Received: from eggs.gnu.org ([2001:4830:134:3::10]:54229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dx5Ag-000781-QF
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 01:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zyimin@linux.vnet.ibm.com>) id 1dx5Ab-0003HP-Ti
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 01:46:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47112)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zyimin@linux.vnet.ibm.com>)
	id 1dx5Ab-0003Gi-Kq
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 01:46:05 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8R5im5M035585
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 01:46:01 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d848h4qbr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 01:46:01 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <zyimin@linux.vnet.ibm.com>;
	Tue, 26 Sep 2017 23:46:00 -0600
References: <20170926133624.155394-1-borntraeger@de.ibm.com>
	<20170926133624.155394-2-borntraeger@de.ibm.com>
From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Date: Wed, 27 Sep 2017 13:45:54 +0800
MIME-Version: 1.0
In-Reply-To: <20170926133624.155394-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=gbk; format=flowed
Message-Id: <7134b571-41dd-97c8-85b8-fb623babb016@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/2] s390x/ais: enable ais when
 migration is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>



=D4=DA 2017/9/26 =CF=C2=CE=E79:36, Christian Borntraeger =D0=B4=B5=C0:
> @@ -557,6 +557,12 @@ static void kvm_s390_flic_realize(DeviceState *dev=
, Error **errp)
>       test_attr.group =3D KVM_DEV_FLIC_CLEAR_IO_IRQ;
>       flic_state->clear_io_supported =3D !ioctl(flic_state->fd,
>                                               KVM_HAS_DEVICE_ATTR, test=
_attr);
> +    /* try enable the AIS facility */
> +    test_attr.group =3D KVM_DEV_FLIC_AISM_ALL;
> +    if (!ioctl(flic_state->fd, KVM_HAS_DEVICE_ATTR, test_attr)) {
> +            kvm_vm_enable_cap(kvm_state, KVM_CAP_S390_AIS, 0);
Is there an indention error?
Except this, the code LGTM.
> +    }
> +
>       return;
