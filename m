Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0286C282E1
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 10:41:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B39142084F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 10:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39142084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39386 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJFKr-0008DY-Uv
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 06:41:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJFFe-00044Y-11
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:35:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hJFFa-0005Zi-Fm
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 06:35:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>)
	id 1hJFFa-0005SO-4j; Wed, 24 Apr 2019 06:35:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C216D2DA988;
	Wed, 24 Apr 2019 10:35:27 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D2E6646DE;
	Wed, 24 Apr 2019 10:35:19 +0000 (UTC)
Date: Wed, 24 Apr 2019 11:35:15 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <20190424103515.GD31388@redhat.com>
References: <20190418113110.160664-1-borntraeger@de.ibm.com>
	<d3cdd199-0457-7255-9540-2bbe5555e079@redhat.com>
	<a9e5863e-cb05-11a6-03a8-89ee45febcc9@de.ibm.com>
	<03eb94f6-6f8f-0358-df00-bc487e5e3bff@redhat.com>
	<20190424093014.GB31388@redhat.com>
	<d1db9861-f18d-0364-0a24-0697766f46b4@redhat.com>
	<20190424094120.GC31388@redhat.com>
	<49e2cd3d-ac11-b76d-1bf3-24908c0015c1@redhat.com>
	<4f3871ef-86a6-e6be-4e87-2affa3bd2d6f@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <4f3871ef-86a6-e6be-4e87-2affa3bd2d6f@de.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 24 Apr 2019 10:35:27 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
	Collin Walling <walling@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
	qemu-s390x <qemu-s390x@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424103515.vpE59uE4L_q2raQBJVppS5Oa8r5jKbYpvpGi5XHpYl4@z>

On Wed, Apr 24, 2019 at 12:26:26PM +0200, Christian Borntraeger wrote:
>=20
>=20
> On 24.04.19 11:56, David Hildenbrand wrote:
> > On 24.04.19 11:41, Daniel P. Berrang=C3=A9 wrote:
> >> On Wed, Apr 24, 2019 at 11:35:40AM +0200, David Hildenbrand wrote:
> >>> On 24.04.19 11:30, Daniel P. Berrang=C3=A9 wrote:
> >>>> On Wed, Apr 24, 2019 at 11:03:03AM +0200, David Hildenbrand wrote:
> >>>>> On 24.04.19 10:40, Christian Borntraeger wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 23.04.19 14:11, David Hildenbrand wrote:
> >>>>>>> On 18.04.19 13:31, Christian Borntraeger wrote:
> >>>>>>>> Adding generation 15.
> >>>>>>>>
> >>>>>>>> Some interesting aspects:
> >>>>>>>> - conditional SSKE and bpb are deprecated. This patch set addr=
esses that
> >>>>>>>>   for csske.
> >>>>>>>> - no name yet for gen15, I suggest to use the assigned numbers=
 and
> >>>>>>>>   provide an alias later on. (I have split out this into a sep=
arate
> >>>>>>>>   patch)
> >>>>>>>>
> >>>>>>>> Christian Borntraeger (10):
> >>>>>>>>   linux header sync
> >>>>>>>>   s390x/cpumodel: remove CSSKE from base model
> >>>>>>>>   s390x/cpumodel: Miscellaneous-Instruction-Extensions Facilit=
y 3
> >>>>>>>>   s390x/cpumodel: msa9 facility
> >>>>>>>>   s390x/cpumodel: vector enhancements
> >>>>>>>>   s390x/cpumodel: enhanced sort facility
> >>>>>>>>   s390x/cpumodel: deflate
> >>>>>>>>   s390x/cpumodel: add gen15 defintions
> >>>>>>>>   s390x/cpumodel: wire up 8561 and 8562 as gen15 machines
> >>>>>>>>   s390x/cpumodel: do not claim csske for expanded models in qm=
p
> >>>>>>>>
> >>>>>>>>  hw/s390x/s390-virtio-ccw.c      |  6 +++
> >>>>>>>>  linux-headers/asm-s390/kvm.h    |  5 +-
> >>>>>>>>  target/s390x/cpu_features.c     | 54 +++++++++++++++++++
> >>>>>>>>  target/s390x/cpu_features.h     |  3 ++
> >>>>>>>>  target/s390x/cpu_features_def.h | 49 +++++++++++++++++
> >>>>>>>>  target/s390x/cpu_models.c       | 35 ++++++++++++
> >>>>>>>>  target/s390x/cpu_models.h       |  1 +
> >>>>>>>>  target/s390x/gen-features.c     | 94 ++++++++++++++++++++++++=
++++++++-
> >>>>>>>>  target/s390x/kvm.c              | 18 +++++++
> >>>>>>>>  9 files changed, 263 insertions(+), 2 deletions(-)
> >>>>>>>>
> >>>>>>>
> >>>>>>> I guess to handle deprecation of CSSKE:
> >>>>>>>
> >>>>>>> 1. Remove it from the base + default model of the gen15, keep i=
t in the
> >>>>>>> max model. This is completely done in target/s390x/gen-features=
.c.
> >>>>>>> Existing base models are not modified.
> >>>>>>>
> >>>>>>> 2. Add CSSKE to "ignored_base_feat", so fallback of gen15 to e.=
g. z14
> >>>>>>> will work. We can backport this to distros/stable.
> >>>>>>
> >>>>>> Yes, I have already implemented that, still doing some testing a=
nd polishinh.
> >>>>>>>
> >>>>>>>
> >>>>>>> CPU model expansion:
> >>>>>>>
> >>>>>>> cpu_info_from_model() should already properly be based on the b=
ase
> >>>>>>> features. "gen15" vs. "gen15,csske=3Don" should be automaticall=
y generated
> >>>>>>> when expanding.
> >>>>>>>
> >>>>>>> CPU model baseline:
> >>>>>>>
> >>>>>>> s390_find_cpu_def() should make sure that CSSKE is basically ig=
nored
> >>>>>>> when determining maximum model, however it will properly be ind=
icated if
> >>>>>>> both models had the feature.
> >>>>>>>
> >>>>>>> CPU model comparison:
> >>>>>>>
> >>>>>>> Should work as expected. Availability of CSSKE will be consider=
ed when
> >>>>>>> calculating the result.
> >>>>>>>
> >>>>>>> gen14,csske=3Don and gen15,csske=3Doff will result in
> >>>>>>> CPU_MODEL_COMPARE_RESULT_INCOMPATIBLE.
> >>>>>>>
> >>>>>>> gen14,csske=3Doff and gen15,csske=3Doff should result in
> >>>>>>> CPU_MODEL_COMPARE_RESULT_SUBSET
> >>>>>>>
> >>>>>>> gen14,csske=3Don and gen15,csske=3Don should result in
> >>>>>>> CPU_MODEL_COMPARE_RESULT_SUBSET
> >>>>>>>
> >>>>>>> Forward migration:
> >>>>>>>
> >>>>>>> Now, the only issue is when csske is actually turned of in futu=
re
> >>>>>>> machines. We would e.g. have
> >>>>>>>
> >>>>>>> gen15,csske=3Don and gen16,csske=3Doff
> >>>>>>>
> >>>>>>> While baselining will work correctly (gen15,csske=3Doff), forwa=
rd
> >>>>>>> migration is broken (comparison will properly indicate
> >>>>>>> CPU_MODEL_COMPARE_RESULT_INCOMPATIBLE), which is expected when =
ripping
> >>>>>>> out features. Same applies to BPB.
> >>>>>>>
> >>>>>>>
> >>>>>>> Your patch "[PATCH 10/10] s390x/cpumodel: do not claim csske fo=
r
> >>>>>>> expanded models in qmp" tried to address this, however I am not=
 really
> >>>>>>> happy with this approach. We should not play such tricks when e=
xpanding
> >>>>>>> the host model. "-cpu host" and "-cpu $expanded_host" would be
> >>>>>>> different,
> >>>>>>
> >>>>>> We discussed this some time ago and I think we agreed that for h=
ost passthrough
> >>>>>> it is ok to be different that host-model (e.g. passing through t=
he cpuid, passing
> >>>>>> through all non-hypervisor managed features etc).
> >>>>>
> >>>>> I remember the plan was to use the "max" model to do such stuff. =
E.g.
> >>>>> -cpu max / no -cpu
> >>>>>
> >>>>> Versus
> >>>>> -cpu host
> >>>>>
> >>>>> We can have features in "host" we don't have in "max". But "-cpu =
host"
> >>>>> and it's expansion should look 100% the same.
> >>>>
> >>>> I don't think that's the intended semantics of "max" vs "host".
> >>>>
> >>>> The "max" CPU model is supposed to enable all features that are po=
ssible to
> >>>> enable.
> >>>>
> >>>> For KVM, thus "max" should be identical to "host".
> >>>
> >>> There once was a mode used by x86-64 to simply pipe through cpuid
> >>> features that were not even supported. (I remember something like
> >>> passthorugh=3Dtrue), do you remember if something like that still e=
xists?
> >>
> >> I don't recall such a feature existing even in the past !
> >=20
> > Maybe my mind is tricking me, or maybe that has long been removed :)
> >=20
> >>
> >>>> For TCG, "max" should be everything that QEMU currently knows how =
to emulate.
> >>>
> >>> Yes, and on s390x. "max" contains more features than "qemu".
> >>>
> >>>>
> >>>> Essentially think of "max" as a better name for "host", since "hos=
t" as
> >>>> a name concept didn't make sense for TCG.
> >>>
> >>> I agree. The main question is, is it acceptable that
> >>
> >> Hmm, maybe I misinterpreted when you wrote
> >>
> >>       We can have features in "host" we don't have in "max"
> >>
> >> I read that as meaning that "-cpu host" and "-cpu max" would be
> >> different.
> >=20
> > No you didn't misinterpret it, I agreed after you spelled it out :)
> >=20
> >>
> >>> "-cpu host" and "-cpu $expanded_host" produce different results, af=
ter
> >>> expanding "host" via query-cpu-model-expansion?
> >>
> >> That has always been the case on x86-64, since it is not possible to=
 set
> >> the level, xlevel, vendor, family, model & stepping properties via -=
cpu,
> >> only the feature flags.
> >=20
> > Fair enough, but the question is if we should mess with feature flags=
 we
> > can indicate on that level.
> >=20
> > It would mean that on a specific host e.g.
> >=20
> > "-cpu gen15,csske=3Don" and "-cpu gen15,csske=3Doff"
> >=20
> > Would work. However, "host" model expansion would give us
> >=20
> > "-cpu gen15,csske=3Doff"
> >=20
> > So trying to e.g. do a query-cpu-model-comparison or
> > query-cpu-model-baseline against "host" and against the expanded host
> > model will produce different results.
> >=20
> > Libvirt could detect "-cpu gen14,csske=3Don" as not runnable on the h=
ost,
> > because comparing "-cpu gen14,csske=3Don" vs. "-cpu gen15,csske=3Doff=
" would
> > be "incompatible". But running "-cpu gen14,csske=3Don" on the host wo=
uld
> > work perfectly fine.
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

Funny that you mention deprecation with CPU features....

  https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03969.html

So that makes 4 things we want to report deprecation for. Devices,
machine types, cpu models and now cpu features.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

