Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14AC9C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:06:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCE7520862
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 09:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCE7520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43515 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQTOe-0004G1-Ux
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 05:06:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hQTMJ-000296-P1
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:04:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hQTMH-00039D-SI
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:04:27 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39764
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hQTMH-00034o-LP
	for qemu-devel@nongnu.org; Tue, 14 May 2019 05:04:25 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4E8x0RN048378
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 05:04:23 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sfqjeymp2-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 14 May 2019 05:04:23 -0400
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Tue, 14 May 2019 10:04:18 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
	by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Tue, 14 May 2019 10:04:14 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com
	[9.149.105.62])
	by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4E94CfZ50790590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Tue, 14 May 2019 09:04:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1191AE05D;
	Tue, 14 May 2019 09:04:12 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5249FAE057;
	Tue, 14 May 2019 09:04:12 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.133])
	by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2019 09:04:12 +0000 (GMT)
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
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
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
	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
	syiRa+UVlsKmx1hsEg==
Date: Tue, 14 May 2019 11:04:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <3cacee74-92f8-c63a-1aa4-7a169714d70c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19051409-0020-0000-0000-0000033C763B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051409-0021-0000-0000-0000218F30C0
Message-Id: <92561a80-6ae7-8d18-4448-01b9418053a6@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-14_05:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905140066
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
Cc: Collin Walling <walling@linux.ibm.com>, mst@redhat.com,
	qemu-devel@nongnu.org, pasic@linux.ibm.com,
	qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 14.05.19 11:00, David Hildenbrand wrote:
> On 14.05.19 10:56, Christian Borntraeger wrote:
>>
>>
>> On 14.05.19 10:50, David Hildenbrand wrote:
>>> On 14.05.19 10:37, Christian Borntraeger wrote:
>>>>
>>>>
>>>> On 14.05.19 09:28, David Hildenbrand wrote:
>>>>>>>> But that can be tested using the runability information if I am not wrong.
>>>>>>>
>>>>>>> You mean the cpu level information, right?
>>>>>
>>>>> Yes, query-cpu-definition includes for each model runability information
>>>>> via "unavailable-features" (valid under the started QEMU machine).
>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>> and others that we have today.
>>>>>>>>>
>>>>>>>>> So yes, I think this would be acceptable.  
>>>>>>>>
>>>>>>>> I guess it is acceptable yes. I doubt anybody uses that many CPUs in
>>>>>>>> production either way. But you never know.
>>>>>>>
>>>>>>> I think that using that many cpus is a more uncommon setup, but I still
>>>>>>> think that having to wait for actual failure
>>>>>>
>>>>>> That can happen all the time today. You can easily say z14 in the xml when 
>>>>>> on a zEC12. Only at startup you get the error. The question is really:
>>>>>
>>>>> "-smp 248 -cpu host" will no longer work, while e.g. "-smp 248 -cpu z12"
>>>>> will work. Actually, even "-smp 248" will no longer work on affected
>>>>> machines.
>>>>>
>>>>> That is why wonder if it is better to disable the feature and print a
>>>>> warning. Similar to CMMA, where want want to tolerate when CMMA is not
>>>>> possible in the current environment (huge pages).
>>>>>
>>>>> "Diag318 will not be enabled because it is not compatible with more than
>>>>> 240 CPUs".
>>>>>
>>>>> However, I still think that implementing support for more than one SCLP
>>>>> response page is the best solution. Guests will need adaptions for > 240
>>>>> CPUs with Diag318, but who cares? Existing setups will continue to work.
>>>>>
>>>>> Implementing that SCLP thingy will avoid any warnings and any errors. It
>>>>> just works from the QEMU perspective.
>>>>>
>>>>> Is implementing this realistic?
>>>>
>>>> Yes it is but it will take time. I will try to get this rolling. To make
>>>> progress on the diag318 thing, can we error on startup now and simply
>>>> remove that check when when have implemented a larger sccb? If we would
>>>> now do all kinds of "change the max number games" would be harder to "fix".
>>>
>>>
>>> Another idea for temporary handling: Simply only indicate 240 CPUs to
>>> the guest if the response does not fit into a page. Once we have that
>>> SCLP thingy, this will be fixed. Guest migration back and forth should
>>> work, as the VCPUs are fully functional (and initially always stopped),
>>> the guest will simply not be able to detect them via SCLP when booting
>>> up, and therefore not use them.
>>
>> Yes, that looks like a good temporary solution. In fact if the guest relies
>> on simply probing it could even make use of the additional CPUs. Its just
>> the sclp response that is limited to 240 (or make it 247?)
> 
> I think the limiting factor was more than a single CPU, but I don't
> recall. We can do the math again and come up with the right number.

I think We need 8 byte per CPU. With byte 134 we should still be ok with
247. Collin can do the math in the patch description.


