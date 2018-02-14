Received: from eggs.gnu.org ([2001:4830:134:3::10]:56095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1elxcu-0000xG-9d
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:01:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1elxc1-0006wN-0Q
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:01:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43360
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1elxc0-0006s0-O8
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:00:40 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1EDxbfc056726
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 09:00:37 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g4nw69xbg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 09:00:36 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Wed, 14 Feb 2018 14:00:34 -0000
References: <1518542328-25741-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180214115725.34ba0008.cohuck@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Wed, 14 Feb 2018 15:00:29 +0100
MIME-Version: 1.0
In-Reply-To: <20180214115725.34ba0008.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <2b5ab665-97eb-1d33-ada5-63b57fa1f855@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCHv2 0/3] add query-cpu-fast and related s390
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel@nongnu.org, agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, david@redhat.com, dgilbert@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com

On 14.02.2018 11:57, Cornelia Huck wrote:
[...]
> 
> How shall we proceed with this series? Patch 3 depends upon patch 1, so
> I think it makes sense to merge this in one go.
> 
> I can give my R-b on patch 1 and Someone(tm) can merge this, or I can
> take the whole series through the s390 tree (with some further
> reviews/acks on patches 2/3).
> 
Let's wait for the outstanding reviews (QAPI/HMP). If no major concerns
are voiced, the series could go in via the s390 tree.
As David H. pointed out, I've missed his r-b on patch 1, so you could
add that along with Christian's if no v3 is required.

-- 
Regards,
 Viktor Mihajlovski
