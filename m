Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BAFC4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 18:15:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E02D820724
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 18:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E02D820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEzh8-0002qL-W4
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 14:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43871)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imbrenda@linux.ibm.com>) id 1jEzgJ-0002Gt-Vs
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 14:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imbrenda@linux.ibm.com>) id 1jEzgI-0005jI-RH
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 14:14:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2732)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imbrenda@linux.ibm.com>)
 id 1jEzgI-0005ij-Ic
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 14:14:10 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02JI2rHv069070
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 14:14:09 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yu8aepd2n-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 14:14:08 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <imbrenda@linux.ibm.com>;
 Thu, 19 Mar 2020 18:14:06 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 19 Mar 2020 18:14:02 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
 [9.149.105.62])
 by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 02JIE1WY29491704
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 19 Mar 2020 18:14:01 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6878CAE045;
 Thu, 19 Mar 2020 18:14:01 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0C96EAE04D;
 Thu, 19 Mar 2020 18:14:01 +0000 (GMT)
Received: from p-imbrenda (unknown [9.145.97.199])
 by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 19 Mar 2020 18:14:00 +0000 (GMT)
Date: Thu, 19 Mar 2020 13:42:33 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v10 01/16] s390x: Move diagnose 308 subcodes and rcs
 into ipl.h
In-Reply-To: <20200318143047.2335-2-frankja@linux.ibm.com>
References: <20200318143047.2335-1-frankja@linux.ibm.com>
 <20200318143047.2335-2-frankja@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20031918-0028-0000-0000-000003E7B4F9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031918-0029-0000-0000-000024AD1141
Message-Id: <20200319134233.238a60fe@p-imbrenda>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-19_06:2020-03-19,
 2020-03-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003190074
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 18 Mar 2020 10:30:32 -0400
Janosch Frank <frankja@linux.ibm.com> wrote:

> They are part of the IPL process, so let's put them into the ipl
> header.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>


Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>


> ---
>  hw/s390x/ipl.h      | 11 +++++++++++
>  target/s390x/diag.c | 11 -----------
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/s390x/ipl.h b/hw/s390x/ipl.h
> index 3e44abe1c651d8a0..a5665e6bfde2e8cf 100644
> --- a/hw/s390x/ipl.h
> +++ b/hw/s390x/ipl.h
> @@ -159,6 +159,17 @@ struct S390IPLState {
>  typedef struct S390IPLState S390IPLState;
>  QEMU_BUILD_BUG_MSG(offsetof(S390IPLState, iplb) & 3, "alignment of
> iplb wrong"); 
> +#define DIAG_308_RC_OK              0x0001
> +#define DIAG_308_RC_NO_CONF         0x0102
> +#define DIAG_308_RC_INVALID         0x0402
> +
> +#define DIAG308_RESET_MOD_CLR       0
> +#define DIAG308_RESET_LOAD_NORM     1
> +#define DIAG308_LOAD_CLEAR          3
> +#define DIAG308_LOAD_NORMAL_DUMP    4
> +#define DIAG308_SET                 5
> +#define DIAG308_STORE               6
> +
>  #define S390_IPL_TYPE_FCP 0x00
>  #define S390_IPL_TYPE_CCW 0x02
>  #define S390_IPL_TYPE_QEMU_SCSI 0xff
> diff --git a/target/s390x/diag.c b/target/s390x/diag.c
> index 54e5670b3fd6d960..8aba6341f94848e1 100644
> --- a/target/s390x/diag.c
> +++ b/target/s390x/diag.c
> @@ -49,17 +49,6 @@ int handle_diag_288(CPUS390XState *env, uint64_t
> r1, uint64_t r3) return diag288_class->handle_timer(diag288, func,
> timeout); }
>  
> -#define DIAG_308_RC_OK              0x0001
> -#define DIAG_308_RC_NO_CONF         0x0102
> -#define DIAG_308_RC_INVALID         0x0402
> -
> -#define DIAG308_RESET_MOD_CLR       0
> -#define DIAG308_RESET_LOAD_NORM     1
> -#define DIAG308_LOAD_CLEAR          3
> -#define DIAG308_LOAD_NORMAL_DUMP    4
> -#define DIAG308_SET                 5
> -#define DIAG308_STORE               6
> -
>  static int diag308_parm_check(CPUS390XState *env, uint64_t r1,
> uint64_t addr, uintptr_t ra, bool write)
>  {


