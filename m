Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AF2C04A6B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 21:00:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9252082F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 21:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9252082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33921 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNkiU-0002sw-Ee
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 17:00:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1hNkhj-0002Zk-6J
	for qemu-devel@nongnu.org; Mon, 06 May 2019 16:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.ibm.com>) id 1hNkhh-0000n1-8c
	for qemu-devel@nongnu.org; Mon, 06 May 2019 16:59:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.ibm.com>)
	id 1hNkhf-0000Ot-JE
	for qemu-devel@nongnu.org; Mon, 06 May 2019 16:59:17 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x46Kw5nw129745
	for <qemu-devel@nongnu.org>; Mon, 6 May 2019 16:58:12 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sau1nb9bp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 16:58:12 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.ibm.com>;
	Mon, 6 May 2019 21:58:11 +0100
Received: from b03cxnp08028.gho.boulder.ibm.com (9.17.130.20)
	by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Mon, 6 May 2019 21:58:08 +0100
Received: from b03ledav005.gho.boulder.ibm.com
	(b03ledav005.gho.boulder.ibm.com [9.17.130.236])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x46Kw58w52887642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Mon, 6 May 2019 20:58:05 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5387DBE051;
	Mon,  6 May 2019 20:58:05 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E068BE053;
	Mon,  6 May 2019 20:58:04 +0000 (GMT)
Received: from [9.85.216.218] (unknown [9.85.216.218])
	by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
	Mon,  6 May 2019 20:58:04 +0000 (GMT)
To: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>
References: <20190506171730.17556-1-cohuck@redhat.com>
From: Eric Farman <farman@linux.ibm.com>
Date: Mon, 6 May 2019 16:58:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190506171730.17556-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19050620-0004-0000-0000-0000150AD204
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011062; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01199563; UDB=6.00629333;
	IPR=6.00980439; 
	MB=3.00026760; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-06 20:58:09
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050620-0005-0000-0000-00008B8DDB7F
Message-Id: <0688a42a-4a7d-8aa4-7993-994c8f46193b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-06_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905060165
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH RFC] s390/css: handle CCW_FLAG_SKIP
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 5/6/19 1:17 PM, Cornelia Huck wrote:
> If a ccw has CCW_FLAG_SKIP set, and the command is of type
> read, read backwards, or sense, no data should be written
> to the guest for that command.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
> 
> Only extremely lightly tested (i.e., can boot a guest.)
> 
> ---
>   hw/s390x/css.c         | 22 ++++++++++++++++++----
>   include/hw/s390x/css.h |  1 +
>   2 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/s390x/css.c b/hw/s390x/css.c
> index 8fc9e35ba5d3..6ee31cc2e08f 100644
> --- a/hw/s390x/css.c
> +++ b/hw/s390x/css.c
> @@ -830,8 +830,12 @@ static int ccw_dstream_rw_noflags(CcwDataStream *cds, void *buff, int len,
>       if (op == CDS_OP_A) {
>           goto incr;
>       }
> -    ret = address_space_rw(&address_space_memory, cds->cda,
> -                           MEMTXATTRS_UNSPECIFIED, buff, len, op);
> +    if (!cds->do_skip) {
> +        ret = address_space_rw(&address_space_memory, cds->cda,
> +                               MEMTXATTRS_UNSPECIFIED, buff, len, op);
> +    } else {
> +        ret = 0;
> +    }
>       if (ret != MEMTX_OK) {
>           cds->flags |= CDS_F_STREAM_BROKEN;
>           return -EINVAL;
> @@ -928,8 +932,13 @@ static int ccw_dstream_rw_ida(CcwDataStream *cds, void *buff, int len,
>       do {
>           iter_len = MIN(len, cont_left);
>           if (op != CDS_OP_A) {
> -            ret = address_space_rw(&address_space_memory, cds->cda,
> -                                   MEMTXATTRS_UNSPECIFIED, buff, iter_len, op);
> +            if (!cds->do_skip) {
> +                ret = address_space_rw(&address_space_memory, cds->cda,
> +                                       MEMTXATTRS_UNSPECIFIED, buff, iter_len,
> +                                       op);
> +            } else {
> +                ret = 0;
> +            }
>               if (ret != MEMTX_OK) {
>                   /* assume inaccessible address */
>                   ret = -EINVAL; /* channel program check */
> @@ -968,6 +977,11 @@ void ccw_dstream_init(CcwDataStream *cds, CCW1 const *ccw, ORB const *orb)
>   
>       cds->count = ccw->count;
>       cds->cda_orig = ccw->cda;
> +    /* skip is only effective for read, read backwards, or sense commands */
> +    cds->do_skip = (ccw->flags & CCW_FLAG_SKIP) &&
> +        (ccw->cmd_code & CCW_CMD_BASIC_SENSE ||
> +         ccw->cmd_code & 0x02 /* read */ ||
> +         ccw->cmd_code & 0x0c /* read backwards */);

I wish so badly that these checks work, since it'd simplify the vfio-ccw 
code, but I don't think this lets you tell the difference between a READ 
(x02) and a NOP (x03) or any other control-type CCW.  Ditto 
read-backward versus TIC.  :-(

>       ccw_dstream_rewind(cds);
>       if (!(cds->flags & CDS_F_IDA)) {
>           cds->op_handler = ccw_dstream_rw_noflags;
> diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
> index aae19c427229..7cc183ef4366 100644
> --- a/include/hw/s390x/css.h
> +++ b/include/hw/s390x/css.h
> @@ -97,6 +97,7 @@ typedef struct CcwDataStream {
>       int (*op_handler)(struct CcwDataStream *cds, void *buff, int len,
>                         CcwDataStreamOp op);
>       hwaddr cda;
> +    bool do_skip;
>   } CcwDataStream;
>   
>   /*
> 


