Received: from eggs.gnu.org ([2001:4830:134:3::10]:43077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fbKY0-0007RH-Tm
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fbKXx-0003f8-SB
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:48:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58318
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fbKXx-0003e4-NP
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 02:48:49 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w666mfR3104982
	for <qemu-devel@nongnu.org>; Fri, 6 Jul 2018 02:48:49 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2k23fs0058-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 02:48:48 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 6 Jul 2018 07:48:47 +0100
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-8-git-send-email-jjherne@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 6 Jul 2018 08:48:42 +0200
MIME-Version: 1.0
In-Reply-To: <1530811543-6881-8-git-send-email-jjherne@linux.ibm.com>
Content-Language: en-US
Message-Id: <542cbdbb-9a60-713f-0b7b-e8812828cee4@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 07/15] s390-bios: Decouple channel i/o logic
 from virtio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com



On 07/05/2018 07:25 PM, Jason J. Herne wrote:
> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
> 
> Create a separate library for channel i/o related code. This decouples
> channel i/o operations from virtio and allows us to make use of them for
> the real dasd boot path.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/Makefile        |  2 +-
>  pc-bios/s390-ccw/cio.c           | 41 ++++++++++++++++++++++++++++++++++++++++

you must also touch netboot.mak to get the necessary things into the netboot image
(it is only build when you do the git submodule thing)
