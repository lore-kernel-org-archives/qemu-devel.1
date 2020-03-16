Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49F9C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:37:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C34920679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 18:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C34920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDucg-0000bE-Lf
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 14:37:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40666)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mahesh@linux.vnet.ibm.com>) id 1jDtOG-0003b7-4j
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:19:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mahesh@linux.vnet.ibm.com>) id 1jDtOF-0003oh-0B
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:18:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42480)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mahesh@linux.vnet.ibm.com>)
 id 1jDtOE-0003gO-OR
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 13:18:58 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02GHARDN111543
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 13:18:57 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2yrue22vde-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 13:18:56 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <mahesh@linux.vnet.ibm.com>;
 Mon, 16 Mar 2020 17:18:54 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
 by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Mon, 16 Mar 2020 17:18:50 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02GHInRl57016434
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Mar 2020 17:18:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7CE635204F;
 Mon, 16 Mar 2020 17:18:49 +0000 (GMT)
Received: from in.ibm.com (unknown [9.199.45.53])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 057AF5204E;
 Mon, 16 Mar 2020 17:18:47 +0000 (GMT)
Date: Mon, 16 Mar 2020 22:48:45 +0530
From: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 2/8] ppc/spapr: Change FWNMI names
References: <20200316142613.121089-1-npiggin@gmail.com>
 <20200316142613.121089-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316142613.121089-3-npiggin@gmail.com>
X-TM-AS-GCONF: 00
x-cbid: 20031617-0028-0000-0000-000003E5CB4B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031617-0029-0000-0000-000024AB1D38
Message-Id: <20200316171845.dq425igrgb5gion2@in.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-16_07:2020-03-12,
 2020-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=625 suspectscore=1 clxscore=1011
 lowpriorityscore=0 priorityscore=1501 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003160076
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
X-Mailman-Approved-At: Mon, 16 Mar 2020 13:49:15 -0400
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
Reply-To: mahesh@linux.vnet.ibm.com
Cc: Aravinda Prasad <arawinda.p@gmail.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, Ganesh Goudar <ganeshgr@linux.ibm.com>,
 qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2020-03-17 00:26:07 Tue, Nicholas Piggin wrote:
> The option is called "FWNMI", and it involves more than just machine
> checks, also machine checks can be delivered without the FWNMI option,
> so re-name various things to reflect that.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/ppc/spapr.c                    | 28 ++++++++++++++--------------
>  hw/ppc/spapr_caps.c               | 14 +++++++-------
>  hw/ppc/spapr_events.c             | 14 +++++++-------
>  hw/ppc/spapr_rtas.c               | 17 +++++++++--------
>  include/hw/ppc/spapr.h            | 27 +++++++++++++++++----------
>  tests/qtest/libqos/libqos-spapr.h |  2 +-
>  6 files changed, 55 insertions(+), 47 deletions(-)
> 
[...]
> @@ -626,14 +626,14 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] = {
>          .type = "bool",
>          .apply = cap_ccf_assist_apply,
>      },
> -    [SPAPR_CAP_FWNMI_MCE] = {
> -        .name = "fwnmi-mce",
> -        .description = "Handle fwnmi machine check exceptions",
> -        .index = SPAPR_CAP_FWNMI_MCE,
> +    [SPAPR_CAP_FWNMI] = {
> +        .name = "fwnmi",

I guess this should be fine and should hit QEMU 5.0 release so that we
don't end up with two different CAP names for 5.0 and future releases.

Thanks,
-Mahesh.


