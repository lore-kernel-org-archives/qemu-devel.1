Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 046BDC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7C9E20685
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 14:40:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7C9E20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54815 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIwb3-0006dx-5S
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 10:40:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1hIwZY-0005j0-99
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:39:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1hIwZX-0006jl-70
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:39:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51710
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1hIwZX-0006iv-2U
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 10:38:59 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3NEcilr137706
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 10:38:56 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2s221nyxww-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 10:38:56 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Tue, 23 Apr 2019 15:38:55 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
	by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 23 Apr 2019 15:38:52 +0100
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com
	[9.57.199.109])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x3NEcpVl32964690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Tue, 23 Apr 2019 14:38:51 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78C35112061;
	Tue, 23 Apr 2019 14:38:51 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48D4A112062;
	Tue, 23 Apr 2019 14:38:51 +0000 (GMT)
Received: from localhost (unknown [9.86.27.3])
	by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
	Tue, 23 Apr 2019 14:38:51 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
In-Reply-To: <155591660602.20338.9804738040071843715.stgit@aravinda>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591660602.20338.9804738040071843715.stgit@aravinda>
Date: Tue, 23 Apr 2019 11:38:48 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-TM-AS-GCONF: 00
x-cbid: 19042314-0064-0000-0000-000003CEDAD1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010981; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01193257; UDB=6.00625517;
	IPR=6.00974077; 
	MB=3.00026557; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-23 14:38:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042314-0065-0000-0000-00003D2BCAAA
Message-Id: <875zr43hxj.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-23_04:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=542 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904230099
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH v8 4/6] target/ppc: Build rtas error log
 upon an MCE
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
Cc: aik@au1.ibm.com, qemu-devel@nongnu.org, paulus@ozlabs.org,
	qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423143848.C0_BGVc1ddsr-A_we1NNxsB3bkuqANWW4HjIu2ZsHUI@z>

Aravinda Prasad <aravinda@linux.vnet.ibm.com> writes:

> +    /*
> +     * Properly set bits in MSR before we invoke the handler.
> +     * SRR0/1, DAR and DSISR are properly set by KVM
> +     */
> +    if (!(*pcc->interrupts_big_endian)(cpu)) {
> +        msr |= (1ULL << MSR_LE);
> +    }
> +
> +    if (env->msr && (1ULL << MSR_SF)) {

Don't you mean & instead of &&?

> +        msr |= (1ULL << MSR_SF);
> +    }


