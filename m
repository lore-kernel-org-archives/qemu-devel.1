Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B1CC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 14:24:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC79B206D5
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 14:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC79B206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWKyO-0003V6-1r
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 10:24:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1jWKxl-00031S-3T
 for qemu-devel@nongnu.org; Wed, 06 May 2020 10:23:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20229)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sbhat@linux.ibm.com>)
 id 1jWKxi-00048K-SG
 for qemu-devel@nongnu.org; Wed, 06 May 2020 10:23:52 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 046EARZ0123804
 for <qemu-devel@nongnu.org>; Wed, 6 May 2020 10:23:48 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30sp8ky4gv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 10:23:47 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 046EJLRw152846
 for <qemu-devel@nongnu.org>; Wed, 6 May 2020 10:23:40 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com
 [169.51.49.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30sp8ky494-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2020 10:23:40 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
 by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 046EKM42001607;
 Wed, 6 May 2020 14:23:28 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by ppma03ams.nl.ibm.com with ESMTP id 30s0g5sc5s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 06 May 2020 14:23:28 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 046ENQTt63176752
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 6 May 2020 14:23:26 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4B12C11C05B;
 Wed,  6 May 2020 14:23:26 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6C65F11C04A;
 Wed,  6 May 2020 14:23:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.71.62])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  6 May 2020 14:23:25 +0000 (GMT)
Subject: Re: [PATCH v2 01/10] nvdimm: Plug memory leak in uuid property setter
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200505101908.6207-1-armbru@redhat.com>
 <20200505101908.6207-2-armbru@redhat.com>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Message-ID: <9763e386-fcb2-e9ad-bd5e-ae2c2142c8a4@linux.ibm.com>
Date: Wed, 6 May 2020 19:53:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20200505101908.6207-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-05-06_06:2020-05-05,
 2020-05-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0
 malwarescore=0 suspectscore=2 priorityscore=1501 spamscore=0 clxscore=1011
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060108
Received-SPF: pass client-ip=148.163.158.5; envelope-from=sbhat@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 10:23:48
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/05/2020 03:48 PM, Markus Armbruster wrote:
> nvdimm_set_uuid() leaks memory on qemu_uuid_parse() failure.  Fix
> that.
>
> Fixes: 6c5627bb24dcd68c997857a8b671617333b1289f
> Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
> Cc: Shivaprasad G Bhat <sbhat@linux.ibm.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Thanks for finding and fixing this Markus.

Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>

Reviewed-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>

Regards,
Shivaprasad

> ---
>   hw/mem/nvdimm.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
> index 8e426d24bb..d5752f7bf6 100644
> --- a/hw/mem/nvdimm.c
> +++ b/hw/mem/nvdimm.c
> @@ -97,7 +97,6 @@ static void nvdimm_set_uuid(Object *obj, Visitor *v, const char *name,
>       if (qemu_uuid_parse(value, &nvdimm->uuid) != 0) {
>           error_setg(errp, "Property '%s.%s' has invalid value",
>                      object_get_typename(obj), name);
> -        goto out;
>       }
>       g_free(value);
>   


