Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32D6C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:48:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5DB920815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5DB920815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54439 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFnr-0007gH-N6
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:48:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1hRFlp-0006SD-Lt
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.ibm.com>) id 1hRFlm-000577-KY
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:46:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60412
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.ibm.com>)
	id 1hRFle-0004zE-W3
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:45:53 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4GCiO1F044040
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 08:45:43 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sh6qvc4xt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 08:44:26 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.ibm.com>;
	Thu, 16 May 2019 13:42:12 +0100
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
	by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 16 May 2019 13:42:09 +0100
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com
	[9.57.199.106])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	x4GCg8ob21889472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 16 May 2019 12:42:08 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A126728059;
	Thu, 16 May 2019 12:42:08 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91CC528058;
	Thu, 16 May 2019 12:42:08 +0000 (GMT)
Received: from [9.56.58.99] (unknown [9.56.58.99])
	by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
	Thu, 16 May 2019 12:42:08 +0000 (GMT)
To: Christian Borntraeger <borntraeger@de.ibm.com>,
	David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
References: <1556749903-19221-1-git-send-email-walling@linux.ibm.com>
	<a87c71be-5bf8-a115-5843-720c9ad10c7b@redhat.com>
	<bc2fd9bb-7b94-eac7-590b-f01d2063ef9c@redhat.com>
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
	<1a3dcb16-8c6f-214c-843d-6dca6a24801e@redhat.com>
	<9a9e9c58-d991-369f-a577-b70581efc75b@de.ibm.com>
	<3cacee74-92f8-c63a-1aa4-7a169714d70c@redhat.com>
	<92561a80-6ae7-8d18-4448-01b9418053a6@de.ibm.com>
From: Collin Walling <walling@linux.ibm.com>
Date: Thu, 16 May 2019 08:42:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <92561a80-6ae7-8d18-4448-01b9418053a6@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051612-0040-0000-0000-000004F080E1
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011105; HX=3.00000242; KW=3.00000007;
	PH=3.00000004; SC=3.00000285; SDB=6.01204138; UDB=6.00632107;
	IPR=6.00985068; 
	MB=3.00026918; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-16 12:42:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051612-0041-0000-0000-000008FC9086
Message-Id: <5b984668-9f48-3762-3c64-0668fb3ecf90@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-16_10:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905160085
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH v4] s390: diagnose 318 info reset and
 migration support
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
	qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/14/19 5:04 AM, Christian Borntraeger wrote:
> 
> 
> On 14.05.19 11:00, David Hildenbrand wrote:
>> On 14.05.19 10:56, Christian Borntraeger wrote:
>>>
>>>
>>> On 14.05.19 10:50, David Hildenbrand wrote:
>>>> On 14.05.19 10:37, Christian Borntraeger wrote:
>>>>>
>>>>>
>>>>> On 14.05.19 09:28, David Hildenbrand wrote:
>>>>>>>>> But that can be tested using the runability information if I am not wrong.
>>>>>>>>
>>>>>>>> You mean the cpu level information, right?
>>>>>>
>>>>>> Yes, query-cpu-definition includes for each model runability information
>>>>>> via "unavailable-features" (valid under the started QEMU machine).
>>>>>>
>>>>>>>>
>>>>>>>>>
>>>>>>>>>> and others that we have today.
>>>>>>>>>>
>>>>>>>>>> So yes, I think this would be acceptable.
>>>>>>>>>
>>>>>>>>> I guess it is acceptable yes. I doubt anybody uses that many CPUs in
>>>>>>>>> production either way. But you never know.
>>>>>>>>
>>>>>>>> I think that using that many cpus is a more uncommon setup, but I still
>>>>>>>> think that having to wait for actual failure
>>>>>>>
>>>>>>> That can happen all the time today. You can easily say z14 in the xml when
>>>>>>> on a zEC12. Only at startup you get the error. The question is really:
>>>>>>
>>>>>> "-smp 248 -cpu host" will no longer work, while e.g. "-smp 248 -cpu z12"
>>>>>> will work. Actually, even "-smp 248" will no longer work on affected
>>>>>> machines.
>>>>>>
>>>>>> That is why wonder if it is better to disable the feature and print a
>>>>>> warning. Similar to CMMA, where want want to tolerate when CMMA is not
>>>>>> possible in the current environment (huge pages).
>>>>>>
>>>>>> "Diag318 will not be enabled because it is not compatible with more than
>>>>>> 240 CPUs".
>>>>>>
>>>>>> However, I still think that implementing support for more than one SCLP
>>>>>> response page is the best solution. Guests will need adaptions for > 240
>>>>>> CPUs with Diag318, but who cares? Existing setups will continue to work.
>>>>>>
>>>>>> Implementing that SCLP thingy will avoid any warnings and any errors. It
>>>>>> just works from the QEMU perspective.
>>>>>>
>>>>>> Is implementing this realistic?
>>>>>
>>>>> Yes it is but it will take time. I will try to get this rolling. To make
>>>>> progress on the diag318 thing, can we error on startup now and simply
>>>>> remove that check when when have implemented a larger sccb? If we would
>>>>> now do all kinds of "change the max number games" would be harder to "fix".
>>>>
>>>>
>>>> Another idea for temporary handling: Simply only indicate 240 CPUs to
>>>> the guest if the response does not fit into a page. Once we have that
>>>> SCLP thingy, this will be fixed. Guest migration back and forth should
>>>> work, as the VCPUs are fully functional (and initially always stopped),
>>>> the guest will simply not be able to detect them via SCLP when booting
>>>> up, and therefore not use them.
>>>
>>> Yes, that looks like a good temporary solution. In fact if the guest relies
>>> on simply probing it could even make use of the additional CPUs. Its just
>>> the sclp response that is limited to 240 (or make it 247?)
>>
>> I think the limiting factor was more than a single CPU, but I don't
>> recall. We can do the math again and come up with the right number.
> 
> I think We need 8 byte per CPU. With byte 134 we should still be ok with
> 247. Collin can do the math in the patch description.
> 
> 

Yes 247 fits just fine. The 240 came up as extra space in case we expand
the rscpi even more in the future.

I used the

The SCCB_SIZE - sizeof(ReadInfo)) / sizeof(CPUEntry) < S390_MAX_CPUS

calculation as an example of what we could do if the SCCB_SIZE ever
increases (it would allow older machines to retroactively allow diag318
if they can also support a larger SCCB... but thinking out loud, there
might be many more moving parts that would make this preemptive approach
too tricky to implement today).


