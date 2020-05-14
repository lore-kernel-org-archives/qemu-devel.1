Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B13C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 17:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8AD206DC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 17:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8AD206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZHeE-0008SM-DO
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 13:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jZHdT-0007nV-9j; Thu, 14 May 2020 13:27:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15320
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1jZHdS-0006G1-FU; Thu, 14 May 2020 13:27:06 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 04EH2TCc187921; Thu, 14 May 2020 13:27:05 -0400
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3119d99ws3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2020 13:27:05 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04EHR4ex116146;
 Thu, 14 May 2020 13:27:04 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 3119d99wrq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2020 13:27:04 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04EHEmWi020001;
 Thu, 14 May 2020 17:22:03 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by ppma02dal.us.ibm.com with ESMTP id 3100ucce4m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 May 2020 17:22:03 +0000
Received: from b03ledav006.gho.boulder.ibm.com
 (b03ledav006.gho.boulder.ibm.com [9.17.130.237])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 04EHM2s720775188
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 May 2020 17:22:02 GMT
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26605C6057;
 Thu, 14 May 2020 17:22:02 +0000 (GMT)
Received: from b03ledav006.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3EE6DC6061;
 Thu, 14 May 2020 17:22:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.130.116])
 by b03ledav006.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Thu, 14 May 2020 17:22:01 +0000 (GMT)
Subject: Re: [PATCH v1 2/8] s390/sclp: check sccb len before filling in data
To: Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>
References: <20200508230823.22956-1-walling@linux.ibm.com>
 <20200508230823.22956-3-walling@linux.ibm.com>
 <58bc496c-28bb-26f8-ab46-aba6ad141717@linux.ibm.com>
 <737869a8-13b2-1831-00c6-629d5a109d9c@redhat.com>
 <05ab2e59-10c0-c7df-c014-b54883ddccd3@linux.ibm.com>
 <9a39a948-91a1-7cfe-f2a5-d30e5564f318@redhat.com>
 <20200512180140.4be69d60.cohuck@redhat.com>
 <5ed5bc04-e4e3-21ca-057f-a978ef411ad8@linux.ibm.com>
 <20200513101637.2f325838.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Message-ID: <3de4ba3e-e609-c753-fd57-4ed00242e820@linux.ibm.com>
Date: Thu, 14 May 2020 13:22:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200513101637.2f325838.cohuck@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216, 18.0.676
 definitions=2020-05-14_05:2020-05-14,
 2020-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 priorityscore=1501 cotscore=-2147483648 phishscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1015 adultscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005140147
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
Cc: mst@redhat.com, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org,
 svens@linux.ibm.com, pbonzini@redhat.com, mihajlov@linux.ibm.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/20 4:16 AM, Cornelia Huck wrote:
> On Wed, 13 May 2020 09:43:37 +0200
> Janosch Frank <frankja@linux.ibm.com> wrote:
> 
>> On 5/12/20 6:01 PM, Cornelia Huck wrote:
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
>>>>>>> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>    
>>>>>>
>>>>>> This is not a fix AFAIKs.
>>>>>> sclp_service_call()/sclp_service_call_protected() always supplies a full
>>>>>> SCCB of exactly 4k size.
>>>>>>    
>>>>>
>>>>> We don't check for QEMU's 4k buffer here, but for the length that was
>>>>> specified by the guest.
>>>>>
>>>>> It's valid for the guest to request cpu info and state that its buffer
>>>>> is only 1k. We can't write everything in 1k if we have ~200 cpus, so
>>>>> we'll report the insufficient length rc.
>>>>>
>>>>> What he fixes here is the time of the length check, it should be done
>>>>> before any changes are being done to the work_sccb.    
>>>>
>>>> I don't have access to the spec, especially, if the guest can expect
>>>> nothing else in the sccb to change in case we report an error code. So
>>>> whatever you tell me, I have to trust you :)  
>>>
>>> Same here. Sounds plausible, but I have to trust the folks with the
>>> documentation :)
>>>   
>>
>> The AR states that:
>> * Command validity check (has prio over length, as length is dependent
>> on command)
>> * boundary (if extended-length is not available)
>> * Sufficient length check
>>
>> are done before "any other command action is taken".
>> If a test fails the command is suppressed.
> 
> Thanks, makes sense.
> 

Thanks, Janosch! (I suppose I could've said the same as well. Sorry
about that).

-- 
--
Regards,
Collin

Stay safe and stay healthy

