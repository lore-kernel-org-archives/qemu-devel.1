Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC531C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 18:57:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 750A220862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 18:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 750A220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=us.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGSlT-0002Ab-0C
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 14:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36853)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pc@us.ibm.com>) id 1iGShP-0008NR-GX
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 14:53:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pc@us.ibm.com>) id 1iGShN-0001Cr-Uo
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 14:53:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34010)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pc@us.ibm.com>)
 id 1iGShD-00017E-3h; Fri, 04 Oct 2019 14:52:55 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x94IqBRx020349; Fri, 4 Oct 2019 14:52:45 -0400
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com
 [169.63.214.131])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ve5cg6nff-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Oct 2019 14:52:44 -0400
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
 by ppma01dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x94IoNHq006089;
 Fri, 4 Oct 2019 18:52:43 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29]) by ppma01dal.us.ibm.com with ESMTP id 2v9y5acfea-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 04 Oct 2019 18:52:43 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x94IqhhA50397670
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 4 Oct 2019 18:52:43 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0097D28058;
 Fri,  4 Oct 2019 18:52:43 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1F8D52805C;
 Fri,  4 Oct 2019 18:52:42 +0000 (GMT)
Received: from oc3272150783.ibm.com (unknown [9.160.10.50])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTPS;
 Fri,  4 Oct 2019 18:52:41 +0000 (GMT)
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <1570196639-7025-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1570196639-7025-2-git-send-email-stefan.brankovic@rt-rk.com>
From: Paul Clarke <pc@us.ibm.com>
Message-ID: <7ab3c116-7e59-9164-2c29-e37c4b415560@us.ibm.com>
Date: Fri, 4 Oct 2019 13:52:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1570196639-7025-2-git-send-email-stefan.brankovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
Subject: Re:  [PATCH v2] target/ppc: Fix for optimized vsl/vsr instructions
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-10-04_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=768 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910040152
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
Cc: alex.bennee@linaro.org, richard.hendreson@linaro.org,
 mark.cave-ayland@ilande.co.uk, amarkovic@wavecomp.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/4/19 8:43 AM, Stefan Brankovic wrote:
> In previous implementation, invocation of TCG shift function could request
> shift of TCG variable by 64 bits when variable 'sh' is 0, which is not
> supported in TCG (values can be shifted by 0 to 63 bits). This patch fixes
> this by using two separate invocation of TCG shift functions, with maximum
> shift amount of 32.
> 
> Name of variable 'shifted' is changed to 'carry' so variable naming
> is similar to old helper implementation.
> 
> Variables 'avrA' and 'avrB' are replaced with variable 'avr'.
> 
> Fixes: 4e6d0920e7547e6af4bbac5ffe9adfe6ea621822
> Reported-by: Paul Clark <pc@us.ibm.com>

Preferred: "Paul A. Clarke" (for historical consistency)

> Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Suggested-by: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
> Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>

Applying this patch on top of dce5a787c05fe1a3e54d92871cdeba2af6798e0d eliminated the failures that I reported in https://bugs.launchpad.net/qemu/+bug/1841990 associated with vsl/vsr.

Tested-by: Paul A. Clarke  <pc@us.ibm.com>

PC

