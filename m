Received: from eggs.gnu.org ([2001:4830:134:3::10]:50143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1e4kPy-0008Ap-JU
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:13:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1e4kPt-0003WU-Kw
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:13:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1e4kPt-0003U5-CC
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 05:13:33 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9I99VXV082117
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 05:13:26 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dp1867mer-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 05:13:25 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 18 Oct 2017 05:13:24 -0400
Date: Wed, 18 Oct 2017 17:13:20 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20171017140453.51099-1-pasic@linux.vnet.ibm.com>
	<20171017140453.51099-3-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171017140453.51099-3-pasic@linux.vnet.ibm.com>
Message-Id: <20171018091320.GB5150@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/7] s390x/css: IO instr handler ending
 control
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-10-17 16:04:48 +0200]:

[...]

> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index 69b374730e..7e0dbd162f 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -99,6 +99,22 @@ typedef struct CcwDataStream {
>      hwaddr cda;
>  } CcwDataStream;
> 
> +/*
> + * IO instructions conclude according this. Currently we have only
> + * cc codes. Valid values are 0,1,2,3 and the generic semantic for
> + * IO instructions is described briefly. For more details consult the PoP.
> + */
> +typedef enum IOInstEnding {
> +    /* produced expected result */
> +    IOINST_CC_EXPECTED = 0,
> +    /* status conditions were present or produced alternate result */
> +    IOINST_CC_STATUS_PRESENT = 1,
> +    /* inst. ineffective because busy with previously initiated function */
> +    IOINST_CC_BUSY = 2,
> +    /* inst. ineffective because not operational */
> +    IOINST_CC_NOT_OPERATIONAL = 3
> +} IOInstEnding;
> +
>  typedef struct SubchDev SubchDev;
>  struct SubchDev {
>      /* channel-subsystem related things: */
> -- 
> 2.13.5
> 

With what has been pointed out by Conny and Thomas addressed:
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

-- 
Dong Jia Shi
