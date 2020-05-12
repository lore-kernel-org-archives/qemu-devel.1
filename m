Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F6BCA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D8F206B7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 16:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D8F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYXfI-0007uB-F1
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 12:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jYXdq-0006Z8-65; Tue, 12 May 2020 12:20:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:14920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jYXdo-00027U-VZ; Tue, 12 May 2020 12:20:25 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04CG2p6x162281; Tue, 12 May 2020 12:20:23 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30ws2ferv1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2020 12:20:22 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04CG5RTO178642;
 Tue, 12 May 2020 12:20:22 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com
 [169.55.85.253])
 by mx0a-001b2d01.pphosted.com with ESMTP id 30ws2feruf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2020 12:20:22 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
 by ppma01wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04CGFOos002319;
 Tue, 12 May 2020 16:20:21 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25]) by ppma01wdc.us.ibm.com with ESMTP id 30wm56jpsb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 May 2020 16:20:21 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04CGKKNB38273332
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 May 2020 16:20:20 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 79473AC05E;
 Tue, 12 May 2020 16:20:20 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C307AC05B;
 Tue, 12 May 2020 16:20:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.150.178])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTPS;
 Tue, 12 May 2020 16:20:20 +0000 (GMT)
Subject: Re: [PATCH v1 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
To: Cornelia Huck <cohuck@redhat.com>
References: <20200508230823.22956-1-walling@linux.ibm.com>
 <20200512180816.1237e990.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <05144a35-aa13-a0b4-518c-1ddfee446bb7@linux.ibm.com>
Date: Tue, 12 May 2020 12:20:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200512180816.1237e990.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-12_04:2020-05-11,
 2020-05-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120122
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
Cc: frankja@linux.ibm.com, mst@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, svens@linux.ibm.com, pbonzini@redhat.com,
 mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 12:08 PM, Cornelia Huck wrote:
> On Fri,  8 May 2020 19:08:15 -0400
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> Collin L. Walling (8):
>>    s390/sclp: remove SCLPDevice param from prepare_cpu_entries
> 
> This looks like a simple cleanup...
> 
>>    s390/sclp: check sccb len before filling in data
> 
> ...and that like a simple fix (for a problem that currently does not
> trigger.) Would it help or hinder you if I went ahead and queued these
> two patches already?
> 

Let's wait for one more round if that's okay. I left a response to
David's feedback that may-or-may not add one more cleanup that can
be squeezed into patch 1 if it makes sense.

Thanks, though! :)

>>    s390/sclp: rework sclp boundary and length checks
>>    s390/sclp: read sccb from mem based on sccb length
>>    s390/sclp: use cpu offset to locate cpu entries
>>    s390/sclp: add extended-length sccb support for kvm guest
>>    s390/kvm: header sync for diag318
>>    s390: diagnose 318 info reset and migration support
>>
>>   hw/s390x/s390-virtio-ccw.c          |  45 +++++++++++++
>>   hw/s390x/sclp.c                     | 101 +++++++++++++++++++++-------
>>   include/hw/s390x/s390-virtio-ccw.h  |   1 +
>>   include/hw/s390x/sclp.h             |   4 ++
>>   linux-headers/asm-s390/kvm.h        |   5 ++
>>   smp.max_cpus                        |   0
> 
> Probably a stray file? (Should be stripped from patch 2.)

Uhhh not sure how that got there :) Probably silly editor doing silly 
things. I'll make sure next round has that stripped.

> 
>>   target/s390x/cpu.c                  |  19 ++++++
>>   target/s390x/cpu.h                  |   4 ++
>>   target/s390x/cpu_features.h         |   1 +
>>   target/s390x/cpu_features_def.inc.h |   4 ++
>>   target/s390x/cpu_models.c           |   1 +
>>   target/s390x/gen-features.c         |   2 +
>>   target/s390x/kvm-stub.c             |  10 +++
>>   target/s390x/kvm.c                  |  52 ++++++++++++++
>>   target/s390x/kvm_s390x.h            |   3 +
>>   15 files changed, 229 insertions(+), 23 deletions(-)
>>   create mode 100644 smp.max_cpus
>>
> 


-- 
--
Regards,
Collin

Stay safe and stay healthy

