Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92DEC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 18:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 888FF20644
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 18:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 888FF20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49214 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTViz-0002IY-EQ
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 14:12:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1hTVi8-0001od-Va
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1hTVi8-000819-3l
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:11:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54314
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1hTVi7-00080W-VV
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:11:32 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4MI4rjj180831
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 14:11:31 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2snatq9pcr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 14:11:30 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Wed, 22 May 2019 19:11:30 +0100
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
	by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 22 May 2019 19:11:26 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com
	[9.57.199.110])
	by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x4MIBPZa24576140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Wed, 22 May 2019 18:11:25 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B6E5AE060;
	Wed, 22 May 2019 18:11:25 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2368BAE05C;
	Wed, 22 May 2019 18:11:25 +0000 (GMT)
Received: from localhost (unknown [9.86.26.96])
	by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
	Wed, 22 May 2019 18:11:25 +0000 (GMT)
From: Fabiano Rosas <farosas@linux.ibm.com>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>, imammedo@redhat.com,
	david@gibson.dropbear.id.au, xiaoguangrong.eric@gmail.com, mst@redhat.com
In-Reply-To: <875zq25plp.fsf@linux.ibm.com>
References: <155773946961.49142.5208084426066783536.stgit@lep8c.aus.stglabs.ibm.com>
	<155773968985.49142.1164691973469833295.stgit@lep8c.aus.stglabs.ibm.com>
	<875zq25plp.fsf@linux.ibm.com>
Date: Wed, 22 May 2019 15:11:23 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19052218-0064-0000-0000-000003E3820E
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011144; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000286; SDB=6.01207078; UDB=6.00633896;
	IPR=6.00988053; 
	MB=3.00027006; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-22 18:11:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052218-0065-0000-0000-00003D91F11E
Message-Id: <8736l65ph0.fsf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-22_09:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=933 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905220126
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [RFC v2 PATCH 3/3] spapr: Add Hcalls to support
 PAPR NVDIMM device
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sbhat@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fabiano Rosas <farosas@linux.ibm.com> writes:

>> +    nvdimm = NVDIMM(drc->dev);
>> +    if ((offset + numBytesToRead < offset) ||
>> +        (nvdimm->label_size < numBytesToRead + offset)) {
>> +        return H_P2;
>> +    }
>
> Won't the first clause always be false? Considering they're both uint64_t.

Neverming this question. I just saw that David asked for it in the previous
version.


