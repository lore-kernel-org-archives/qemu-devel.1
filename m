Received: from eggs.gnu.org ([2001:4830:134:3::10]:50674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dwJqZ-0008Sj-MW
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 23:14:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1dwJqU-0006pX-M6
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 23:14:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51398
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1dwJqU-0006oq-G9
	for qemu-devel@nongnu.org; Sun, 24 Sep 2017 23:14:10 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8P3DadT146357
	for <qemu-devel@nongnu.org>; Sun, 24 Sep 2017 23:14:07 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d6p5dfrbu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 24 Sep 2017 23:14:06 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Sun, 24 Sep 2017 23:14:06 -0400
Date: Mon, 25 Sep 2017 11:14:00 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170921180841.24490-1-pasic@linux.vnet.ibm.com>
	<20170921180841.24490-6-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170921180841.24490-6-pasic@linux.vnet.ibm.com>
Message-Id: <20170925031400.GP11080@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 5/5] s390x/css: support ccw IDA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-21 20:08:41 +0200]:

> Let's add indirect data addressing support for our virtual channel
> subsystem. This implementation does not bother with any kind of
> prefetching. We simply step through the IDAL on demand.
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  hw/s390x/css.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 113 insertions(+), 1 deletion(-)
> 

LGTM:
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

[...]

-- 
Dong Jia Shi
