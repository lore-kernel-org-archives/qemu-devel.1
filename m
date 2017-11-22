Received: from eggs.gnu.org ([2001:4830:134:3::10]:39787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eHVss-0007eD-S0
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:20:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1eHVsp-0002j7-D3
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:20:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1eHVsp-0002iN-4F
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 09:20:11 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAMEJxM1134800
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 09:20:08 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ed9bbp79m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 09:20:07 -0500
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Wed, 22 Nov 2017 14:20:01 -0000
References: <20171108165422.46267-1-pasic@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 22 Nov 2017 15:19:57 +0100
MIME-Version: 1.0
In-Reply-To: <20171108165422.46267-1-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <458f5d77-54d5-4c9c-7930-0ade34c52597@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 0/3] tests for CCW IDA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

ping

On 11/08/2017 05:54 PM, Halil Pasic wrote:
> I've keept the title althogh the scope shifted a bit: it's
> more about introducing ccw-testdev than about IDA. The goal
> is to facilitate testing the virtual channel subsystem
> implementation, and the ccw interpretation.
> 
> The first patch is the interesting one. See it's cover letter
> for details. The RFC is about discussing some technical issues
> with this patch.
> 
> The other two patches are an out of source kernel module which
> is basically only there so you can try out the first patch. The
> tests there should probably be ported to something else. I don't
> know what: maybe kvm-unit-tests, maybe qtest+libqos, or maybe some
> bios based test image. We still have to figure out that. 
> 
> Halil Pasic (3):
>   s390x/ccs: add ccw-testdev emulated device
>   ccw-tester: a tester device for ccw I/O
>   ccw-tester: add tic test
> 
>  hw/misc/Makefile.objs |   1 +
>  hw/misc/ccw-testdev.c | 284 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  hw/misc/ccw-testdev.h |  18 ++++
>  3 files changed, 303 insertions(+)
>  create mode 100644 hw/misc/ccw-testdev.c
>  create mode 100644 hw/misc/ccw-testdev.h
> 
