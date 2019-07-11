Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A32C74A42
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 05:51:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9049920838
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 05:51:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9049920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlRzq-0007gQ-UW
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 01:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60248)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sbhat@linux.ibm.com>) id 1hlRzK-000792-US
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 01:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1hlRzJ-00059t-Vv
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 01:51:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62250
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1hlRzJ-00059E-RT
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 01:51:25 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x6B5l766023254
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 01:51:24 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2tny7v86q5-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 01:51:23 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Thu, 11 Jul 2019 06:51:22 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Thu, 11 Jul 2019 06:51:19 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x6B5pItc51642586
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 11 Jul 2019 05:51:18 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 66DBEA405B;
 Thu, 11 Jul 2019 05:51:18 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 332C4A405F;
 Thu, 11 Jul 2019 05:51:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.17])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Thu, 11 Jul 2019 05:51:17 +0000 (GMT)
To: Fabiano Rosas <farosas@linux.ibm.com>, imammedo@redhat.com,
 david@gibson.dropbear.id.au, xiaoguangrong.eric@gmail.com, mst@redhat.com
References: <155773946961.49142.5208084426066783536.stgit@lep8c.aus.stglabs.ibm.com>
 <155773968985.49142.1164691973469833295.stgit@lep8c.aus.stglabs.ibm.com>
 <875zq25plp.fsf@linux.ibm.com>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Date: Thu, 11 Jul 2019 11:21:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <875zq25plp.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19071105-4275-0000-0000-0000034BD79A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071105-4276-0000-0000-0000385BDD5A
Message-Id: <07b3c842-e313-aec9-8558-1944c39b1072@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-07-11_01:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907110068
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [RFC v2 PATCH 3/3] spapr: Add Hcalls to support
 PAPR NVDIMM device
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for the comments Fabiano.


On 05/22/2019 11:38 PM, Fabiano Rosas wrote:
> Shivaprasad G Bhat <sbhat@linux.ibm.com> writes:
>
> +
>> +    ddc = NVDIMM_GET_CLASS(nvdimm);
>> +    ddc->read_label_data(nvdimm, &args[0], numBytesToRead, offset);
>> +
>> +    return H_SUCCESS;
>> +}
>> +
>> +
>> +static target_ulong h_scm_write_metadata(PowerPCCPU *cpu,
>> +                                         SpaprMachineState *spapr,
>> +                                         target_ulong opcode,
>> +                                         target_ulong *args)
>> +{
>> +    uint32_t drc_index = args[0];
>> +    uint64_t offset = args[1];
>> +    uint64_t data = args[2];
>> +    int8_t numBytesToWrite = args[3];
> Likewise.

This is supposed to be uint64_t like used in other places.
Will fix it in the next version.

Rest of the comments I think David has already answered the rational
behind the usage to avoid integer overflow.

>
>> +    SpaprDrc *drc = spapr_drc_by_index(drc_index);
>> +    NVDIMMDevice *nvdimm = NULL;
>> +    DeviceState *dev = NULL;
>>

Regards,
Shivaprasad


