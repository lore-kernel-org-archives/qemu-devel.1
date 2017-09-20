Received: from eggs.gnu.org ([2001:4830:134:3::10]:58546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1duYkw-0005Un-NJ
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1duYkr-00009g-OK
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:45:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54348
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1duYkr-00008u-Iv
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 02:45:05 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8K6iDUG055746
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 02:45:05 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d3cpfw2p6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 02:45:04 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 20 Sep 2017 02:45:04 -0400
Date: Wed, 20 Sep 2017 14:44:59 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170919182745.90280-1-pasic@linux.vnet.ibm.com>
	<20170919182745.90280-2-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170919182745.90280-2-pasic@linux.vnet.ibm.com>
Message-Id: <20170920064459.GF11080@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/5] s390x/css: introduce css data stream
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

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-19 20:27:41 +0200]:

[...]

> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index 0653d3c9be..078356e94c 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -75,6 +75,29 @@ typedef struct CMBE {
>      uint32_t reserved[7];
>  } QEMU_PACKED CMBE;
> 
> +typedef enum CcwDataStreamOp {
> +    CDS_OP_R = 0, /* read, false when used as is_write */
> +    CDS_OP_W = 1, /* write, true when used as is_write */
> +    CDS_OP_A = 2  /* advance, should not be used as is_write */
Looks good to me.

> +} CcwDataStreamOp;
> +
> 

[...]

-- 
Dong Jia Shi
