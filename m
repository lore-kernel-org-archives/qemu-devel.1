Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C5D6C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:11:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 620772082E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 06:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620772082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ih650-0007Jn-Km
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 01:11:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sbhat@linux.ibm.com>) id 1ih64N-0006nr-8Z
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:10:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1ih64M-00081a-CE
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:10:55 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35692)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1ih64M-0007yv-57
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 01:10:54 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xBH67TjA139294
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 01:10:52 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2wwdvn6j40-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 01:10:52 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Tue, 17 Dec 2019 06:10:50 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 17 Dec 2019 06:10:48 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
 [9.149.105.61])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 xBH6Ala544892256
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Dec 2019 06:10:47 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 781AE11C05B;
 Tue, 17 Dec 2019 06:10:47 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4677911C04A;
 Tue, 17 Dec 2019 06:10:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.229])
 by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 17 Dec 2019 06:10:46 +0000 (GMT)
Subject: Re: [PATCH v3 3/3] spapr: Add Hcalls to support PAPR NVDIMM device
To: David Gibson <david@gibson.dropbear.id.au>
References: <157107820388.27733.3565652855304038259.stgit@lep8c.aus.stglabs.ibm.com>
 <157107827730.27733.6442960086351627702.stgit@lep8c.aus.stglabs.ibm.com>
 <20191122051121.GE5582@umbus.fritz.box>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Date: Tue, 17 Dec 2019 11:40:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20191122051121.GE5582@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19121706-0020-0000-0000-00000398FBC2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121706-0021-0000-0000-000021F015FC
Message-Id: <60ac495d-a6ef-f182-1c08-4061e362919e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-17_01:2019-12-16,2019-12-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 mlxlogscore=958 lowpriorityscore=0 malwarescore=0 spamscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912170055
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
Cc: xiaoguangrong.eric@gmail.com, mst@redhat.com, sbhat@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi David,


On 11/22/2019 10:41 AM, David Gibson wrote:
> On Mon, Oct 14, 2019 at 01:38:16PM -0500, Shivaprasad G Bhat wrote:
>> device_add/del phase itself instead.
>>
>> The guest kernel makes bind/unbind requests for the virtual NVDIMM device
>> at the region level granularity. Without interleaving, each virtual NVDIMM
> It's not clear to me what a "region" means in this context.

That is PMEM terminology. "region" in this context is guest physical
address range.

Fixing all the rest of the things you pointed out.

Thanks,
Shivaprasad

>


