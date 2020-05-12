Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367BFCA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:27:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09BF2206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09BF2206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47438 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYXkM-0002KO-7M
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:27:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jYXjE-0001oB-Vq; Tue, 12 May 2020 12:26:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45416)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jYXjD-0003LZ-Sn; Tue, 12 May 2020 12:26:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04CG3JEn144879; Tue, 12 May 2020 12:25:57 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30yw8x4x04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2020 12:25:57 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04CG4Mgv003612;
 Tue, 12 May 2020 12:25:57 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30yw8x4wys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2020 12:25:57 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04CGOmSp003470;
 Tue, 12 May 2020 16:25:56 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24]) by ppma02dal.us.ibm.com with ESMTP id 30wm56he56-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2020 16:25:56 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04CGPtRN51577206
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2020 16:25:55 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 719B5AC059;
 Tue, 12 May 2020 16:25:55 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 422C9AC05F;
 Tue, 12 May 2020 16:25:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.150.178])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
 Tue, 12 May 2020 16:25:55 +0000 (GMT)
Subject: Re: [PATCH v1 2/8] s390/sclp: check sccb len before filling in data
To: Cornelia Huck <cohuck@redhat.com>
References: <20200508230823.22956-1-walling@linux.ibm.com>
 <20200508230823.22956-3-walling@linux.ibm.com>
 <58bc496c-28bb-26f8-ab46-aba6ad141717@linux.ibm.com>
 <737869a8-13b2-1831-00c6-629d5a109d9c@redhat.com>
 <05ab2e59-10c0-c7df-c014-b54883ddccd3@linux.ibm.com>
 <9a39a948-91a1-7cfe-f2a5-d30e5564f318@redhat.com>
 <20200512180140.4be69d60.cohuck@redhat.com>
 <dc423845-2b63-7c08-774e-9546c2defe58@linux.ibm.com>
 <20200512182425.0ab4411c.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <f578647b-0e16-7c5d-d830-4541b9ac8d72@linux.ibm.com>
Date: Tue, 12 May 2020 12:25:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200512182425.0ab4411c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-12_05:2020-05-11,
 2020-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120122
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/12 10:56:00
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 mst@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, svens@linux.ibm.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 12:24 PM, Cornelia Huck wrote:
> On Tue, 12 May 2020 12:16:45 -0400
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> On 5/12/20 12:01 PM, Cornelia Huck wrote:
>>> On Mon, 11 May 2020 17:02:06 +0200
>>> David Hildenbrand <david@redhat.com> wrote:
>>>    
>>>> On 11.05.20 16:50, Janosch Frank wrote:
>>>>> On 5/11/20 4:44 PM, David Hildenbrand wrote:
>>>>>> On 11.05.20 16:36, Janosch Frank wrote:
>>>>>>> On 5/9/20 1:08 AM, Collin Walling wrote:
>>>>>>>> The SCCB must be checked for a sufficient length before it is filled
>>>>>>>> with any data. If the length is insufficient, then the SCLP command
>>>>>>>> is suppressed and the proper response code is set in the SCCB header.
>>>>>>>>
>>>>>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>>>>>
>>>>>>> Fixes tag?
>>>
>>> Probably
>>>
>>> Fixes: 832be0d8a3bb ("s390x: sclp: Report insufficient SCCB length")
>>>
>>> ?
>>>    
>>
>> Sounds reasonable. This patch doesn't fix any explicitly-known bugs
>> AFAIK. The s390 Linux kernel is hard-coded to use a 4K size SCCB when
>> executing these commands.
>>
>> I suppose this could introduce a bug if things change in the Linux
>> kernel or if some other OS wants to use this command. That should be
>> enough of a justification, right? (Just want to make sure I understand
>> the use of the tag correctly).
> 
> Yes; from the description of how this is supposed to work it fixes
> architectural conformance, not a bug that is triggered by today's guest
> systems.
> 
> [Usage of the Fixes: tag in QEMU is not quite as essential as in Linux,
> as we don't do the numerous, big stable updates here; I don't think
> this is stable material, but we can certainly record where this was
> introduced.]
> 
> 

Makes sense to me, thanks for the info and commit ID! I'll add it to the
message for next round.

-- 
--
Regards,
Collin

Stay safe and stay healthy

