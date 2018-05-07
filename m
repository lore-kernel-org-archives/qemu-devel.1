Received: from eggs.gnu.org ([2001:4830:134:3::10]:40513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fFcTO-00010n-UW
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1fFcTK-0003vk-0p
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:30:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36566)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1fFcTJ-0003uH-Me
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:30:17 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w479TMRp056851
	for <qemu-devel@nongnu.org>; Mon, 7 May 2018 05:30:13 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2htkw80sj4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 05:30:13 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Mon, 7 May 2018 10:30:02 +0100
References: <20180507033214.19219-1-zyimin@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 7 May 2018 11:29:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180507033214.19219-1-zyimin@linux.ibm.com>
Content-Language: en-US
Message-Id: <df015c61-0dde-da33-86eb-31abbd6ec805@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/1] Bug: Sandbox: libvirt breakdowns qemu
 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.ibm.com>, qemu-devel@nongnu.org
Cc: jtomko@redhat.com, jferlan@redhat.com, berrange@redhat.com, otubo@redhat.com, fiuczy@linux.ibm.com, libvir-list@redhat.com

On 05/07/2018 05:32 AM, Yi Min Zhao wrote:
> 1. Problem Description
> ======================
> If QEMU is built without seccomp support, 'elevatorprivileges' remains compiled.
> This option of sandbox is treated as an indication for seccomp blacklist support
> in libvirt. This behavior is introduced by the libvirt commits 31ca6a5 and
> 3527f9d. It would make libvirt build wrong QEMU cmdline, and then the guest
> startup would fail.

Adding libvirt list.

This would still fail with older QEMUs, so the question is if we should also OR instead
change something in libvirt.

> 
> 2. Libvirt Log
> ==============
> qemu-system-s390x: -sandbox on,obsolete=deny,elevateprivileges=deny,spawn=deny,\
> resourcecontrol=deny: seccomp support is disabled
> 
> 3. Fixup
> ========
> Wrap the options except 'enable' for qemu_sandbox_opts by CONFIG_SECCOMP.
> 
> Yi Min Zhao (1):
>   sandbox: avoid to compile options if CONFIG_SECCOMP undefined
> 
>  vl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
