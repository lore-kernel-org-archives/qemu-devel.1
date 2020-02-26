Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9B0C4BA04
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:14:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E63B2467B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 12:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E63B2467B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6va8-0008PY-8g
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 07:14:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48643)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sbhat@linux.ibm.com>) id 1j6vZT-0007tn-Rl
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sbhat@linux.ibm.com>) id 1j6vZS-0006ve-Dg
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:13:47 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61176)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sbhat@linux.ibm.com>) id 1j6vZS-0006se-56
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 07:13:46 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01QCALQW088480
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 07:13:45 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ydq6gu9x4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 07:13:44 -0500
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <sbhat@linux.ibm.com>;
 Wed, 26 Feb 2020 12:13:42 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 26 Feb 2020 12:13:38 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
 [9.149.105.232])
 by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP
 id 01QCCfZD46596500
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2020 12:12:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E470B52051;
 Wed, 26 Feb 2020 12:13:37 +0000 (GMT)
Received: from [9.199.196.202] (unknown [9.199.196.202])
 by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EEF6352050;
 Wed, 26 Feb 2020 12:13:35 +0000 (GMT)
Subject: Re: [PULL 07/20] spapr: Add NVDIMM device support
To: Peter Maydell <peter.maydell@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20200221033650.444386-1-david@gibson.dropbear.id.au>
 <20200221033650.444386-8-david@gibson.dropbear.id.au>
 <CAFEAcA8GZ-YkfQJ9TMAOoLe++WF9+YZT1rw_F8xLPxY+ciBhMg@mail.gmail.com>
From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Date: Wed, 26 Feb 2020 17:43:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8GZ-YkfQJ9TMAOoLe++WF9+YZT1rw_F8xLPxY+ciBhMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 20022612-0020-0000-0000-000003ADBF80
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20022612-0021-0000-0000-00002205DA3C
Message-Id: <c26ee672-061a-ea06-9b81-f55c8fed67f7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-26_03:2020-02-26,
 2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0
 spamscore=0 impostorscore=0 suspectscore=2 bulkscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260092
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
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
Cc: Laurent Vivier <lvivier@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Bharata B Rao <bharata@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 02/25/2020 03:30 PM, Peter Maydell wrote:
> On Fri, 21 Feb 2020 at 03:37, David Gibson <david@gibson.dropbear.id.au> wrote:
>> From: Shivaprasad G Bhat <sbhat@linux.ibm.com>
>>
>> Add support for NVDIMM devices for sPAPR. Piggyback on existing nvdimm
>> device interface in QEMU to support virtual NVDIMM devices for Power.
>> +    }
>> +
>> +    uuidstr = object_property_get_str(OBJECT(nvdimm), NVDIMM_UUID_PROP, NULL);
>> +    qemu_uuid_parse(uuidstr, &uuid);
>> +    g_free(uuidstr);
>> +
>> +    if (qemu_uuid_is_null(&uuid)) {
>> +        error_setg(errp, "NVDIMM device requires the uuid to be set");
>> +        return;
>> +    }
>> +}
> Hi -- Coverity thinks (CID 1419883) that it's suspicious that
> this code doesn't check the return value of qemu_uuid_parse(),
> because we check it everywhere else that we call that function
> (it can return a failure code if the UUID doesn't validly parse).
Hi Peter,

The nvdimm_set_uuid() already verifies if the uuid is valid or not. So, 
its safe
if we dont check here again.

I just posted a patch adding an assert here.

Thanks and Regards,
Shivaprasad


