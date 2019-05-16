Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E70C46460
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:37:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E8ED20833
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:37:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E8ED20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57928 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRGZb-0008TJ-7I
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 09:37:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1hRGYe-0007lY-2n
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:36:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1hRGYb-000386-1Y
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:36:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1hRGYZ-0002lG-0P
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:36:24 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4GDYEWl108229
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 09:36:13 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sh8hrsaah-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 09:36:11 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Thu, 16 May 2019 14:36:01 +0100
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
	by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 16 May 2019 14:35:57 +0100
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
	[9.57.199.111])
	by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x4GDZuiY38928724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 16 May 2019 13:35:56 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0CC3AC05F;
	Thu, 16 May 2019 13:35:56 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91FD2AC05E;
	Thu, 16 May 2019 13:35:56 +0000 (GMT)
Received: from [9.56.58.99] (unknown [9.56.58.99])
	by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
	Thu, 16 May 2019 13:35:56 +0000 (GMT)
To: Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
References: <1556749903-19221-1-git-send-email-walling@linux.ibm.com>
	<e948a030-bd30-180e-bbd6-76f4a2390bb9@de.ibm.com>
	<ea6df6b1-4062-c057-92ea-5be40d778fe9@redhat.com>
	<09293a1c-d000-83a8-46b8-b97ad4fa9774@de.ibm.com>
	<56e3ace1-6e48-0e20-47d5-b07ac6dfcf31@redhat.com>
	<e140a076-28a0-0db6-4c59-80e0f2ab44bb@de.ibm.com>
	<c690c4a8-c277-e3c6-3697-3f0a1924559b@redhat.com>
	<20190513134637.3d8bb275.cohuck@redhat.com>
	<898144e3-615e-5074-fb68-bf9995c64609@de.ibm.com>
	<155d2ca3-6a48-c99a-fe42-dca8e3fd4344@redhat.com>
	<066c7470-94a3-a922-9a12-1ca42e474c51@de.ibm.com>
	<20190514104934.6bba9232.cohuck@redhat.com>
	<47f7134b-338f-0207-88ae-4c1969be3786@redhat.com>
	<13b0f0b2-f7c7-01fb-0e17-92bd47d9c346@de.ibm.com>
	<b280d46f-4a0f-f5dd-c89b-b85210d190ca@redhat.com>
	<00b5d031-227b-38f7-9512-e36c3b655c62@de.ibm.com>
	<27bd36e1-a102-e793-6a61-3e7acb6f1255@de.ibm.com>
	<078b7bcd-de03-743d-a150-456be0b09362@redhat.com>
	<20190514113005.2d0c2b1c.cohuck@redhat.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Thu, 16 May 2019 09:35:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514113005.2d0c2b1c.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051613-0072-0000-0000-0000042E6DE4
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011105; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01204155; UDB=6.00632118;
	IPR=6.00985085; 
	MB=3.00026918; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-16 13:36:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051613-0073-0000-0000-00004C3EA838
Message-Id: <c4704f1e-34fe-6c69-8532-6ee1e9cb4bdf@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-16_11:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905160091
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v4] s390: diagnose 318 info
 reset and migration support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mst@redhat.com, qemu-devel@nongnu.org, pasic@linux.ibm.com,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 5:30 AM, Cornelia Huck wrote:
> On Tue, 14 May 2019 11:27:32 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 14.05.19 11:25, Christian Borntraeger wrote:
>>>
>>>
>>> On 14.05.19 11:23, Christian Borntraeger wrote:
>>>>
>>>>
>>>> On 14.05.19 11:20, David Hildenbrand wrote:
>>>>> On 14.05.19 11:10, Christian Borntraeger wrote:
>>>>>>
>>>>>>
>>>>>> On 14.05.19 10:59, David Hildenbrand wrote:
> 
>>>>>>> We can
>>>>>>>
>>>>>>> 1. Fail to start with #cpus > 240 when diag318=on
>>>>>>> 2. Remove the error once we support more than one SCLP response page
>>>>>>>
>>>>>>> Or
>>>>>>>b
>>>>>>> 1. Allow to start with #cpus > 240 when diag318=on, but indicate only
>>>>>>>     240 CPUs via SCLP
>>>>>>> 2. Print a warning
>>>>>>> 3. Remove the restriction and the warning once we support more than one
>>>>>>>     SCLP response page
>>>>>>>
>>>>>>> While I prefer the second approach (similar to defining zPCI devices
>>>>>>> without zpci=on), I could also live with the first approach.
>>>>>>
>>>>>> I prefer approach 1.
>>>>>>   
>>>>>
>>>>> Isn't approach #2 what we discussed (limiting sclp, but of course to 247
>>>>> CPUs), but with an additional warning? I'm confused.
>>>>
>>>> Different numbering interpretion. I was talking about 1 = "Allow to start with #cpus > 240 when diag318=on, but indicate only
>>>> 240 CPUs via SCLP"
>>>
>>> So yes, variant 2 when I use your numbering. The only question is: do we need
>>> a warning? It probably does not hurt.
>>
>> After all, we are talking about 1 VCPU that the guest can only use by
>> indirect probing ... I leave that up to Collin :)
> 
> I'd prefer a warning... even if it is a corner case, I think it's
> better to be explicit instead of silent.
>

Thanks for the discussion. I'll implement diag318 as a CPU feature again
and adjust the max_cpu handling (to 247 now instead of 240).

Question: should diag318 be enabled by default for current CPU models?
What should we do in the case where diag318=on but KVM does not support
handling?

I am not familiar with how close QEMU and KVM versions stay in sync.


