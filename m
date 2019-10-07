Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A589AECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 794DA21721
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:42:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794DA21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHSLV-0005KK-Kh
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 08:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iHSKV-0004V0-Sb
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:41:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iHSKU-0000gO-IN
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:41:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57874)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1iHSKQ-0000ed-Ui; Mon, 07 Oct 2019 08:41:31 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3C28F10CC1EE;
 Mon,  7 Oct 2019 12:41:29 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13B63196B2;
 Mon,  7 Oct 2019 12:41:24 +0000 (UTC)
Date: Mon, 7 Oct 2019 14:41:22 +0200
From: Andrew Jones <drjones@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v5 4/9] target/arm/cpu64: max cpu: Introduce sve<N>
 properties
Message-ID: <20191007124122.wjrrrgmvnxvxg3r6@kamzik.brq.redhat.com>
References: <20191001125845.8793-1-drjones@redhat.com>
 <20191001125845.8793-5-drjones@redhat.com>
 <87d0f9j6lk.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87d0f9j6lk.fsf@linaro.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Mon, 07 Oct 2019 12:41:29 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, armbru@redhat.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, imammedo@redhat.com, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 07, 2019 at 09:35:35AM +0100, Alex Benn=E9e wrote:
>=20
> Andrew Jones <drjones@redhat.com> writes:
>=20
> > Introduce cpu properties to give fine control over SVE vector lengths=
.
> > We introduce a property for each valid length up to the current
> > maximum supported, which is 2048-bits. The properties are named, e.g.
> > sve128, sve256, sve384, sve512, ..., where the number is the number o=
f
> > bits. See the updates to docs/arm-cpu-features.rst for a description
> > of the semantics and for example uses.
> >
> > Note, as sve-max-vq is still present and we'd like to be able to
> > support qmp_query_cpu_model_expansion with guests launched with e.g.
> > -cpu max,sve-max-vq=3D8 on their command lines, then we do allow
> > sve-max-vq and sve<N> properties to be provided at the same time, but
> > this is not recommended, and is why sve-max-vq is not mentioned in th=
e
> > document.  If sve-max-vq is provided then it enables all lengths smal=
ler
> > than and including the max and disables all lengths larger. It also h=
as
> > the side-effect that no larger lengths may be enabled and that the ma=
x
> > itself cannot be disabled. Smaller non-power-of-two lengths may,
> > however, be disabled, e.g. -cpu max,sve-max-vq=3D4,sve384=3Doff provi=
des a
> > guest the vector lengths 128, 256, and 512 bits.
> >
> > This patch has been co-authored with Richard Henderson, who reworked
> > the target/arm/cpu64.c changes in order to push all the validation an=
d
> > auto-enabling/disabling steps into the finalizer, resulting in a nice
> > LOC reduction.
> >
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  docs/arm-cpu-features.rst | 168 +++++++++++++++++++++++++++++++--
> >  include/qemu/bitops.h     |   1 +
> >  target/arm/cpu.c          |  19 ++++
> >  target/arm/cpu.h          |  19 ++++
> >  target/arm/cpu64.c        | 192 ++++++++++++++++++++++++++++++++++++=
-
> >  target/arm/helper.c       |  10 +-
> >  target/arm/monitor.c      |  12 +++
> >  tests/arm-cpu-features.c  | 194 ++++++++++++++++++++++++++++++++++++=
++
> >  8 files changed, 606 insertions(+), 9 deletions(-)
> >
> > diff --git a/docs/arm-cpu-features.rst b/docs/arm-cpu-features.rst
> > index c79dcffb5556..2ea4d6e90c02 100644
> > --- a/docs/arm-cpu-features.rst
> > +++ b/docs/arm-cpu-features.rst
> > @@ -48,18 +48,31 @@ block in the script for usage) is used to issue t=
he QMP commands.
> >        (QEMU) query-cpu-model-expansion type=3Dfull model=3D{"name":"=
max"}
> >        { "return": {
> >          "model": { "name": "max", "props": {
> > -        "pmu": true, "aarch64": true
> > +        "sve1664": true, "pmu": true, "sve1792": true, "sve1920": tr=
ue,
> > +        "sve128": true, "aarch64": true, "sve1024": true, "sve": tru=
e,
> > +        "sve640": true, "sve768": true, "sve1408": true, "sve256": t=
rue,
> > +        "sve1152": true, "sve512": true, "sve384": true, "sve1536": =
true,
> > +        "sve896": true, "sve1280": true, "sve2048": true
>=20
> Does having a list of VL's not have implications for the versioning of
> the API? Do we need to tick a version each time a new vector length is
> added?
>

Versioning the set of cpu features a versioned machine type may enable is
a good idea, but I don't think we should add versioning to this API. Sinc=
e
it doesn't matter what gets returned by the expansion call as much as
whether or not it may be enabled, we can use both existence and permissio=
n
to control the enabling of features. And, we don't have to do it the same
way for all features. Here are some examples:

* The 'aarch64' feature doesn't exist on armv7 CPUs. So it can't be
  enabled there.

* The 'pmu' feature does exist on KVM armv7 CPUs, but KVM doesn't
  support it, so it can't be enabled there.

If we add features that could be enabled, but we don't want them to be
available to older machine types, then we can either ensure the CPU
property isn't added, or is removed, from the CPU model when that machine
type is in use, or we can add code to the enable function that fails
the enable when a machine type dependent condition check fails.

Does that answer the question?

Thanks,
drew

