Received: from eggs.gnu.org ([2001:4830:134:3::10]:35061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1du8Ad-0007OZ-H5
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 22:21:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1du8AZ-0002j0-F4
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 22:21:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1du8AZ-0002iA-6O
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 22:21:51 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8J2J45C053517
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 22:21:49 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d2m894b98-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 22:21:49 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Mon, 18 Sep 2017 22:21:47 -0400
Date: Tue, 19 Sep 2017 10:21:42 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170913115029.47626-1-pasic@linux.vnet.ibm.com>
	<20170913115029.47626-2-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913115029.47626-2-pasic@linux.vnet.ibm.com>
Message-Id: <20170919022142.GB5274@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/4] s390x/css: introduce css data stream
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

* Halil Pasic <pasic@linux.vnet.ibm.com> [2017-09-13 13:50:26 +0200]:

[...]

> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index 0653d3c9be..79acaf99b7 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -75,6 +75,29 @@ typedef struct CMBE {
>      uint32_t reserved[7];
>  } QEMU_PACKED CMBE;
> 
> +typedef enum CcwDataStreamOp {
> +    CDS_OP_R = 0,
> +    CDS_OP_W = 1,
> +    CDS_OP_A = 2

Nit:

typedef enum CcwDataStreamOp {
    CDS_OP_R, /* read */
    CDS_OP_W, /* write */
    CDS_OP_A  /* advance */
} CcwDataStreamOp;

(I just keep translating 'A' as append in my mind...)

> +} CcwDataStreamOp;
> +
[...]

> +static inline uint16_t ccw_dstream_avail(CcwDataStream *cds)
> +{
> +    return ccw_dstream_good(cds) ?  ccw_dstream_residual_count(cds) : 0;
                                     ^^
Nit.

> +}

[...]

With or w/o responses the nit picks:
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

-- 
Dong Jia Shi
