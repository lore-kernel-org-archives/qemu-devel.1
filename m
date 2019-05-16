Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0EFC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD7402082E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 14:12:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD7402082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58778 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRH7I-0008Nb-Uk
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 10:12:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hRH62-0007Jy-80
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:10:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hRH61-0005F3-0F
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:10:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hRH60-00055A-Lv
	for qemu-devel@nongnu.org; Thu, 16 May 2019 10:10:56 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x4GE3aZj104818
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 10:10:50 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2sh92s12dm-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 10:10:50 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 16 May 2019 15:10:48 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
	by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Thu, 16 May 2019 15:10:43 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com
	[9.149.105.61])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x4GEAggm52166774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Thu, 16 May 2019 14:10:42 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35D3111C052;
	Thu, 16 May 2019 14:10:42 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDD8F11C054;
	Thu, 16 May 2019 14:10:41 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.98.31])
	by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
	Thu, 16 May 2019 14:10:41 +0000 (GMT)
To: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
	David Hildenbrand <david@redhat.com>
References: <1556749903-19221-1-git-send-email-walling@linux.ibm.com>
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
	<c4704f1e-34fe-6c69-8532-6ee1e9cb4bdf@linux.ibm.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
	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
	syiRa+UVlsKmx1hsEg==
Date: Thu, 16 May 2019 16:10:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c4704f1e-34fe-6c69-8532-6ee1e9cb4bdf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19051614-0016-0000-0000-0000027C6457
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051614-0017-0000-0000-000032D93B9B
Message-Id: <ef15cf23-064f-8562-ae16-db141fae92b9@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-05-16_12:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1905160092
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
	mx0a-001b2d01.pphosted.com id x4GE3aZj104818
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
	qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 16.05.19 15:35, Collin Walling wrote:
> On 5/14/19 5:30 AM, Cornelia Huck wrote:
>> On Tue, 14 May 2019 11:27:32 +0200
>> David Hildenbrand <david@redhat.com> wrote:
>>
>>> On 14.05.19 11:25, Christian Borntraeger wrote:
>>>>
>>>>
>>>> On 14.05.19 11:23, Christian Borntraeger wrote:
>>>>>
>>>>>
>>>>> On 14.05.19 11:20, David Hildenbrand wrote:
>>>>>> On 14.05.19 11:10, Christian Borntraeger wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 14.05.19 10:59, David Hildenbrand wrote:
>>
>>>>>>>> We can
>>>>>>>>
>>>>>>>> 1. Fail to start with #cpus > 240 when diag318=3Don
>>>>>>>> 2. Remove the error once we support more than one SCLP response =
page
>>>>>>>>
>>>>>>>> Or
>>>>>>>> b
>>>>>>>> 1. Allow to start with #cpus > 240 when diag318=3Don, but indica=
te only
>>>>>>>> =C2=A0=C2=A0=C2=A0 240 CPUs via SCLP
>>>>>>>> 2. Print a warning
>>>>>>>> 3. Remove the restriction and the warning once we support more t=
han one
>>>>>>>> =C2=A0=C2=A0=C2=A0 SCLP response page
>>>>>>>>
>>>>>>>> While I prefer the second approach (similar to defining zPCI dev=
ices
>>>>>>>> without zpci=3Don), I could also live with the first approach.
>>>>>>>
>>>>>>> I prefer approach 1.
>>>>>>> =C2=A0=20
>>>>>>
>>>>>> Isn't approach #2 what we discussed (limiting sclp, but of course =
to 247
>>>>>> CPUs), but with an additional warning? I'm confused.
>>>>>
>>>>> Different numbering interpretion. I was talking about 1 =3D "Allow =
to start with #cpus > 240 when diag318=3Don, but indicate only
>>>>> 240 CPUs via SCLP"
>>>>
>>>> So yes, variant 2 when I use your numbering. The only question is: d=
o we need
>>>> a warning? It probably does not hurt.
>>>
>>> After all, we are talking about 1 VCPU that the guest can only use by
>>> indirect probing ... I leave that up to Collin :)
>>
>> I'd prefer a warning... even if it is a corner case, I think it's
>> better to be explicit instead of silent.
>>
>=20
> Thanks for the discussion. I'll implement diag318 as a CPU feature agai=
n
> and adjust the max_cpu handling (to 247 now instead of 240).

Well, max cpu is 248, we decided to just not report cpus > 247 to the gue=
st via
sclp.
>=20
> Question: should diag318 be enabled by default for current CPU models?
> What should we do in the case where diag318=3Don but KVM does not suppo=
rt
> handling?

Lets keep it in the full model for now. we can change that later on.
>=20
> I am not familiar with how close QEMU and KVM versions stay in sync.


