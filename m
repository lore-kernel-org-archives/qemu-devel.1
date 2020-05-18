Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A37C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:33:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FF1020826
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FF1020826
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jajdt-0003IP-Jq
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 13:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jajch-0001iM-0e; Mon, 18 May 2020 13:32:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63588)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jajcf-0003kK-Bt; Mon, 18 May 2020 13:32:18 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04IH574j140374; Mon, 18 May 2020 13:32:15 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 312c8n8kds-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 13:32:15 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04IH5GJi141138;
 Mon, 18 May 2020 13:32:15 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.11])
 by mx0a-001b2d01.pphosted.com with ESMTP id 312c8n8kdc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 13:32:14 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
 by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04IHUBB2002115;
 Mon, 18 May 2020 17:32:14 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by ppma03dal.us.ibm.com with ESMTP id 313wgqrtwt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 May 2020 17:32:13 +0000
Received: from b03ledav001.gho.boulder.ibm.com
 (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04IHVCWA59310374
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 May 2020 17:31:12 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4C2846E056;
 Mon, 18 May 2020 17:31:12 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 59BD76E04E;
 Mon, 18 May 2020 17:31:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.206.55])
 by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Mon, 18 May 2020 17:31:11 +0000 (GMT)
Subject: Re: [PATCH v2 2/8] s390/sclp: check sccb len before filling in data
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org
References: <20200515222032.18838-1-walling@linux.ibm.com>
 <20200515222032.18838-3-walling@linux.ibm.com>
 <292a440b-d147-e94a-2c00-49a2fa3659b1@redhat.com>
 <8924d502-711f-a8ca-14ba-3fe21a5249f4@linux.ibm.com>
 <d3fe4493-c35a-4e88-045a-ea769231d9b8@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <b7361e6f-0e11-edb2-d2aa-8d6381176c52@linux.ibm.com>
Date: Mon, 18 May 2020 13:31:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <d3fe4493-c35a-4e88-045a-ea769231d9b8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-18_06:2020-05-15,
 2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0
 impostorscore=0 spamscore=0 malwarescore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 mlxscore=0 suspectscore=0
 lowpriorityscore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005180143
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 13:32:15
X-ACL-Warn: Detected OS   = Linux 3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: thuth@redhat.com, frankja@linux.ibm.com, mst@redhat.com, cohuck@redhat.com,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, svens@linux.ibm.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 11:43 AM, David Hildenbrand wrote:
> On 18.05.20 16:32, Collin Walling wrote:
>> On 5/18/20 7:46 AM, David Hildenbrand wrote:
>>> On 16.05.20 00:20, Collin Walling wrote:
>>>> The SCCB must be checked for a sufficient length before it is filled
>>>> with any data. If the length is insufficient, then the SCLP command
>>>> is suppressed and the proper response code is set in the SCCB header.
>>>>
>>>> Fixes: 832be0d8a3bb ("s390x: sclp: Report insufficient SCCB length")
>>>> Signed-off-by: Collin Walling <walling@linux.ibm.com>
>>>> ---
>>>>  hw/s390x/sclp.c | 22 ++++++++++------------
>>>>  1 file changed, 10 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
>>>> index 61e2e2839c..2bd618515e 100644
>>>> --- a/hw/s390x/sclp.c
>>>> +++ b/hw/s390x/sclp.c
>>>> @@ -75,6 +75,11 @@ static void read_SCP_info(SCLPDevice *sclp, SCCB *sccb)
>>>>      int rnsize, rnmax;
>>>>      IplParameterBlock *ipib = s390_ipl_get_iplb();
>>>>  
>>>> +    if (be16_to_cpu(sccb->h.length) < (sizeof(ReadInfo) + cpu_count * sizeof(CPUEntry))) {
>>>> +        sccb->h.response_code = cpu_to_be16(SCLP_RC_INSUFFICIENT_SCCB_LENGTH);
>>>> +        return;
>>>> +    }
>>>> +
>>>
>>> (replied to v1 by mistake)
>>>
>>> Lines too long.
>>>
>>> Please run scripts/checkpatch.pl before submitting.
>>>
>>
>> I do. The changes in this patch are replaced by the #3. I opted to be
>> sloppy here for ease of readability.
>>
>> But if it's truly an issue I can clean it up for next round.
> 
> No good reason to be sloppy and make checkpatch (+ David) complain ;)
> 
> 

Fair enough. I'll make the fix!

-- 
Regards,
Collin

Stay safe and stay healthy

