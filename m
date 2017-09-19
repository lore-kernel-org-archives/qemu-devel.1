Received: from eggs.gnu.org ([2001:4830:134:3::10]:54451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1duLvj-0006P6-Dd
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1duLve-0000rb-VF
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:03:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1duLve-0000qE-MF
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 13:03:22 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8JGwhAZ068406
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 13:03:20 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d35ndp5af-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 13:03:19 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 19 Sep 2017 18:03:17 +0100
References: <20170919164337.18555-1-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 19 Sep 2017 19:03:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170919164337.18555-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <0f9f4972-c7eb-1af5-af78-141cbbd41876@de.ibm.com>
Subject: Re: [Qemu-devel] [PULL v2 00/38] various s390x patches (+some fixes)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, david@redhat.com



On 09/19/2017 06:42 PM, Cornelia Huck wrote:
> The following changes since commit 7ec6a364916c0d1eba01128481e503a550a2b466:
> 
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-09-19 15:44:07 +0100)
> 
> are available in the git repository at:
> 
>   git://github.com/cohuck/qemu tags/s390x-20170919-v2
> 
> for you to fetch changes up to 9d1c4449218d8a2e98a6a11688b09b9137f25c1c:
> 
>   MAINTAINERS/s390x: add terminal3270.c (2017-09-19 18:31:32 +0200)
> 
> ----------------------------------------------------------------
> Assorted s390x patches:
> - introduce virtio-gpu-ccw, with virtio-gpu endian fixes
> - lots of cleanup in the s390x code
> - make device_add work for s390x cpus
> - enable seccomp on s390x
> - an ivshmem endian fix
> - set the reserved DHCP client architecture id for netboot
> - fixes in the css and pci support
> 
> ----------------------------------------------------------------

What happened to the indirect data access patches from Halil? Last time I checked
you said "applied thanks"?
