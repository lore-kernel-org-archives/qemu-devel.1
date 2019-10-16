Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590B5C4360C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 08:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E78F2064B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 08:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E78F2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKePZ-0002XM-Ae
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 04:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44063)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iKeOl-00022E-TH
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iKeOk-000192-FP
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 04:11:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47936)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1iKeOf-00017E-No; Wed, 16 Oct 2019 04:11:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3D9023082B41;
 Wed, 16 Oct 2019 08:11:04 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5ABE5D9CD;
 Wed, 16 Oct 2019 08:10:59 +0000 (UTC)
Date: Wed, 16 Oct 2019 10:10:57 +0200
From: Andrew Jones <drjones@redhat.com>
To: Beata Michalska <beata.michalska@linaro.org>
Subject: Re: [PATCH v5 4/9] target/arm/cpu64: max cpu: Introduce sve<N>
 properties
Message-ID: <20191016081057.svdt6uvftshzzjkr@kamzik.brq.redhat.com>
References: <20191001125845.8793-1-drjones@redhat.com>
 <20191001125845.8793-5-drjones@redhat.com>
 <CADSWDzu2mUvTDYJj42747DgBAzWRDoMQRNgtepqyvv23OArHNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADSWDzu2mUvTDYJj42747DgBAzWRDoMQRNgtepqyvv23OArHNQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 16 Oct 2019 08:11:04 +0000 (UTC)
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 armbru@redhat.com, eric.auger@redhat.com, qemu-arm@nongnu.org,
 imammedo@redhat.com, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 09, 2019 at 03:01:15PM +0100, Beata Michalska wrote:
> On Tue, 1 Oct 2019 at 14:04, Andrew Jones <drjones@redhat.com> wrote:
> >
> > Introduce cpu properties to give fine control over SVE vector lengths.
> > We introduce a property for each valid length up to the current
> > maximum supported, which is 2048-bits. The properties are named, e.g.
> > sve128, sve256, sve384, sve512, ..., where the number is the number of
> > bits. See the updates to docs/arm-cpu-features.rst for a description
> > of the semantics and for example uses.
> >
> > Note, as sve-max-vq is still present and we'd like to be able to
> > support qmp_query_cpu_model_expansion with guests launched with e.g.
> > -cpu max,sve-max-vq=8 on their command lines, then we do allow
> > sve-max-vq and sve<N> properties to be provided at the same time, but
> > this is not recommended, and is why sve-max-vq is not mentioned in the
> > document.  If sve-max-vq is provided then it enables all lengths smaller
> > than and including the max and disables all lengths larger. It also has
> > the side-effect that no larger lengths may be enabled and that the max
> > itself cannot be disabled. Smaller non-power-of-two lengths may,
> > however, be disabled, e.g. -cpu max,sve-max-vq=4,sve384=off provides a
> > guest the vector lengths 128, 256, and 512 bits.
> >
> > This patch has been co-authored with Richard Henderson, who reworked
> > the target/arm/cpu64.c changes in order to push all the validation and
> > auto-enabling/disabling steps into the finalizer, resulting in a nice
> > LOC reduction.
> >
> 
> I have most probably missed part of previous discussions around the vector
> lengths  so apologies if the question is not relevant anymore  but ...
> why the idea of having bitmap representation for those has been dropped ?

https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03439.html

> Although the proposed solution provides indeed fine control over the vector
> lengths it also adds extra logic for handling corner cases and makes specifying
> those on the command line rather cumbersome in some cases.

Examples?

> What if we could re-consider bitmaps and add an option for sve with a 'help'
> switch to query available options and present them (or just a subset
> as an example)
> with additional information on how to interpret/modify it ? Smth like :
>            -cpu max,sve=help
> which would print the bitmap of available lengths with note on what each bit
> represents and which ones can be modified .
> Than it should be pretty straightforward to enable/disable selected lengths.
> This could potentially simplify things a bit....
> 

I won't be re-considering bitmaps, but arm is in need of better help text
for the cpu option. qemu-system-aarch64 -M virt -cpu help only produces a
list of available CPUs, which don't have descriptions. When checking '-cpu
help' on x86 we get descriptions, and we get another section "Recognized
CPUID flags". After this series is applied we could perhaps add a
"Recognized CPU features" section to arm's '-cpu help'. I don't intend
to do that myself, but I'll take a look at whatever you post :-)

Thanks,
drew

