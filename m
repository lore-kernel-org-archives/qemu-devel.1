Received: from eggs.gnu.org ([2001:4830:134:3::10]:37877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sebott@linux.vnet.ibm.com>) id 1cr1HS-0002A3-Ia
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sebott@linux.vnet.ibm.com>) id 1cr1HP-0004Lz-FJ
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:51:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34632
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sebott@linux.vnet.ibm.com>)
	id 1cr1HP-0004KZ-9h
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 07:51:47 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2NBo8L6125802
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 07:51:45 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 29c4qw9sc8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 07:51:45 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <sebott@linux.vnet.ibm.com>;
	Thu, 23 Mar 2017 11:51:43 -0000
Date: Thu, 23 Mar 2017 12:51:40 +0100 (CET)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
In-Reply-To: <20170317031743.40128-2-bjsdjshi@linux.vnet.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
	<20170317031743.40128-2-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <alpine.LFD.2.20.1703231249220.3020@schleppi>
Subject: Re: [Qemu-devel] [PATCH v4 01/16] s390: cio: introduce
 cio_cancel_halt_clear
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, Cornelia Huck <cornelia.huck@de.ibm.com>, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>

On Fri, 17 Mar 2017, Dong Jia Shi wrote:
> For future code reuse purpose, this decouples the cio code with
> the ccw device specific parts from ccw_device_cancel_halt_clear,
> and makes a new common I/O interface named cio_cancel_halt_clear.
> 
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
> Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
[...]
> +/**
> + * cio_cancel_halt_clear - Cancel running I/O by performing cancel, halt
> + * and clear ordinally if subchannel is valid.
> + * @sch: subchannel on which to perform the cancel_halt_clear operation
> + * @iretry: the number of the times remained to retry the next operation
> + *
> + * This should be called repeatedly since halt/clear are asynchronous
> + * operations. We do one try with cio_cancel, two tries with cio_halt,
                                                 ^
                                                 three

Acked-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
