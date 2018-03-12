Received: from eggs.gnu.org ([2001:4830:134:3::10]:60644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1evVth-0008Vr-Pm
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:26:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.vnet.ibm.com>) id 1evVtd-0000HK-PT
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:26:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.vnet.ibm.com>)
	id 1evVtd-0000H0-Ek
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 18:26:21 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2CMOMG5109451
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:26:20 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gp1b21xgk-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 18:26:19 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.vnet.ibm.com>;
	Mon, 12 Mar 2018 16:26:18 -0600
References: <20180309182202.31206-1-farosas@linux.vnet.ibm.com>
	<20180309182202.31206-6-farosas@linux.vnet.ibm.com>
	<85241da1-47d9-4fee-62d6-e8c6a6c58944@redhat.com>
From: Fabiano Rosas <farosas@linux.vnet.ibm.com>
Date: Mon, 12 Mar 2018 19:26:13 -0300
MIME-Version: 1.0
In-Reply-To: <85241da1-47d9-4fee-62d6-e8c6a6c58944@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <1d38c1c9-ecc5-8e69-1d7f-6d5cb685f02a@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] include/block/block_int: Document
 protocol related functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

On 2018-03-12 10:50, Max Reitz wrote:

> A driver doesn't need to be a protocol driver for this, and technically
> a protocol driver doesn't need to set this.  Maybe we should rename it
> to "filename_prefix"...?

Yes, something that is closer to the filename string and farther from
the notion of what defines a protocol would be good. I see "protocol
prefix" mentioned in block.c, maybe that would be a good middle
ground.

Cheers
