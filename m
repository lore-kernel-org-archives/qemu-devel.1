Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78457C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 10:35:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1C321773
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 10:35:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1C321773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39266 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJFFo-0003ua-E9
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 06:35:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hJFE0-0002eh-0X
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:34:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1hJF6u-00038d-Gl
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:26:42 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52270
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1hJF6q-0002wP-QP
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:26:37 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3OAP7ds093687
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:26:33 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2s2n3fb21a-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:26:33 -0400
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 24 Apr 2019 11:26:31 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
	by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway:
	Authorized Use Only! Violators will be prosecuted; 
	(version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
	Wed, 24 Apr 2019 11:26:28 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com
	[9.149.105.232])
	by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id x3OAQQBt11337814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK); Wed, 24 Apr 2019 10:26:26 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B990C52051;
	Wed, 24 Apr 2019 10:26:26 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.152.224.133])
	by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 612A75204F;
	Wed, 24 Apr 2019 10:26:26 +0000 (GMT)
To: David Hildenbrand <david@redhat.com>,
	=?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
	<d3cdd199-0457-7255-9540-2bbe5555e079@redhat.com>
	<a9e5863e-cb05-11a6-03a8-89ee45febcc9@de.ibm.com>
	<03eb94f6-6f8f-0358-df00-bc487e5e3bff@redhat.com>
	<20190424093014.GB31388@redhat.com>
	<d1db9861-f18d-0364-0a24-0697766f46b4@redhat.com>
	<20190424094120.GC31388@redhat.com>
	<49e2cd3d-ac11-b76d-1bf3-24908c0015c1@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
	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
	syiRa+UVlsKmx1hsEg==
Date: Wed, 24 Apr 2019 12:26:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <49e2cd3d-ac11-b76d-1bf3-24908c0015c1@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19042410-0012-0000-0000-00000312F37B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19042410-0013-0000-0000-0000214B4848
Message-Id: <4f3871ef-86a6-e6be-4e87-2affa3bd2d6f@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
	definitions=2019-04-24_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
	priorityscore=1501
	malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
	clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
	mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
	scancount=1 engine=8.0.1-1810050000 definitions=main-1904240086
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
	mx0b-001b2d01.pphosted.com id x3OAP7ds093687
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.158.5
Subject: Re: [Qemu-devel] [PATCH 00/10] s390x: new guest features
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
	Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
	qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424102626.qWBFWOLmXGwnyIzt-P5ckohrMp55bSbA6E0jejJTLlk@z>



On 24.04.19 11:56, David Hildenbrand wrote:
> On 24.04.19 11:41, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, Apr 24, 2019 at 11:35:40AM +0200, David Hildenbrand wrote:
>>> On 24.04.19 11:30, Daniel P. Berrang=C3=A9 wrote:
>>>> On Wed, Apr 24, 2019 at 11:03:03AM +0200, David Hildenbrand wrote:
>>>>> On 24.04.19 10:40, Christian Borntraeger wrote:
>>>>>>
>>>>>>
>>>>>> On 23.04.19 14:11, David Hildenbrand wrote:
>>>>>>> On 18.04.19 13:31, Christian Borntraeger wrote:
>>>>>>>> Adding generation 15.
>>>>>>>>
>>>>>>>> Some interesting aspects:
>>>>>>>> - conditional SSKE and bpb are deprecated. This patch set addres=
ses that
>>>>>>>>   for csske.
>>>>>>>> - no name yet for gen15, I suggest to use the assigned numbers a=
nd
>>>>>>>>   provide an alias later on. (I have split out this into a separ=
ate
>>>>>>>>   patch)
>>>>>>>>
>>>>>>>> Christian Borntraeger (10):
>>>>>>>>   linux header sync
>>>>>>>>   s390x/cpumodel: remove CSSKE from base model
>>>>>>>>   s390x/cpumodel: Miscellaneous-Instruction-Extensions Facility =
3
>>>>>>>>   s390x/cpumodel: msa9 facility
>>>>>>>>   s390x/cpumodel: vector enhancements
>>>>>>>>   s390x/cpumodel: enhanced sort facility
>>>>>>>>   s390x/cpumodel: deflate
>>>>>>>>   s390x/cpumodel: add gen15 defintions
>>>>>>>>   s390x/cpumodel: wire up 8561 and 8562 as gen15 machines
>>>>>>>>   s390x/cpumodel: do not claim csske for expanded models in qmp
>>>>>>>>
>>>>>>>>  hw/s390x/s390-virtio-ccw.c      |  6 +++
>>>>>>>>  linux-headers/asm-s390/kvm.h    |  5 +-
>>>>>>>>  target/s390x/cpu_features.c     | 54 +++++++++++++++++++
>>>>>>>>  target/s390x/cpu_features.h     |  3 ++
>>>>>>>>  target/s390x/cpu_features_def.h | 49 +++++++++++++++++
>>>>>>>>  target/s390x/cpu_models.c       | 35 ++++++++++++
>>>>>>>>  target/s390x/cpu_models.h       |  1 +
>>>>>>>>  target/s390x/gen-features.c     | 94 ++++++++++++++++++++++++++=
++++++-
>>>>>>>>  target/s390x/kvm.c              | 18 +++++++
>>>>>>>>  9 files changed, 263 insertions(+), 2 deletions(-)
>>>>>>>>
>>>>>>>
>>>>>>> I guess to handle deprecation of CSSKE:
>>>>>>>
>>>>>>> 1. Remove it from the base + default model of the gen15, keep it =
in the
>>>>>>> max model. This is completely done in target/s390x/gen-features.c.
>>>>>>> Existing base models are not modified.
>>>>>>>
>>>>>>> 2. Add CSSKE to "ignored_base_feat", so fallback of gen15 to e.g.=
 z14
>>>>>>> will work. We can backport this to distros/stable.
>>>>>>
>>>>>> Yes, I have already implemented that, still doing some testing and=
 polishinh.
>>>>>>>
>>>>>>>
>>>>>>> CPU model expansion:
>>>>>>>
>>>>>>> cpu_info_from_model() should already properly be based on the bas=
e
>>>>>>> features. "gen15" vs. "gen15,csske=3Don" should be automatically =
generated
>>>>>>> when expanding.
>>>>>>>
>>>>>>> CPU model baseline:
>>>>>>>
>>>>>>> s390_find_cpu_def() should make sure that CSSKE is basically igno=
red
>>>>>>> when determining maximum model, however it will properly be indic=
ated if
>>>>>>> both models had the feature.
>>>>>>>
>>>>>>> CPU model comparison:
>>>>>>>
>>>>>>> Should work as expected. Availability of CSSKE will be considered=
 when
>>>>>>> calculating the result.
>>>>>>>
>>>>>>> gen14,csske=3Don and gen15,csske=3Doff will result in
>>>>>>> CPU_MODEL_COMPARE_RESULT_INCOMPATIBLE.
>>>>>>>
>>>>>>> gen14,csske=3Doff and gen15,csske=3Doff should result in
>>>>>>> CPU_MODEL_COMPARE_RESULT_SUBSET
>>>>>>>
>>>>>>> gen14,csske=3Don and gen15,csske=3Don should result in
>>>>>>> CPU_MODEL_COMPARE_RESULT_SUBSET
>>>>>>>
>>>>>>> Forward migration:
>>>>>>>
>>>>>>> Now, the only issue is when csske is actually turned of in future
>>>>>>> machines. We would e.g. have
>>>>>>>
>>>>>>> gen15,csske=3Don and gen16,csske=3Doff
>>>>>>>
>>>>>>> While baselining will work correctly (gen15,csske=3Doff), forward
>>>>>>> migration is broken (comparison will properly indicate
>>>>>>> CPU_MODEL_COMPARE_RESULT_INCOMPATIBLE), which is expected when ri=
pping
>>>>>>> out features. Same applies to BPB.
>>>>>>>
>>>>>>>
>>>>>>> Your patch "[PATCH 10/10] s390x/cpumodel: do not claim csske for
>>>>>>> expanded models in qmp" tried to address this, however I am not r=
eally
>>>>>>> happy with this approach. We should not play such tricks when exp=
anding
>>>>>>> the host model. "-cpu host" and "-cpu $expanded_host" would be
>>>>>>> different,
>>>>>>
>>>>>> We discussed this some time ago and I think we agreed that for hos=
t passthrough
>>>>>> it is ok to be different that host-model (e.g. passing through the=
 cpuid, passing
>>>>>> through all non-hypervisor managed features etc).
>>>>>
>>>>> I remember the plan was to use the "max" model to do such stuff. E.=
g.
>>>>> -cpu max / no -cpu
>>>>>
>>>>> Versus
>>>>> -cpu host
>>>>>
>>>>> We can have features in "host" we don't have in "max". But "-cpu ho=
st"
>>>>> and it's expansion should look 100% the same.
>>>>
>>>> I don't think that's the intended semantics of "max" vs "host".
>>>>
>>>> The "max" CPU model is supposed to enable all features that are poss=
ible to
>>>> enable.
>>>>
>>>> For KVM, thus "max" should be identical to "host".
>>>
>>> There once was a mode used by x86-64 to simply pipe through cpuid
>>> features that were not even supported. (I remember something like
>>> passthorugh=3Dtrue), do you remember if something like that still exi=
sts?
>>
>> I don't recall such a feature existing even in the past !
>=20
> Maybe my mind is tricking me, or maybe that has long been removed :)
>=20
>>
>>>> For TCG, "max" should be everything that QEMU currently knows how to=
 emulate.
>>>
>>> Yes, and on s390x. "max" contains more features than "qemu".
>>>
>>>>
>>>> Essentially think of "max" as a better name for "host", since "host"=
 as
>>>> a name concept didn't make sense for TCG.
>>>
>>> I agree. The main question is, is it acceptable that
>>
>> Hmm, maybe I misinterpreted when you wrote
>>
>>       We can have features in "host" we don't have in "max"
>>
>> I read that as meaning that "-cpu host" and "-cpu max" would be
>> different.
>=20
> No you didn't misinterpret it, I agreed after you spelled it out :)
>=20
>>
>>> "-cpu host" and "-cpu $expanded_host" produce different results, afte=
r
>>> expanding "host" via query-cpu-model-expansion?
>>
>> That has always been the case on x86-64, since it is not possible to s=
et
>> the level, xlevel, vendor, family, model & stepping properties via -cp=
u,
>> only the feature flags.
>=20
> Fair enough, but the question is if we should mess with feature flags w=
e
> can indicate on that level.
>=20
> It would mean that on a specific host e.g.
>=20
> "-cpu gen15,csske=3Don" and "-cpu gen15,csske=3Doff"
>=20
> Would work. However, "host" model expansion would give us
>=20
> "-cpu gen15,csske=3Doff"
>=20
> So trying to e.g. do a query-cpu-model-comparison or
> query-cpu-model-baseline against "host" and against the expanded host
> model will produce different results.
>=20
> Libvirt could detect "-cpu gen14,csske=3Don" as not runnable on the hos=
t,
> because comparing "-cpu gen14,csske=3Don" vs. "-cpu gen15,csske=3Doff" =
would
> be "incompatible". But running "-cpu gen14,csske=3Don" on the host woul=
d
> work perfectly fine.

I would like to avoid special knowledge in libvirt (since we moved to hav=
e
everything in qemu).=20

A more complex idea would be to extend the qmp query with a list of depre=
cated
features and libvirt could then disable that for expansion but allow it f=
or
baselining.

>=20
>=20
> https://wiki.qemu.org/index.php/Features/CPUModels
>=20
> "-cpu host vs -cpu best" is an outdated but interesting read.
> -> "-cpu host will be the "all-you-can-enable" mode"
> -> "We're not going to have a mode for match-host-CPU, probably "
> -> "A "best-predefined-model" mode can be implemented by libvirt. "
>=20
> Sounds to me, that at least here, the issue should be sorted out either
> using a new cpu model type or on the libvirt level.
>=20
> "Feature deprecated and will be removed soon, remove it from the host
> cpu model list if gen15 is used when setting up a new machine".
>=20
>>
>> Regards,
>> Daniel
>>
>=20
>=20


