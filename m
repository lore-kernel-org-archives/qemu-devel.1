Received: from eggs.gnu.org ([2001:4830:134:3::10]:52205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eHWd2-0001V7-8s
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 10:07:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eHWcy-0007LE-Ba
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 10:07:56 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38452)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eHWcy-0007L0-0l
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 10:07:52 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAMF4mxx034432
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 10:07:49 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2eda0m6www-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 10:07:46 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 22 Nov 2017 15:07:39 -0000
References: <151136249244.558.6340327585120514778@bafd83ae6430>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 22 Nov 2017 16:07:35 +0100
MIME-Version: 1.0
In-Reply-To: <151136249244.558.6340327585120514778@bafd83ae6430>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <4e1f86e4-530c-9b51-2c2e-14827707cd9f@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] s390x fixes (post 2.11)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, cohuck@redhat.com, agraf@suse.de, thuth@redhat.com, pasic@linux.vnet.ibm.com, qemu-s390x@nongnu.org, rth@twiddle.net

Would have been good to have the qemu iotest before we merged
4afeffc8572f40d8844b946a30c00b10da4442b1 blockjob: do not allow coroutine double entry or entry-after-completion
and friends. 


On 11/22/2017
[...]
> -Image committed.
> +qemu-img: /tmp/qemu-test/src/block/block-backend.c:2088: blk_root_drained_end: Assertion `blk->quiesce_counter' failed.
> +./common.rc: line 61: 13620 Aborted                 (core dumped) ( exec "$QEMU_IMG_PROG" $QEMU_IMG_OPTIONS "$@" )
>  Reading from the backing file
[...]
