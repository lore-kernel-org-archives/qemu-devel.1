Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E8BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE0920826
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE0920826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jajfP-0005gM-DO
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 13:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jajea-0004P7-R2; Mon, 18 May 2020 13:34:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61006
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jajeZ-0003wi-Lz; Mon, 18 May 2020 13:34:16 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04IHXK8q104099; Mon, 18 May 2020 13:34:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 312c22anah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 13:34:14 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04IHXOtM104284;
 Mon, 18 May 2020 13:34:13 -0400
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com
 [169.55.91.170])
 by mx0a-001b2d01.pphosted.com with ESMTP id 312c22an9y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 13:34:13 -0400
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
 by ppma02wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04IHURkx029078;
 Mon, 18 May 2020 17:34:12 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma02wdc.us.ibm.com with ESMTP id 313wgs0he8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 17:34:12 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04IHYBAS23986652
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 May 2020 17:34:11 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 653AA6E04C;
 Mon, 18 May 2020 17:34:11 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AFFF6E052;
 Mon, 18 May 2020 17:34:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.206.55])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Mon, 18 May 2020 17:34:10 +0000 (GMT)
Subject: Re: [PATCH v2 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
To: qemu-devel@nongnu.org
References: <158961125979.14027.17199612590911195654@45ef0f9c86ae>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <442b7d7a-84a8-9d29-8ccf-c533483840e8@linux.ibm.com>
Date: Mon, 18 May 2020 13:34:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158961125979.14027.17199612590911195654@45ef0f9c86ae>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-18_06:2020-05-15,
 2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 cotscore=-2147483648 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005180143
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 10:31:16
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, david@redhat.com,
 cohuck@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, mst@redhat.com, svens@linux.ibm.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/16/20 2:41 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200515222032.18838-1-walling@linux.ibm.com/
> 
> 
> 
> Hi,
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
> Message-id: 20200515222032.18838-1-walling@linux.ibm.com
> Subject: [PATCH v2 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
> Type: series
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> === TEST SCRIPT END ===
> 
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> Switched to a new branch 'test'
> f8cb821 s390: guest support for diagnose 0x318
> 6b87c59 s390/kvm: header sync for diag318
> af06627 s390/sclp: add extended-length sccb support for kvm guest
> 39b848c s390/sclp: use cpu offset to locate cpu entries
> 1dd8e02 s390/sclp: read sccb from mem based on sccb length
> aad956d s390/sclp: rework sclp boundary and length checks
> 428b1e4 s390/sclp: check sccb len before filling in data
> 850e1b8 s390/sclp: get machine once during read scp/cpu info
> 
> === OUTPUT BEGIN ===
> 1/8 Checking commit 850e1b88729f (s390/sclp: get machine once during read scp/cpu info)
> 2/8 Checking commit 428b1e46e016 (s390/sclp: check sccb len before filling in data)
> WARNING: line over 80 characters
> #23: FILE: hw/s390x/sclp.c:78:
> +    if (be16_to_cpu(sccb->h.length) < (sizeof(ReadInfo) + cpu_count * sizeof(CPUEntry))) {
> 
> ERROR: line over 90 characters
> #48: FILE: hw/s390x/sclp.c:137:
> +    if (be16_to_cpu(sccb->h.length) < (sizeof(ReadCpuInfo) + cpu_count * sizeof(CPUEntry))) {
> 
> total: 1 errors, 1 warnings, 45 lines checked
> 
> Patch 2/8 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> 3/8 Checking commit aad956d5ac92 (s390/sclp: rework sclp boundary and length checks)
> 4/8 Checking commit 1dd8e02af7b2 (s390/sclp: read sccb from mem based on sccb length)
> 5/8 Checking commit 39b848c3be15 (s390/sclp: use cpu offset to locate cpu entries)
> 6/8 Checking commit af06627cc5fb (s390/sclp: add extended-length sccb support for kvm guest)
> WARNING: line over 80 characters
> #91: FILE: hw/s390x/sclp.c:137:
> +        warn_report("insufficient sccb size to store full read scp info response");
> 
> WARNING: line over 80 characters
> #115: FILE: target/s390x/cpu_features_def.inc.h:100:
> +DEF_FEAT(EXTENDED_LENGTH_SCCB, "els", STFL, 140, "Extended-length SCCB facility")
> 
> total: 0 errors, 2 warnings, 76 lines checked
> 
> Patch 6/8 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 7/8 Checking commit 6b87c5992768 (s390/kvm: header sync for diag318)
> 8/8 Checking commit f8cb821134a7 (s390: guest support for diagnose 0x318)
> ERROR: line over 90 characters
> #226: FILE: target/s390x/cpu_features_def.inc.h:125:
> +/* Features exposed via SCLP SCCB Facilities byte 134 (bit numbers relative to byte-134) */
> 
> WARNING: line over 80 characters
> #227: FILE: target/s390x/cpu_features_def.inc.h:126:
> +DEF_FEAT(DIAG_318, "diag_318", SCLP_FAC134, 0, "Control program name and version codes")
> 
> total: 1 errors, 1 warnings, 262 lines checked
> 
> Patch 8/8 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 
> === OUTPUT END ===
> 
> Test command exited with code: 1
> 
> 
> The full log is available at
> http://patchew.org/logs/20200515222032.18838-1-walling@linux.ibm.com/testing.checkpatch/?type=message.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 

I'll have these fixed for next round, but there's not much I can do with
regards to the styling in cpu_features_def.inc.h :/

-- 
Regards,
Collin

Stay safe and stay healthy

