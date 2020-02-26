Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80959C4BA21
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 20:02:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 529BC24653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 20:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 529BC24653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j72tT-0003QO-CH
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 15:02:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanb@linux.ibm.com>) id 1j72sg-0002s8-3s
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:02:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanb@linux.ibm.com>) id 1j72sf-0002yb-2M
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 15:02:06 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9938
 helo=mx0a-001b2d01.pphosted.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
 id 1j72sb-0002gl-FJ; Wed, 26 Feb 2020 15:02:02 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 01QJtadP058204; Wed, 26 Feb 2020 15:01:57 -0500
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ydqf7sgs1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2020 15:01:57 -0500
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 01QJtj97058584;
 Wed, 26 Feb 2020 15:01:57 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com
 [169.62.189.10])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ydqf7sgrb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2020 15:01:57 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
 by ppma02dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 01QK1L7l024900;
 Wed, 26 Feb 2020 20:01:56 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by ppma02dal.us.ibm.com with ESMTP id 2ydcmksqkq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Feb 2020 20:01:56 +0000
Received: from b03ledav003.gho.boulder.ibm.com
 (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 01QK1tGG40173834
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Feb 2020 20:01:55 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E3C3D6A051;
 Wed, 26 Feb 2020 20:01:54 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 310506A054;
 Wed, 26 Feb 2020 20:01:54 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
 Wed, 26 Feb 2020 20:01:53 +0000 (GMT)
Subject: Re: [PATCH v3 00/10] vTPM for aarch64
To: Auger Eric <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20200226102549.12158-1-eric.auger@redhat.com>
 <31e81f4b-ef00-692e-540f-ef3d9be5bb9a@linux.ibm.com>
 <22380cd3-b13e-aede-a7f5-158d86ca6136@redhat.com>
 <a8913524-4de3-dc0a-0b2c-2deb88c33859@linux.ibm.com>
 <df345076-8def-9ba5-6c11-2bcaa2293ca1@redhat.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <bf008b7d-e6dc-5eeb-03e0-a141db367b6d@linux.ibm.com>
Date: Wed, 26 Feb 2020 15:01:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <df345076-8def-9ba5-6c11-2bcaa2293ca1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.572
 definitions=2020-02-26_07:2020-02-26,
 2020-02-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002260121
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0b-001b2d01.pphosted.com id 01QJtadP058204
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
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
Cc: marcandre.lureau@redhat.com, lersek@redhat.com, ardb@kernel.org,
 philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/26/20 1:18 PM, Auger Eric wrote:
> Hi Stefan,
>
> On 2/26/20 6:53 PM, Stefan Berger wrote:
>> On 2/26/20 12:47 PM, Auger Eric wrote:
>>> Hi Stefan,
>>>
>>> On 2/26/20 2:32 PM, Stefan Berger wrote:
>>>> On 2/26/20 5:25 AM, Eric Auger wrote:
>>>>> This series adds the capability to instantiate an MMIO TPM TIS
>>>>> in ARM virt. It is candidate to qemu 5.0.
>>>> Looks good. Can you run the checkpatch script over the patches and
>>>> address the warnings?
>>>>
>>>>
>>> Thank you for you review!
>>>
>>> About warnings
>>>
>>> - There are warnings due to new files added but I think they all have=
 an
>>> entry in MAINTAINERS as wildcards are used.
>>>
>>> - In tpm: Add the SysBus TPM TIS device.
>>>  =C2=A0=C2=A0 There is line over 80 chars but I think it is fine
>>>
>>> #define TPM_TIS_SYSBUS(obj) OBJECT_CHECK(TPMStateSysBus, (obj),
>>> TYPE_TPM_TIS_SYSBUS)
>>
>> Ok, leave it as it is.
> and sorry, what about the comment style issues derived from existing fi=
les?
>
> "
> - test: tpm-tis: Get prepared to share tests between ISA and sysbus dev=
ices
> has lots of warnings due to old comment style being used in
> tests/qtest/tpm-tis-test.c. I did not fix the style issue because I jus=
t
> copy the code into tpm-tis-util.c
>
> Do you want me to fix them in the same patch, in a separate patch or
> ignore the style issue for now?


if you could fix them that would be great...


> "
>
> Thanks
>
> Eric
>
>
>>
>>  =C2=A0=C2=A0 Stefan
>>
>>


