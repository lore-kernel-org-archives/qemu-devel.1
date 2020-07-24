Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFCAC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 15:07:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91521206D7
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 15:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91521206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyzI1-000404-TM
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 11:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jyzHA-00035I-72; Fri, 24 Jul 2020 11:06:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jyzH8-0002FS-DK; Fri, 24 Jul 2020 11:06:19 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06OF3Y4c124621; Fri, 24 Jul 2020 11:06:15 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32fux7br61-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2020 11:06:14 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06OF4Bmk131030;
 Fri, 24 Jul 2020 11:06:14 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.27])
 by mx0a-001b2d01.pphosted.com with ESMTP id 32fux7br5d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2020 11:06:14 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
 by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06OF5UrH031163;
 Fri, 24 Jul 2020 15:06:13 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma05wdc.us.ibm.com with ESMTP id 32brq9d88e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2020 15:06:13 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06OF6CIp43647344
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2020 15:06:12 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 831B4AC064;
 Fri, 24 Jul 2020 15:06:12 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2112FAC05F;
 Fri, 24 Jul 2020 15:06:12 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.200.156])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
 Fri, 24 Jul 2020 15:06:12 +0000 (GMT)
Subject: Re: [PATCH v4 3/8] s390/sclp: rework sclp boundary and length checks
To: Cornelia Huck <cohuck@redhat.com>
References: <20200624202312.28349-1-walling@linux.ibm.com>
 <20200624202312.28349-4-walling@linux.ibm.com>
 <89b72ce5-39c7-3080-286a-ab6ed59afb7e@redhat.com>
 <c7ba363c-a142-9fb9-2ecf-a8dc56a6e6f8@linux.ibm.com>
 <bd373fb2-20d3-baf4-f2bc-4eca1f033c2b@redhat.com>
 <a4e80383-b244-e47b-8980-8b35fb6a7468@linux.ibm.com>
 <20200723082626.5f2bda1b.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <28a774cb-afa7-eeaa-2c07-add4c4f54d8b@linux.ibm.com>
Date: Fri, 24 Jul 2020 11:06:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200723082626.5f2bda1b.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-24_05:2020-07-24,
 2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 malwarescore=0 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007240117
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 09:30:16
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: thuth@redhat.com, frankja@linux.ibm.com,
 David Hildenbrand <david@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 svens@linux.ibm.com, pbonzini@redhat.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/23/20 2:26 AM, Cornelia Huck wrote:
> On Tue, 21 Jul 2020 14:40:14 -0400
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> On 7/21/20 4:41 AM, David Hildenbrand wrote:
> 
>>> The options I would support are
>>>
>>> 1. "sccb_boundary_is_valid" which returns "true" if valid
>>> 2. "sccb_boundary_is_invalid" which returns "true" if invalid
>>> 3. "sccb_boundary_validate" which returns "0" if valid and -EINVAL if not.
>>>
>>> Which makes reading this code a bit easier.
>>>   
> 
> Of these, I like option 1 best.
> 
>>
>> Sounds good. I'll takes this into consideration for the next round. (I
>> may wait just a little longer for that to allow more reviews to come in
>> from whoever has the time, if that's okay.)
> 
> We have to wait for (a) QEMU to do a release and (b) the Linux changes
> to merge upstream anyway, so we're not in a hurry :)
> 
> As said before, it already looked good from my side, but the suggested
> changes are fine with me as well.
> 
> 

Okay, thanks for the info.

I do want to send out a v5 of these patches. While working with someone
who is implementing the kernel support for the extended-length SCCB, we
found some snags. I'll highlight these changes/fixes in the respective
patches on the next version.

Thanks!

-- 
Regards,
Collin

Stay safe and stay healthy

