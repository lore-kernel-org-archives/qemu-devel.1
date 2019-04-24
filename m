Received: from eggs.gnu.org ([209.51.188.92]:59892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJGPd-0005Rr-CE
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:50:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJGPb-000551-IJ
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:50:05 -0400
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
	<d3cdd199-0457-7255-9540-2bbe5555e079@redhat.com>
	<a9e5863e-cb05-11a6-03a8-89ee45febcc9@de.ibm.com>
	<03eb94f6-6f8f-0358-df00-bc487e5e3bff@redhat.com>
	<20190424093014.GB31388@redhat.com>
	<d1db9861-f18d-0364-0a24-0697766f46b4@redhat.com>
	<20190424094120.GC31388@redhat.com>
	<49e2cd3d-ac11-b76d-1bf3-24908c0015c1@redhat.com>
	<4f3871ef-86a6-e6be-4e87-2affa3bd2d6f@de.ibm.com>
	<8d7716cf-95e5-4de9-8d31-f6b5ff88223f@redhat.com>
	<1db08399-c9e0-3640-c505-545fc50378b2@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <5c739b44-e346-e603-0d07-fbdc05084974@redhat.com>
Date: Wed, 24 Apr 2019 13:49:59 +0200
MIME-Version: 1.0
In-Reply-To: <1db08399-c9e0-3640-c505-545fc50378b2@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 00/10] s390x: new guest features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "Jason J . Herne" <jjherne@linux.ibm.com>, Collin Walling <walling@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 24.04.19 12:38, Christian Borntraeger wrote:
>=20
>=20
> On 24.04.19 12:27, David Hildenbrand wrote:
>> On 24.04.19 12:26, Christian Borntraeger wrote:
>>>
>>>
>>> On 24.04.19 11:56, David Hildenbrand wrote:
>>>> On 24.04.19 11:41, Daniel P. Berrang=C3=A9 wrote:
>>>>> On Wed, Apr 24, 2019 at 11:35:40AM +0200, David Hildenbrand wrote:
>>>>>> On 24.04.19 11:30, Daniel P. Berrang=C3=A9 wrote:
>>>>>>> On Wed, Apr 24, 2019 at 11:03:03AM +0200, David Hildenbrand wrote=
:
>>>>>>>> On 24.04.19 10:40, Christian Borntraeger wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 23.04.19 14:11, David Hildenbrand wrote:
>>>>>>>>>> On 18.04.19 13:31, Christian Borntraeger wrote:
>>>>>>>>>>> Adding generation 15.
>>>>>>>>>>>
>>>>>>>>>>> Some interesting aspects:
>>>>>>>>>>> - conditional SSKE and bpb are deprecated. This patch set add=
resses that
>>>>>>>>>>>   for csske.
>>>>>>>>>>> - no name yet for gen15, I suggest to use the assigned number=
s and
>>>>>>>>>>>   provide an alias later on. (I have split out this into a se=
parate
>>>>>>>>>>>   patch)
>>>>>>>>>>>
>>>>>>>>>>> Christian Borntraeger (10):
>>>>>>>>>>>   linux header sync
>>>>>>>>>>>   s390x/cpumodel: remove CSSKE from base model
>>>>>>>>>>>   s390x/cpumodel: Miscellaneous-Instruction-Extensions Facili=
ty 3
>>>>>>>>>>>   s390x/cpumodel: msa9 facility
>>>>>>>>>>>   s390x/cpumodel: vector enhancements
>>>>>>>>>>>   s390x/cpumodel: enhanced sort facility
>>>>>>>>>>>   s390x/cpumodel: deflate
>>>>>>>>>>>   s390x/cpumodel: add gen15 defintions
>>>>>>>>>>>   s390x/cpumodel: wire up 8561 and 8562 as gen15 machines
>>>>>>>>>>>   s390x/cpumodel: do not claim csske for expanded models in q=
mp
>>>>>>>>>>>
>>>>>>>>>>>  hw/s390x/s390-virtio-ccw.c      |  6 +++
>>>>>>>>>>>  linux-headers/asm-s390/kvm.h    |  5 +-
>>>>>>>>>>>  target/s390x/cpu_features.c     | 54 +++++++++++++++++++
>>>>>>>>>>>  target/s390x/cpu_features.h     |  3 ++
>>>>>>>>>>>  target/s390x/cpu_features_def.h | 49 +++++++++++++++++
>>>>>>>>>>>  target/s390x/cpu_models.c       | 35 ++++++++++++
>>>>>>>>>>>  target/s390x/cpu_models.h       |  1 +
>>>>>>>>>>>  target/s390x/gen-features.c     | 94 +++++++++++++++++++++++=
+++++++++-
>>>>>>>>>>>  target/s390x/kvm.c              | 18 +++++++
>>>>>>>>>>>  9 files changed, 263 insertions(+), 2 deletions(-)
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I guess to handle deprecation of CSSKE:
>>>>>>>>>>
>>>>>>>>>> 1. Remove it from the base + default model of the gen15, keep =
it in the
>>>>>>>>>> max model. This is completely done in target/s390x/gen-feature=
s.c.
>>>>>>>>>> Existing base models are not modified.
>>>>>>>>>>
>>>>>>>>>> 2. Add CSSKE to "ignored_base_feat", so fallback of gen15 to e=
.g. z14
>>>>>>>>>> will work. We can backport this to distros/stable.
>>>>>>>>>
>>>>>>>>> Yes, I have already implemented that, still doing some testing =
and polishinh.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> CPU model expansion:
>>>>>>>>>>
>>>>>>>>>> cpu_info_from_model() should already properly be based on the =
base
>>>>>>>>>> features. "gen15" vs. "gen15,csske=3Don" should be automatical=
ly generated
>>>>>>>>>> when expanding.
>>>>>>>>>>
>>>>>>>>>> CPU model baseline:
>>>>>>>>>>
>>>>>>>>>> s390_find_cpu_def() should make sure that CSSKE is basically i=
gnored
>>>>>>>>>> when determining maximum model, however it will properly be in=
dicated if
>>>>>>>>>> both models had the feature.
>>>>>>>>>>
>>>>>>>>>> CPU model comparison:
>>>>>>>>>>
>>>>>>>>>> Should work as expected. Availability of CSSKE will be conside=
red when
>>>>>>>>>> calculating the result.
>>>>>>>>>>
>>>>>>>>>> gen14,csske=3Don and gen15,csske=3Doff will result in
>>>>>>>>>> CPU_MODEL_COMPARE_RESULT_INCOMPATIBLE.
>>>>>>>>>>
>>>>>>>>>> gen14,csske=3Doff and gen15,csske=3Doff should result in
>>>>>>>>>> CPU_MODEL_COMPARE_RESULT_SUBSET
>>>>>>>>>>
>>>>>>>>>> gen14,csske=3Don and gen15,csske=3Don should result in
>>>>>>>>>> CPU_MODEL_COMPARE_RESULT_SUBSET
>>>>>>>>>>
>>>>>>>>>> Forward migration:
>>>>>>>>>>
>>>>>>>>>> Now, the only issue is when csske is actually turned of in fut=
ure
>>>>>>>>>> machines. We would e.g. have
>>>>>>>>>>
>>>>>>>>>> gen15,csske=3Don and gen16,csske=3Doff
>>>>>>>>>>
>>>>>>>>>> While baselining will work correctly (gen15,csske=3Doff), forw=
ard
>>>>>>>>>> migration is broken (comparison will properly indicate
>>>>>>>>>> CPU_MODEL_COMPARE_RESULT_INCOMPATIBLE), which is expected when=
 ripping
>>>>>>>>>> out features. Same applies to BPB.
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Your patch "[PATCH 10/10] s390x/cpumodel: do not claim csske f=
or
>>>>>>>>>> expanded models in qmp" tried to address this, however I am no=
t really
>>>>>>>>>> happy with this approach. We should not play such tricks when =
expanding
>>>>>>>>>> the host model. "-cpu host" and "-cpu $expanded_host" would be
>>>>>>>>>> different,
>>>>>>>>>
>>>>>>>>> We discussed this some time ago and I think we agreed that for =
host passthrough
>>>>>>>>> it is ok to be different that host-model (e.g. passing through =
the cpuid, passing
>>>>>>>>> through all non-hypervisor managed features etc).
>>>>>>>>
>>>>>>>> I remember the plan was to use the "max" model to do such stuff.=
 E.g.
>>>>>>>> -cpu max / no -cpu
>>>>>>>>
>>>>>>>> Versus
>>>>>>>> -cpu host
>>>>>>>>
>>>>>>>> We can have features in "host" we don't have in "max". But "-cpu=
 host"
>>>>>>>> and it's expansion should look 100% the same.
>>>>>>>
>>>>>>> I don't think that's the intended semantics of "max" vs "host".
>>>>>>>
>>>>>>> The "max" CPU model is supposed to enable all features that are p=
ossible to
>>>>>>> enable.
>>>>>>>
>>>>>>> For KVM, thus "max" should be identical to "host".
>>>>>>
>>>>>> There once was a mode used by x86-64 to simply pipe through cpuid
>>>>>> features that were not even supported. (I remember something like
>>>>>> passthorugh=3Dtrue), do you remember if something like that still =
exists?
>>>>>
>>>>> I don't recall such a feature existing even in the past !
>>>>
>>>> Maybe my mind is tricking me, or maybe that has long been removed :)
>>>>
>>>>>
>>>>>>> For TCG, "max" should be everything that QEMU currently knows how=
 to emulate.
>>>>>>
>>>>>> Yes, and on s390x. "max" contains more features than "qemu".
>>>>>>
>>>>>>>
>>>>>>> Essentially think of "max" as a better name for "host", since "ho=
st" as
>>>>>>> a name concept didn't make sense for TCG.
>>>>>>
>>>>>> I agree. The main question is, is it acceptable that
>>>>>
>>>>> Hmm, maybe I misinterpreted when you wrote
>>>>>
>>>>>       We can have features in "host" we don't have in "max"
>>>>>
>>>>> I read that as meaning that "-cpu host" and "-cpu max" would be
>>>>> different.
>>>>
>>>> No you didn't misinterpret it, I agreed after you spelled it out :)
>>>>
>>>>>
>>>>>> "-cpu host" and "-cpu $expanded_host" produce different results, a=
fter
>>>>>> expanding "host" via query-cpu-model-expansion?
>>>>>
>>>>> That has always been the case on x86-64, since it is not possible t=
o set
>>>>> the level, xlevel, vendor, family, model & stepping properties via =
-cpu,
>>>>> only the feature flags.
>>>>
>>>> Fair enough, but the question is if we should mess with feature flag=
s we
>>>> can indicate on that level.
>>>>
>>>> It would mean that on a specific host e.g.
>>>>
>>>> "-cpu gen15,csske=3Don" and "-cpu gen15,csske=3Doff"
>>>>
>>>> Would work. However, "host" model expansion would give us
>>>>
>>>> "-cpu gen15,csske=3Doff"
>>>>
>>>> So trying to e.g. do a query-cpu-model-comparison or
>>>> query-cpu-model-baseline against "host" and against the expanded hos=
t
>>>> model will produce different results.
>>>>
>>>> Libvirt could detect "-cpu gen14,csske=3Don" as not runnable on the =
host,
>>>> because comparing "-cpu gen14,csske=3Don" vs. "-cpu gen15,csske=3Dof=
f" would
>>>> be "incompatible". But running "-cpu gen14,csske=3Don" on the host w=
ould
>>>> work perfectly fine.
>>>
>>> I would like to avoid special knowledge in libvirt (since we moved to=
 have
>>> everything in qemu).=20
>>>
>>> A more complex idea would be to extend the qmp query with a list of d=
eprecated
>>> features and libvirt could then disable that for expansion but allow =
it for
>>> baselining.
>>
>> That would fit in nicely into query-cpu-model-expansion. Nice idea.
>=20
> Hmm, I think that should also be possible as an add-on patch series lat=
er on
> (e.g. in 6 month or so). We would have instances of gen15 machines with=
 host-model
> that start with csske but sooner or later they will be restarted and th=
en they no=20
> longer have csske.
> As we do not change anything for baselining this would allow us to sepa=
rate patch10
> from the other patches and deal with it later with a proper series on i=
ts on?
> Need to think about that.

Makes sense, we already have forward migration issues to > gen15 with
guests started in the past when dropping features. No need to rush with
that.

--=20

Thanks,

David / dhildenb
