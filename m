Received: from eggs.gnu.org ([2001:4830:134:3::10]:40921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fWKxi-0005yh-MO
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:14:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fWKxf-0004oL-GH
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:14:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46480)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fWKxf-0004o1-4W
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:14:43 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w5MCDoWD029364
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 08:14:40 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jrx6008v9-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 08:14:40 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 22 Jun 2018 13:14:38 +0100
References: <20180622102928.173420-1-borntraeger@de.ibm.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Fri, 22 Jun 2018 14:14:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180622102928.173420-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1a6509e9-4995-58b1-6fa0-4552c65bbe43@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4] s390/ipl: fix ipl with -no-reboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Alexander Graf <agraf@suse.de>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>



On 06/22/2018 12:29 PM, Christian Borntraeger wrote:
> kexec/kdump as well as the bootloader use a subcode of diagnose 308
> that is supposed to reset the I/O subsystem but not comprise a full
> "reboot". With the latest refactoring this is now broken when
> -no-reboot is used or when libvirt acts on a reboot QMP event, for
> example a virt-install from iso images.
> We need to mark these "subsystem reset" as special.
> 
> Fixes: a30fb811cbe9 (s390x: refactor reset/reipl handling)
> Signed-off-by: Christian Borntraeger<borntraeger@de.ibm.com>
> Reviewed-by: David Hildenbrand<david@redhat.com>

Looks sane to me, but I did not dig too deep and this
ain't code I'm particularly familiar with.

Regards,
Halil
