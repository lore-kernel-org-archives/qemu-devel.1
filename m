Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9266AC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 17:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AD392065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 17:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AD392065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZHcZ-0007Ed-Jy
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 13:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jZHZp-0003cW-Vr; Thu, 14 May 2020 13:23:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36424
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jZHZo-0004B1-UZ; Thu, 14 May 2020 13:23:21 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04EH1aKZ069673; Thu, 14 May 2020 13:23:19 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3119dg1ta9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2020 13:23:19 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04EH1bue069764;
 Thu, 14 May 2020 13:23:18 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3119dg1t9w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2020 13:23:18 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04EHE6AZ020547;
 Thu, 14 May 2020 17:23:18 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by ppma03dal.us.ibm.com with ESMTP id 3100ubvfg5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2020 17:23:17 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04EHNGva30343600
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 May 2020 17:23:16 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6B1F5C6057;
 Thu, 14 May 2020 17:23:16 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ADDE1C6055;
 Thu, 14 May 2020 17:23:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.130.116])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Thu, 14 May 2020 17:23:15 +0000 (GMT)
Subject: Re: [PATCH v1 3/8] s390/sclp: rework sclp boundary and length checks
To: Cornelia Huck <cohuck@redhat.com>
References: <20200508230823.22956-1-walling@linux.ibm.com>
 <20200508230823.22956-4-walling@linux.ibm.com>
 <d894a835-d0ea-2d61-0416-c4804a755dca@redhat.com>
 <75157d93-2f4d-db25-4a0d-fdb4a7781135@linux.ibm.com>
 <20200513090000.4272ddab.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <8acc1593-535d-bf1a-3129-bbb21d1d060a@linux.ibm.com>
Date: Thu, 14 May 2020 13:23:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200513090000.4272ddab.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-14_05:2020-05-14,
 2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 mlxscore=0 spamscore=0 priorityscore=1501 cotscore=-2147483648
 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=971
 impostorscore=0 malwarescore=0 clxscore=1015 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005140147
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 13:23:19
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
Cc: frankja@linux.ibm.com, David Hildenbrand <david@redhat.com>, mst@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, svens@linux.ibm.com, pbonzini@redhat.com,
 mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/20 3:00 AM, Cornelia Huck wrote:
> On Tue, 12 May 2020 10:55:56 -0400
> Collin Walling <walling@linux.ibm.com> wrote:
> 
>> On 5/12/20 3:21 AM, David Hildenbrand wrote:
>>> On 09.05.20 01:08, Collin Walling wrote:  
> 
>>>> +static bool check_sufficient_sccb_len(SCCB *sccb, int size)  
>>>
>>> "has_sufficient_sccb_len" ?
>>>   
>>>> +{
>>>> +    MachineState *ms = MACHINE(qdev_get_machine());
>>>> +    int required_len = size + ms->possible_cpus->len * sizeof(CPUEntry);  
>>>
>>> Rather pass in the number of cpus instead. Looking up the machine again
>>> in here is ugly.  
>>
>> prepare_cpu_entries also looks up the machine again. Should I squeeze
>> in a cleanup where we pass the machine to that function too (perhaps
>> in the "remove SCLPDevice" patch)?
> 
> sclp_read_cpu_info() does not have the machine handy, so you'd need to
> move machine lookup there; but I think it's worth getting rid of
> duplicate lookups.
> 

Sounds good, then. I'll propose a change to patch 1 that removes the
unused SCLPDevice param and accepts a MachineState instead. Should make
things a bit cleaner :)

>>
>>>   
>>>> +
>>>> +    if (be16_to_cpu(sccb->h.length) < required_len) {
>>>> +        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
>>>> +        return false;
>>>> +    }
>>>> +    return true;
>>>> +}
>>>> +
> 
> 


-- 
--
Regards,
Collin

Stay safe and stay healthy

