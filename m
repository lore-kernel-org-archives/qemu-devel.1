Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A65C468C1
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 04:26:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F5B20820
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 04:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F5B20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40368 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haBtN-0001Rm-G8
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 00:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56255)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sandipan@linux.ibm.com>) id 1haBsY-0000Jw-Mg
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 00:25:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sandipan@linux.ibm.com>) id 1haBsX-00072u-Pq
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 00:25:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50218
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sandipan@linux.ibm.com>)
 id 1haBsX-0006yQ-DB
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 00:25:53 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5A4N6kv136698
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 00:25:45 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2t1fcm9ghe-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 00:25:44 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sandipan@linux.ibm.com>;
 Mon, 10 Jun 2019 05:25:43 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 10 Jun 2019 05:25:40 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5A4PdxV36044952
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 10 Jun 2019 04:25:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 03C855204E;
 Mon, 10 Jun 2019 04:25:39 +0000 (GMT)
Received: from [9.124.35.223] (unknown [9.124.35.223])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 60F4652050;
 Mon, 10 Jun 2019 04:25:38 +0000 (GMT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190607132521.9637-1-peter.maydell@linaro.org>
From: Sandipan Das <sandipan@linux.ibm.com>
Date: Mon, 10 Jun 2019 09:55:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190607132521.9637-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061004-0028-0000-0000-00000378D42E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061004-0029-0000-0000-00002438BD49
Message-Id: <5eec6321-a6ac-0114-3d21-d45bd806b26b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-10_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906100029
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [RISU PATCH] risu: Include <sys/user.h> on ppc64
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 07/06/19 6:55 PM, Peter Maydell wrote:
> To build the C parts of risu for ppc64le with recent glibc/kernel
> headers, we need to include sys/user.h to avoid a compile error,
> because sys/ucontext.h defines a struct which includes a pointer
> to 'struct pt_regs' but does not provide a definition of that struct.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

LGTM.

Reviewed-by: Sandipan Das <sandipan@linux.ibm.com>

> ---
> I need this to be able to do the ppc64le cross-build on my
> Ubuntu Bionic x86-64 system.
> 
>  risu_ppc64.c         | 2 ++
>  risu_reginfo_ppc64.c | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/risu_ppc64.c b/risu_ppc64.c
> index 83f8d1f..a3028f7 100644
> --- a/risu_ppc64.c
> +++ b/risu_ppc64.c
> @@ -11,6 +11,8 @@
>   *     based on Peter Maydell's risu_arm.c
>   *****************************************************************************/
> 
> +#include <sys/user.h>
> +
>  #include "risu.h"
> 
>  void advance_pc(void *vuc)
> diff --git a/risu_reginfo_ppc64.c b/risu_reginfo_ppc64.c
> index f9d2f0d..071c951 100644
> --- a/risu_reginfo_ppc64.c
> +++ b/risu_reginfo_ppc64.c
> @@ -16,6 +16,7 @@
>  #include <string.h>
>  #include <math.h>
>  #include <stdlib.h>
> +#include <sys/user.h>
> 
>  #include "risu.h"
>  #include "risu_reginfo_ppc64.h"
> 


