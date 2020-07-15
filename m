Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF23FC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 15:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22D52065E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 15:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22D52065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvjRo-0000uF-38
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 11:35:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jvjRB-0000O0-DP; Wed, 15 Jul 2020 11:35:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:8866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jvjR9-0005sf-0r; Wed, 15 Jul 2020 11:35:12 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 06FFX05i080374; Wed, 15 Jul 2020 11:35:08 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 329d9j9bw8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2020 11:35:08 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06FFXOEZ082546;
 Wed, 15 Jul 2020 11:35:08 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com
 [169.47.144.26])
 by mx0a-001b2d01.pphosted.com with ESMTP id 329d9j9bvj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2020 11:35:08 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
 by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FFL92V017762;
 Wed, 15 Jul 2020 15:35:07 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23]) by ppma04wdc.us.ibm.com with ESMTP id 3275291jud-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Jul 2020 15:35:07 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com
 [9.57.199.107])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 06FFZ6CI53018980
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Jul 2020 15:35:06 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6D84124054;
 Wed, 15 Jul 2020 15:35:06 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9BB15124058;
 Wed, 15 Jul 2020 15:35:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.135.204])
 by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTPS;
 Wed, 15 Jul 2020 15:35:06 +0000 (GMT)
Subject: Re: [PATCH v4 6/8] s390/sclp: add extended-length sccb support for
 kvm guest
To: Cornelia Huck <cohuck@redhat.com>
References: <20200624202312.28349-1-walling@linux.ibm.com>
 <20200624202312.28349-7-walling@linux.ibm.com>
 <20200626120106.6ef7fddc.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <e04f99e1-8f9e-84f6-6aa6-fdae2f6088a9@linux.ibm.com>
Date: Wed, 15 Jul 2020 11:35:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200626120106.6ef7fddc.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-07-15_12:2020-07-15,
 2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150124
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 09:18:04
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, mst@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, svens@linux.ibm.com, pbonzini@redhat.com,
 mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/26/20 6:01 AM, Cornelia Huck wrote:
> On Wed, 24 Jun 2020 16:23:10 -0400
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> As more features and facilities are added to the Read SCP Info (RSCPI)
>> response, more space is required to store them. The space used to store
>> these new features intrudes on the space originally used to store CPU
>> entries. This means as more features and facilities are added to the
>> RSCPI response, less space can be used to store CPU entries.
>>
>> With the Extended-Length SCCB (ELS) facility, a KVM guest can execute
>> the RSCPI command and determine if the SCCB is large enough to store a
>> complete reponse. If it is not large enough, then the required length
>> will be set in the SCCB header.
>>
>> The caller of the SCLP command is responsible for creating a
>> large-enough SCCB to store a complete response. Proper checking should
>> be in place, and the caller should execute the command once-more with
>> the large-enough SCCB.
>>
>> This facility also enables an extended SCCB for the Read CPU Info
>> (RCPUI) command.
>>
>> When this facility is enabled, the boundary violation response cannot
>> be a result from the RSCPI, RSCPI Forced, or RCPUI commands.
>>
>> In order to tolerate kernels that do not yet have full support for this
>> feature, a "fixed" offset to the start of the CPU Entries within the
>> Read SCP Info struct is set to allow for the original 248 max entries
>> when this feature is disabled.
>>
>> Additionally, this is introduced as a CPU feature to protect the guest
>> from migrating to a machine that does not support storing an extended
>> SCCB. This could otherwise hinder the VM from being able to read all
>> available CPU entries after migration (such as during re-ipl).
>>
>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>> ---
>>  hw/s390x/sclp.c                     | 24 +++++++++++++++++++++++-
>>  include/hw/s390x/sclp.h             |  1 +
>>  target/s390x/cpu_features_def.inc.h |  1 +
>>  target/s390x/gen-features.c         |  1 +
>>  target/s390x/kvm.c                  |  8 ++++++++
>>  5 files changed, 34 insertions(+), 1 deletion(-)
>>
> 
> (...)
> 
>> @@ -111,6 +131,8 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>      CPUEntry *entries_start = (void *)sccb + offset_cpu;
>>  
>>      if (!sccb_verify_length(sccb, machine->possible_cpus->len, offset_cpu)) {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "insufficient sccb size to store "
>> +                      "read scp info response\n");
> 
> Not sure if logging needed/provided length would be helpful here.
> 

I had the thought that it may be beneficial for kernel development -- it
gives a response if an SCCB size needs to be larger.

>>          return;
>>      }
>>  
> 
> (...)
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>
> 

Thanks.

-- 
Regards,
Collin

Stay safe and stay healthy

