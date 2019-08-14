Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820EAC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 16:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 578972133F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 16:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578972133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxwFk-0006Ao-Aq
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 12:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52665)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pc@us.ibm.com>) id 1hxwEI-0004zO-Cd
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 12:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pc@us.ibm.com>) id 1hxwEH-0006JZ-AV
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 12:34:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65522
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pc@us.ibm.com>)
 id 1hxwED-0006Hd-0t; Wed, 14 Aug 2019 12:34:25 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x7EGWXa9084366; Wed, 14 Aug 2019 12:34:18 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ucmp7k9r5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Aug 2019 12:34:18 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7EGAW7K027581;
 Wed, 14 Aug 2019 16:34:17 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma01dal.us.ibm.com with ESMTP id 2u9nj6xd7k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 14 Aug 2019 16:34:17 +0000
Received: from b03ledav004.gho.boulder.ibm.com
 (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x7EGYFO839977260
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 14 Aug 2019 16:34:16 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C99A778060;
 Wed, 14 Aug 2019 16:34:15 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 077177805C;
 Wed, 14 Aug 2019 16:34:14 +0000 (GMT)
Received: from oc3272150783.ibm.com (unknown [9.85.151.40])
 by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Wed, 14 Aug 2019 16:34:14 +0000 (GMT)
To: qemu-devel@nongnu.org
References: <156580023314.3056.6268901484469396279@5dec9699b7de>
From: Paul Clarke <pc@us.ibm.com>
Message-ID: <3ff4c0cd-b757-55e3-c675-cbfd74a7f76e@us.ibm.com>
Date: Wed, 14 Aug 2019 11:34:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156580023314.3056.6268901484469396279@5dec9699b7de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-08-14_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=990 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140157
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH v3] ppc: Add support for 'mffsl' instruction
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
Cc: qemu-ppc@nongnu.org, richard.henderson@linaro.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Should these 'checkpatch' ERRORs be addressed, even if it will diverge the code style from the existing, surrounding code?

On 8/14/19 11:30 AM, no-reply@patchew.org wrote:
> This series seems to have some coding style problems. See output below for
> more information:

> === OUTPUT BEGIN ===
> ERROR: code indent should never use tabs
> #54: FILE: disas/ppc.c:5004:
> +{ "mffsl",   XRA(63,583,12), XRARB_MASK,^IPOWER9,^I{ FRT } },$
> 
> ERROR: space required after that ',' (ctx:VxV)
> #54: FILE: disas/ppc.c:5004:
> +{ "mffsl",   XRA(63,583,12), XRARB_MASK,       POWER9, { FRT } },
>                     ^
> 
> ERROR: space required after that ',' (ctx:VxV)
> #54: FILE: disas/ppc.c:5004:
> +{ "mffsl",   XRA(63,583,12), XRARB_MASK,       POWER9, { FRT } },
>                         ^
> 
> ERROR: braces {} are necessary for all arms of this statement
> #148: FILE: target/ppc/translate/fp-impl.inc.c:625:
> +    if (unlikely(!(ctx->insns_flags2 & PPC2_ISA300)))
> [...]
> 
> total: 4 errors, 0 warnings, 115 lines checked
> 
> Commit c51c0f894525 (ppc: Add support for 'mffsl' instruction) has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> === OUTPUT END ===

PC

