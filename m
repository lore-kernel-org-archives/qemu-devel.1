Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0980FC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 04:58:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1BE220878
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 04:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BE220878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35743 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ9zE-0007gf-30
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 00:58:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hJ9xg-0006mX-4M
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:56:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hJ9t0-0004DO-DE
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:51:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46898
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1hJ9t0-0004Cr-7R
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 00:51:58 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3O4heTT016074
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 00:51:57 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2s2ghj9m7g-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 00:51:57 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Wed, 24 Apr 2019 05:51:56 +0100
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
	by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 24 Apr 2019 05:51:54 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
	[9.57.199.110])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x3O4prdT18481184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Wed, 24 Apr 2019 04:51:53 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0DC9AE05F;
	Wed, 24 Apr 2019 04:51:53 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5AF2AE05C;
	Wed, 24 Apr 2019 04:51:51 +0000 (GMT)
Received: from [9.102.2.245] (unknown [9.102.2.245])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
	Wed, 24 Apr 2019 04:51:51 +0000 (GMT)
To: Fabiano Rosas <farosas@linux.ibm.com>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
	<155591660602.20338.9804738040071843715.stgit@aravinda>
	<875zr43hxj.fsf@linux.ibm.com>
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Wed, 24 Apr 2019 10:21:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <875zr43hxj.fsf@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19042404-0060-0000-0000-0000033226F8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010984; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01193539; UDB=6.00625688;
	IPR=6.00974362; 
	MB=3.00026570; MTD=3.00000008; XFM=3.00000015; UTC=2019-04-24 04:51:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042404-0061-0000-0000-000049110007
Message-Id: <a1e59aa3-f596-abbd-8365-3a12293d85e8@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-24_02:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=718 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904240040
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v8 4/6] target/ppc: Build rtas
 error log upon an MCE
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
Message-ID: <20190424045150.YzgYwZ6ryrCCXKJCtY1-K4CAmfTqDb4Tp3jmVSPubPI@z>



On Tuesday 23 April 2019 08:08 PM, Fabiano Rosas wrote:
> Aravinda Prasad <aravinda@linux.vnet.ibm.com> writes:
> 
>> +    /*
>> +     * Properly set bits in MSR before we invoke the handler.
>> +     * SRR0/1, DAR and DSISR are properly set by KVM
>> +     */
>> +    if (!(*pcc->interrupts_big_endian)(cpu)) {
>> +        msr |= (1ULL << MSR_LE);
>> +    }
>> +
>> +    if (env->msr && (1ULL << MSR_SF)) {
> 
> Don't you mean & instead of &&?

Ah.. yes.. Thanks for pointing out.

> 
>> +        msr |= (1ULL << MSR_SF);
>> +    }
> 
> 

-- 
Regards,
Aravinda


