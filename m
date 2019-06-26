Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D985C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 14:24:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24B342085A
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 14:24:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B342085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg8qj-0005Zl-BQ
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 10:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54387)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <walling@linux.ibm.com>) id 1hg8pb-00052e-Ft
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 10:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <walling@linux.ibm.com>) id 1hg8pa-0003Vx-Bn
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 10:23:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7288)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <walling@linux.ibm.com>)
 id 1hg8pZ-0003Te-Hm
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 10:23:25 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5QE8eTk122276
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 10:23:20 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tc9ecjvxb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 10:23:04 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
 Wed, 26 Jun 2019 15:23:03 +0100
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
 by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 26 Jun 2019 15:23:00 +0100
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
 [9.57.199.106])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5QEMxxe53346788
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Jun 2019 14:22:59 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4D80D2805E;
 Wed, 26 Jun 2019 14:22:59 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 438B92805C;
 Wed, 26 Jun 2019 14:22:59 +0000 (GMT)
Received: from [9.63.14.61] (unknown [9.63.14.61])
 by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 26 Jun 2019 14:22:59 +0000 (GMT)
To: Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
References: <1561475829-19202-1-git-send-email-walling@linux.ibm.com>
 <1561475829-19202-3-git-send-email-walling@linux.ibm.com>
 <b2351294-c3f1-ca67-6ebf-dea591b2441d@de.ibm.com>
 <20190626141423.0bbd86eb.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Wed, 26 Jun 2019 10:22:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190626141423.0bbd86eb.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19062614-0064-0000-0000-000003F3F30F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011334; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01223563; UDB=6.00643916; IPR=6.01004742; 
 MB=3.00027476; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-26 14:23:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062614-0065-0000-0000-00003E0A3470
Message-Id: <a33d2dea-a053-c102-38cf-fb639b01fc5a@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-26_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906260169
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v5 2/2] s390: diagnose 318
 info reset and migration support
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
Cc: david@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/19 8:14 AM, Cornelia Huck wrote:
> On Wed, 26 Jun 2019 11:12:04 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 25.06.19 17:17, Collin Walling wrote:
>>> index a606547..4c26754 100644
>>> --- a/target/s390x/cpu.h
>>> +++ b/target/s390x/cpu.h
>>> @@ -39,7 +39,13 @@
>>>   
>>>   #define MMU_USER_IDX 0
>>>   
>>> -#define S390_MAX_CPUS 248
>>> +/*
>>> + * HACK: The introduction of additional facility bytes in the Read Info
>>> + * struct consumes space used for CPU entries, thus we must reduce the
>>> + * original maximum CPUs of 248 by one for each new byte or risk smashing
>>> + * the stack.
>>> + */
>>> +#define S390_MAX_CPUS 247
>>
>> I think we decided to not change that. Only if the cpu model contains the diag318
>> feature we are limited to 247 but only for the sclp response.
>> So we said:
>> - we continue to allow 248 cpus
>> - the sclp response will be limited to 247 CPUs if the feature is one
>> - (optional) we print a warning that the guest might not see all CPUs
>>
> 
> Yes, that's what I remember as well... and printing/logging a warning
> is a good idea.
> 

I recall this conversation, but I encountered a bit of a hangup when
running some tests with the new changes.

Since we're adding a new field in the ReadInfo struct, we're permanently
intruding on the space used for CPU entries. A machine with these 
changes and 248 CPUs resulted in stack smash when the guest would start 
up. This happened with diag318 on *and* off. This is a limitation to the
4k SCCB size right now :/

Prior to these patches, I was restricting the max_cpus depending on the
compat version. I failed to do some tests with earlier versions to catch
this error (there are a lot of moving parts... sorry).

I do not think the new byte and the full 248 CPU count can co-exist. We
might be able to union byte 134 and some extra space with the first CPU 
entry... but that could get messy.



