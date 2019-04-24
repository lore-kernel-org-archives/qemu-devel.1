Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59ADC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 10:36:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7623E21773
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 10:36:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7623E21773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39268 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJFFw-0003zx-Mk
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 06:36:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJFDy-0002fD-Uu
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJF80-0005Qv-Eh
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:27:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hJF80-0005NK-5V; Wed, 24 Apr 2019 06:27:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE70930833C1;
	Wed, 24 Apr 2019 10:27:45 +0000 (UTC)
Received: from [10.36.116.45] (ovpn-116-45.ams2.redhat.com [10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A9BF460BE0;
	Wed, 24 Apr 2019 10:27:43 +0000 (UTC)
To: Christian Borntraeger <borntraeger@de.ibm.com>,
	=?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
	<d3cdd199-0457-7255-9540-2bbe5555e079@redhat.com>
	<a9e5863e-cb05-11a6-03a8-89ee45febcc9@de.ibm.com>
	<03eb94f6-6f8f-0358-df00-bc487e5e3bff@redhat.com>
	<20190424093014.GB31388@redhat.com>
	<d1db9861-f18d-0364-0a24-0697766f46b4@redhat.com>
	<20190424094120.GC31388@redhat.com>
	<49e2cd3d-ac11-b76d-1bf3-24908c0015c1@redhat.com>
	<4f3871ef-86a6-e6be-4e87-2affa3bd2d6f@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
	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
	SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <8d7716cf-95e5-4de9-8d31-f6b5ff88223f@redhat.com>
Date: Wed, 24 Apr 2019 12:27:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4f3871ef-86a6-e6be-4e87-2affa3bd2d6f@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Wed, 24 Apr 2019 10:27:45 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Message-ID: <20190424102742.GyVbXsjQJ10fL43f1yENIgIJK2itQRhLGt0W8VZZ1yY@z>

On 24.04.19 12:26, Christian Borntraeger wrote:
>=20
>=20
> On 24.04.19 11:56, David Hildenbrand wrote:
>> On 24.04.19 11:41, Daniel P. Berrang=C3=A9 wrote:
>>> On Wed, Apr 24, 2019 at 11:35:40AM +0200, David Hildenbrand wrote:
>>>> On 24.04.19 11:30, Daniel P. Berrang=C3=A9 wrote:
>>>>> On Wed, Apr 24, 2019 at 11:03:03AM +0200, David Hildenbrand wrote:
>>>>>> On 24.04.19 10:40, Christian Borntraeger wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 23.04.19 14:11, David Hildenbrand wrote:
>>>>>>>> On 18.04.19 13:31, Christian Borntraeger wrote:
>>>>>>>>> Adding generation 15.
>>>>>>>>>
>>>>>>>>> Some interesting aspects:
>>>>>>>>> - conditional SSKE and bpb are deprecated. This patch set addre=
sses that
>>>>>>>>>   for csske.
>>>>>>>>> - no name yet for gen15, I suggest to use the assigned numbers =
and
>>>>>>>>>   provide an alias later on. (I have split out this into a sepa=
rate
>>>>>>>>>   patch)
>>>>>>>>>
>>>>>>>>> Christian Borntraeger (10):
>>>>>>>>>   linux header sync
>>>>>>>>>   s390x/cpumodel: remove CSSKE from base model
>>>>>>>>>   s390x/cpumodel: Miscellaneous-Instruction-Extensions Facility=
 3
>>>>>>>>>   s390x/cpumodel: msa9 facility
>>>>>>>>>   s390x/cpumodel: vector enhancements
>>>>>>>>>   s390x/cpumodel: enhanced sort facility
>>>>>>>>>   s390x/cpumodel: deflate
>>>>>>>>>   s390x/cpumodel: add gen15 defintions
>>>>>>>>>   s390x/cpumodel: wire up 8561 and 8562 as gen15 machines
>>>>>>>>>   s390x/cpumodel: do not claim csske for expanded models in qmp
>>>>>>>>>
>>>>>>>>>  hw/s390x/s390-virtio-ccw.c      |  6 +++
>>>>>>>>>  linux-headers/asm-s390/kvm.h    |  5 +-
>>>>>>>>>  target/s390x/cpu_features.c     | 54 +++++++++++++++++++
>>>>>>>>>  target/s390x/cpu_features.h     |  3 ++
>>>>>>>>>  target/s390x/cpu_features_def.h | 49 +++++++++++++++++
>>>>>>>>>  target/s390x/cpu_models.c       | 35 ++++++++++++
>>>>>>>>>  target/s390x/cpu_models.h       |  1 +
>>>>>>>>>  target/s390x/gen-features.c     | 94 +++++++++++++++++++++++++=
+++++++-
>>>>>>>>>  target/s390x/kvm.c              | 18 +++++++
>>>>>>>>>  9 files changed, 263 insertions(+), 2 deletions(-)
>>>>>>>>>
>>>>>>>>
>>>>>>>> I guess to handle deprecation of CSSKE:
>>>>>>>>
>>>>>>>> 1. Remove it from the base + default model of the gen15, keep it=
 in the
>>>>>>>> max model. This is completely done in target/s390x/gen-features.=
c.
>>>>>>>> Existing base models are not modified.
>>>>>>>>
>>>>>>>> 2. Add CSSKE to "ignored_base_feat", so fallback of gen15 to e.g=
. z14
>>>>>>>> will work. We can backport this to distros/stable.
>>>>>>>
>>>>>>> Yes, I have already implemented that, still doing some testing an=
d polishinh.
>>>>>>>>
>>>>>>>>
>>>>>>>> CPU model expansion:
>>>>>>>>
>>>>>>>> cpu_info_from_model() should already properly be based on the ba=
se
>>>>>>>> features. "gen15" vs. "gen15,csske=3Don" should be automatically=
 generated
>>>>>>>> when expanding.
>>>>>>>>
>>>>>>>> CPU model baseline:
>>>>>>>>
>>>>>>>> s390_find_cpu_def() should make sure that CSSKE is basically ign=
ored
>>>>>>>> when determining maximum model, however it will properly be indi=
cated if
>>>>>>>> both models had the feature.
>>>>>>>>
>>>>>>>> CPU model comparison:
>>>>>>>>
>>>>>>>> Should work as expected. Availability of CSSKE will be considere=
d when
>>>>>>>> calculating the result.
>>>>>>>>
>>>>>>>> gen14,csske=3Don and gen15,csske=3Doff will result in
>>>>>>>> CPU_MODEL_COMPARE_RESULT_INCOMPATIBLE.
>>>>>>>>
>>>>>>>> gen14,csske=3Doff and gen15,csske=3Doff should result in
>>>>>>>> CPU_MODEL_COMPARE_RESULT_SUBSET
>>>>>>>>
>>>>>>>> gen14,csske=3Don and gen15,csske=3Don should result in
>>>>>>>> CPU_MODEL_COMPARE_RESULT_SUBSET
>>>>>>>>
>>>>>>>> Forward migration:
>>>>>>>>
>>>>>>>> Now, the only issue is when csske is actually turned of in futur=
e
>>>>>>>> machines. We would e.g. have
>>>>>>>>
>>>>>>>> gen15,csske=3Don and gen16,csske=3Doff
>>>>>>>>
>>>>>>>> While baselining will work correctly (gen15,csske=3Doff), forwar=
d
>>>>>>>> migration is broken (comparison will properly indicate
>>>>>>>> CPU_MODEL_COMPARE_RESULT_INCOMPATIBLE), which is expected when r=
ipping
>>>>>>>> out features. Same applies to BPB.
>>>>>>>>
>>>>>>>>
>>>>>>>> Your patch "[PATCH 10/10] s390x/cpumodel: do not claim csske for
>>>>>>>> expanded models in qmp" tried to address this, however I am not =
really
>>>>>>>> happy with this approach. We should not play such tricks when ex=
panding
>>>>>>>> the host model. "-cpu host" and "-cpu $expanded_host" would be
>>>>>>>> different,
>>>>>>>
>>>>>>> We discussed this some time ago and I think we agreed that for ho=
st passthrough
>>>>>>> it is ok to be different that host-model (e.g. passing through th=
e cpuid, passing
>>>>>>> through all non-hypervisor managed features etc).
>>>>>>
>>>>>> I remember the plan was to use the "max" model to do such stuff. E=
.g.
>>>>>> -cpu max / no -cpu
>>>>>>
>>>>>> Versus
>>>>>> -cpu host
>>>>>>
>>>>>> We can have features in "host" we don't have in "max". But "-cpu h=
ost"
>>>>>> and it's expansion should look 100% the same.
>>>>>
>>>>> I don't think that's the intended semantics of "max" vs "host".
>>>>>
>>>>> The "max" CPU model is supposed to enable all features that are pos=
sible to
>>>>> enable.
>>>>>
>>>>> For KVM, thus "max" should be identical to "host".
>>>>
>>>> There once was a mode used by x86-64 to simply pipe through cpuid
>>>> features that were not even supported. (I remember something like
>>>> passthorugh=3Dtrue), do you remember if something like that still ex=
ists?
>>>
>>> I don't recall such a feature existing even in the past !
>>
>> Maybe my mind is tricking me, or maybe that has long been removed :)
>>
>>>
>>>>> For TCG, "max" should be everything that QEMU currently knows how t=
o emulate.
>>>>
>>>> Yes, and on s390x. "max" contains more features than "qemu".
>>>>
>>>>>
>>>>> Essentially think of "max" as a better name for "host", since "host=
" as
>>>>> a name concept didn't make sense for TCG.
>>>>
>>>> I agree. The main question is, is it acceptable that
>>>
>>> Hmm, maybe I misinterpreted when you wrote
>>>
>>>       We can have features in "host" we don't have in "max"
>>>
>>> I read that as meaning that "-cpu host" and "-cpu max" would be
>>> different.
>>
>> No you didn't misinterpret it, I agreed after you spelled it out :)
>>
>>>
>>>> "-cpu host" and "-cpu $expanded_host" produce different results, aft=
er
>>>> expanding "host" via query-cpu-model-expansion?
>>>
>>> That has always been the case on x86-64, since it is not possible to =
set
>>> the level, xlevel, vendor, family, model & stepping properties via -c=
pu,
>>> only the feature flags.
>>
>> Fair enough, but the question is if we should mess with feature flags =
we
>> can indicate on that level.
>>
>> It would mean that on a specific host e.g.
>>
>> "-cpu gen15,csske=3Don" and "-cpu gen15,csske=3Doff"
>>
>> Would work. However, "host" model expansion would give us
>>
>> "-cpu gen15,csske=3Doff"
>>
>> So trying to e.g. do a query-cpu-model-comparison or
>> query-cpu-model-baseline against "host" and against the expanded host
>> model will produce different results.
>>
>> Libvirt could detect "-cpu gen14,csske=3Don" as not runnable on the ho=
st,
>> because comparing "-cpu gen14,csske=3Don" vs. "-cpu gen15,csske=3Doff"=
 would
>> be "incompatible". But running "-cpu gen14,csske=3Don" on the host wou=
ld
>> work perfectly fine.
>=20
> I would like to avoid special knowledge in libvirt (since we moved to h=
ave
> everything in qemu).=20
>=20
> A more complex idea would be to extend the qmp query with a list of dep=
recated
> features and libvirt could then disable that for expansion but allow it=
 for
> baselining.

That would fit in nicely into query-cpu-model-expansion. Nice idea.

--=20

Thanks,

David / dhildenb

