Received: from eggs.gnu.org ([2001:4830:134:3::10]:34335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1f81he-0008So-4t
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:49:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.vnet.ibm.com>) id 1f81hb-0002SB-3B
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:49:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41924
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.vnet.ibm.com>)
	id 1f81ha-0002Rw-TR
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 06:49:39 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3GAnYxv094278
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 06:49:38 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hcs0mv86r-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 06:49:37 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.vnet.ibm.com>;
	Mon, 16 Apr 2018 11:49:35 +0100
References: <1523864720-4680-1-git-send-email-thuth@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 16 Apr 2018 12:49:34 +0200
MIME-Version: 1.0
In-Reply-To: <1523864720-4680-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <5ae53b81-258c-eeca-578f-e4e03205c604@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.13] pc-bios/s390-ccw: size_t
 should be unsigned
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>



On 04/16/2018 09:45 AM, Thomas Huth wrote:
> "size_t" should be an unsigned type according to the C standard.
> Thus we should also use this convention in the s390-ccw firmware to avoid
> confusion. I checked the sources, and apart from one spot in libc.c, the
> code should all be fine with this change.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1753437
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
