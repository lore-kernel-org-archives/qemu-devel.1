Received: from eggs.gnu.org ([2001:4830:134:3::10]:34881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dqGn7-0002mX-4Q
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1dqGn2-0005c5-CJ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:45:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1dqGn1-0005ba-TY
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:45:36 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v88Ahue7069408
	for <qemu-devel@nongnu.org>; Fri, 8 Sep 2017 06:45:33 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cun4wwa32-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 06:45:31 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 8 Sep 2017 11:45:29 +0100
References: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 8 Sep 2017 12:45:25 +0200
MIME-Version: 1.0
In-Reply-To: <20170905111645.18068-1-pasic@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <22830b0b-d05d-22de-271c-f0aa9bca6b64@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] add CCW indirect data access support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org



On 09/05/2017 01:16 PM, Halil Pasic wrote:
> Abstract 
> --------
> 
> The objective of this series is introducing CCW IDA (indirect data
> access) support to our virtual channel subsystem implementation. Briefly
> CCW IDA can be thought of as a kind of a scatter gather support for a
> single CCW. If certain flags are set, the cda is to be interpreted as an
> address to a list which in turn holds further addresses designating the
> actual data.  Thus the scheme which we are currently using for accessing
> CCW payload does not work in general case. Currently there is no
> immediate need for proper IDA handling (no use case), but since it IDA is
> a non-optional part of the architecture, the only way towards AR
> compliance is actually implementing IDA.
> 

[..]

The discussion seems to have settled down quite a bit. Since there weren't
many complaints, I would like to opt for a v2 fixing the things pointed out
during the review early next week (I was thinking Tuesday maybe some late birds
are going to join in).

@Connie 
========

Does that sound reasonable or would you like more time for v1?

What do you think, would it make more sense to omit or to keep the testing
stuff for v2 (I mean patch 5 and the kernel module in the cover letter)?

You probably haven't found the time to look at have a glance at "s390x/css: drop
data-check in interpretation" (http://patchwork.ozlabs.org/patch/810995/). We
have said it would make some things more straight forward here, and I could
drop that ugly TODO comment. I think it's quite straight-forward, and I would
not mind having a decision on it before v2 or putting it as preparation into
v2. What do you prefer?

Regards,
Halil
