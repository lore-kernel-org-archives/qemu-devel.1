Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CF5C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 19:07:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B748F21924
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 19:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B748F21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7P0Q-0001Ne-RV
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 15:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1i7OzR-0000kr-Kd
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 15:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mdroth@linux.vnet.ibm.com>) id 1i7OzQ-0002Bb-JC
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 15:06:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
 id 1i7OzM-00026N-F1; Mon, 09 Sep 2019 15:06:12 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x89J2QxG118853; Mon, 9 Sep 2019 15:06:01 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2uwvdm8dtr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2019 15:06:01 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x89J5Us4027754;
 Mon, 9 Sep 2019 19:06:00 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27]) by ppma01wdc.us.ibm.com with ESMTP id 2uv466vsd0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Sep 2019 19:06:00 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com
 [9.57.199.108])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x89J5xl648366002
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Sep 2019 19:05:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96749B2066;
 Mon,  9 Sep 2019 19:05:59 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79478B205F;
 Mon,  9 Sep 2019 19:05:59 +0000 (GMT)
Received: from localhost (unknown [9.53.179.213])
 by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
 Mon,  9 Sep 2019 19:05:59 +0000 (GMT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <156805260916.1779401.11054185183758185247.stgit@bahia.lan>
References: <156805260916.1779401.11054185183758185247.stgit@bahia.lan>
Message-ID: <156805595241.3458.14203718814944272162@sif>
User-Agent: alot/0.7
Date: Mon, 09 Sep 2019 14:05:52 -0500
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-09-09_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909090191
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [PATCH] spapr-tpm-proxy: Drop misleading check
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
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Quoting Greg Kurz (2019-09-09 13:10:09)
> Coverity is reporting in CID 1405304 that tpm_execute() may pass a NULL
> tpm_proxy->host_path pointer to open(). This is based on the fact that
> h_tpm_comm() does a NULL check on tpm_proxy->host_path and then passes
> tpm_proxy to tpm_execute().
> =

> The check in h_tpm_comm() is abusive actually since a spapr-proxy-tpm
> requires a non NULL host_path property, as checked during realize.
> =

> Fixes: 0fb6bd073230
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>

Thanks for the quick fix!

> ---
>  hw/ppc/spapr_tpm_proxy.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> =

> diff --git a/hw/ppc/spapr_tpm_proxy.c b/hw/ppc/spapr_tpm_proxy.c
> index b835d25be6f6..ca1caec113f0 100644
> --- a/hw/ppc/spapr_tpm_proxy.c
> +++ b/hw/ppc/spapr_tpm_proxy.c
> @@ -114,7 +114,7 @@ static target_ulong h_tpm_comm(PowerPCCPU *cpu,
>          return H_FUNCTION;
>      }
> =

> -    trace_spapr_h_tpm_comm(tpm_proxy->host_path ?: "null", op);
> +    trace_spapr_h_tpm_comm(tpm_proxy->host_path, op);
> =

>      switch (op) {
>      case TPM_COMM_OP_EXECUTE:
>=20

