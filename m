Received: from eggs.gnu.org ([2001:4830:134:3::10]:50452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1f70dM-0003zG-OH
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:29:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1f70dJ-00058n-J3
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:29:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48216
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1f70dJ-00057y-5D
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:29:01 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3DFQqPE112284
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 11:29:00 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2haxs99qgn-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 11:28:58 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Fri, 13 Apr 2018 16:28:55 +0100
References: <1523629847-22369-1-git-send-email-thuth@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Fri, 13 Apr 2018 17:28:51 +0200
MIME-Version: 1.0
In-Reply-To: <1523629847-22369-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <df1a9534-c1ca-972b-91a6-359685a671df@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH for-2.13] pc-bios/s390-ccw: size_t should
 be unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org



On 04/13/2018 04:30 PM, Thomas Huth wrote:
> "size_t" should be an unsigned type - the signed counterpart is called
> "ssize_t" in the C standard instead. Thus we should also use this

The first sentence sounds like ssize_t is too a type defined by some
C standard. Is it or does ssize_t come form somewhere else? I find negative
size a little difficult conceptually.

> convention in the s390-ccw firmware to avoid confusion. I checked the
> sources, and apart from one spot in libc.c (which now uses ssize_t with
> this patch), the code should all be fine with this change.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1753437
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---

This is certainly an improvement over the confusing signed size_t, so:

Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>

BTW The stuff behind the buglink is a bit misleading. The description
states the problem as can't escape loop (IMHO) and the  bug
status say 'confirmed'.

What actually happened is that it turned out the problem initially reported,
was not existent. Yet the bug report helped us find another problem:
confusing names.

To complicate understanding even further, the comments on the bug
only contain this realization hidden behind a link.

It probably does not matter though.
