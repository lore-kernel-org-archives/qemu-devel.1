Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F13EC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 18:32:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 455B9208C3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 18:32:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 455B9208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33337 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQFkM-0005WN-6y
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 14:32:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQFij-0004nC-98
	for qemu-devel@nongnu.org; Mon, 13 May 2019 14:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1hQFih-0000wT-UU
	for qemu-devel@nongnu.org; Mon, 13 May 2019 14:30:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>)
	id 1hQFie-0000tp-Kf; Mon, 13 May 2019 14:30:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E95062C976E;
	Mon, 13 May 2019 18:30:35 +0000 (UTC)
Received: from kamzik.brq.redhat.com (ovpn-116-151.ams2.redhat.com
	[10.36.116.151])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D71A10018E0;
	Mon, 13 May 2019 18:30:33 +0000 (UTC)
Date: Mon, 13 May 2019 20:30:30 +0200
From: Andrew Jones <drjones@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190513183030.aap4gsxm7rbbkrbj@kamzik.brq.redhat.com>
References: <20190512083624.8916-1-drjones@redhat.com>
	<20190512083624.8916-9-drjones@redhat.com>
	<87ftpie3k9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftpie3k9.fsf@dusky.pond.sub.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Mon, 13 May 2019 18:30:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 08/13] target/arm/monitor: Add
 query-sve-vector-lengths
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
	qemu-devel@nongnu.org, abologna@redhat.com, qemu-arm@nongnu.org,
	alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 13, 2019 at 06:12:38PM +0200, Markus Armbruster wrote:
> Andrew Jones <drjones@redhat.com> writes:
> 
> > Provide a QMP interface to query the supported SVE vector lengths.
> > A migratable guest will need to explicitly specify a valid set of
> > lengths on the command line and that set can be obtained from the
> > list returned with this QMP command.
> >
> > This patch only introduces the QMP command with the TCG implementation.
> > The result may not yet be correct for KVM. Following patches ensure
> > the KVM result is correct.
> >
> > Signed-off-by: Andrew Jones <drjones@redhat.com>
> > ---
> >  qapi/target.json     | 34 ++++++++++++++++++++++++
> >  target/arm/monitor.c | 62 ++++++++++++++++++++++++++++++++++++++++++++
> >  tests/qmp-cmd-test.c |  1 +
> >  3 files changed, 97 insertions(+)
> >
> > diff --git a/qapi/target.json b/qapi/target.json
> > index 1d4d54b6002e..ca1e85254780 100644
> > --- a/qapi/target.json
> > +++ b/qapi/target.json
> > @@ -397,6 +397,40 @@
> >  { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'],
> >    'if': 'defined(TARGET_ARM)' }
> >  
> > +##
> > +# @SVEVectorLengths:
> > +#
> > +# The struct contains a list of integers where each integer is a valid
> 
> Suggest to s/The struct contains/Contains/.

OK

> 
> > +# SVE vector length for a KVM guest on this host. The vector lengths
> > +# are in quadword (128-bit) units, e.g. '4' means 512 bits (64 bytes).
> 
> Any particular reason for counting quad-words instead of bytes, or
> perhaps bits?

It can be considered just bits here, but when set in sve-vls-map those
bits are chosen to mean quadwords as that allows us to get up to 8192-bit
vectors with a single 64-bit word. Maybe I should write more of that here
to clarify.

> 
> > +#
> > +# @vls:      list of vector lengths in quadwords.
> > +#
> > +# Since: 4.1
> > +##
> > +{ 'struct': 'SVEVectorLengths',
> > +  'data': { 'vls': ['int'] },
> > +  'if': 'defined(TARGET_ARM)' }
> > +
> > +##
> > +# @query-sve-vector-lengths:
> > +#
> > +# This command is ARM-only. It will return a list of SVEVectorLengths
> 
> No other target-specific command documents its target-specificness like
> this.  Suggest

Well, it's pretty similar to query-gic-capabilities, which is what I used
as a template, but I'm happy to change it to whatever you suggest :)

> 
>    # Query valid SVE vector length sets.
> 
> > +# objects. The list describes all valid SVE vector length sets.
> > +#
> > +# Returns: a list of SVEVectorLengths objects
> > +#
> > +# Since: 4.1
> > +#
> > +# -> { "execute": "query-sve-vector-lengths" }
> > +# <- { "return": [ { "vls": [ 1 ] },
> > +#                  { "vls": [ 1, 2 ] },
> > +#                  { "vls": [ 1, 2, 4 ] } ] }
> > +#
> > +##
> > +{ 'command': 'query-sve-vector-lengths', 'returns': ['SVEVectorLengths'],
> > +  'if': 'defined(TARGET_ARM)' }
> > +

Yup, will do

> >  ##
> >  # @CpuModelExpansionInfo:
> >  #
> > diff --git a/target/arm/monitor.c b/target/arm/monitor.c
> > index 41b32b94b258..8b2afa255c92 100644
> > --- a/target/arm/monitor.c
> > +++ b/target/arm/monitor.c
> > @@ -24,6 +24,7 @@
> >  #include "hw/boards.h"
> >  #include "kvm_arm.h"
> >  #include "qapi/qapi-commands-target.h"
> > +#include "monitor/hmp-target.h"
> 
> Uh, hmp-target.h when the patch is supposedly about QMP only...
> 
> >  
> >  static GICCapability *gic_cap_new(int version)
> >  {
> > @@ -82,3 +83,64 @@ GICCapabilityList *qmp_query_gic_capabilities(Error **errp)
> >  
> >      return head;
> >  }
> > +
> > +static SVEVectorLengths *qmp_sve_vls_get(void)
> > +{
> > +    CPUArchState *env = mon_get_cpu_env();
> 
> Aha, you need it for mon_get_cpu_env().
> 
> mon_get_cpu_env() returns the current monitor's current CPU.  This is an
> HMP thing, QMP commands should never access it.
> 
> Looks like you use it to find one of the CPUs, so you can access its
> ->sve_max_vq.
> 
> "One of the CPUs" smells odd: what if they aren't all the same?  Perhaps
> that can't happen.  I don't know, you tell me :)
> 
> If any CPU will do, what about simply using first_cpu?

first_cpu will work. We currently only allow the same vector length set
for all cpus. I'll change it and drop the HMP things.

> 
> > +    ARMCPU *cpu = arm_env_get_cpu(env);
> > +    SVEVectorLengths *vls = g_new(SVEVectorLengths, 1);
> > +    intList **v = &vls->vls;
> > +    int i;
> > +
> > +    if (cpu->sve_max_vq == 0) {
> > +        *v = g_new0(intList, 1); /* one vl of 0 means none supported */
> > +        return vls;
> > +    }
> > +
> > +    for (i = 1; i <= cpu->sve_max_vq; ++i) {
> > +        *v = g_new0(intList, 1);
> > +        (*v)->value = i;
> > +        v = &(*v)->next;
> > +    }
> 
> What this loop does is not immediately obvious.  I think you could use a
> function comment.

OK

> 
> > +
> > +    return vls;
> > +}
> > +
> > +static SVEVectorLengths *qmp_sve_vls_dup_and_truncate(SVEVectorLengths *vls)
> > +{
> > +    SVEVectorLengths *trunc_vls;
> > +    intList **v, *p = vls->vls;
> > +
> > +    if (!p->next) {
> > +        return NULL;
> > +    }
> > +
> > +    trunc_vls = g_new(SVEVectorLengths, 1);
> > +    v = &trunc_vls->vls;
> > +
> > +    for (; p->next; p = p->next) {
> > +        *v = g_new0(intList, 1);
> > +        (*v)->value = p->value;
> > +        v = &(*v)->next;
> > +    }
> > +
> > +    return trunc_vls;
> > +}
> 
> More so.

More OK :)

> 
> > +
> > +SVEVectorLengthsList *qmp_query_sve_vector_lengths(Error **errp)
> > +{
> > +    SVEVectorLengthsList *vls_list = g_new0(SVEVectorLengthsList, 1);
> > +    SVEVectorLengths *vls = qmp_sve_vls_get();
> > +
> > +    while (vls) {
> > +        vls_list->value = vls;
> > +        vls = qmp_sve_vls_dup_and_truncate(vls);
> > +        if (vls) {
> > +            SVEVectorLengthsList *next = vls_list;
> > +            vls_list = g_new0(SVEVectorLengthsList, 1);
> > +            vls_list->next = next;
> > +        }
> > +    }
> > +
> > +    return vls_list;
> > +}
> > diff --git a/tests/qmp-cmd-test.c b/tests/qmp-cmd-test.c
> > index 9f5228cd9951..3d714dbc6a4a 100644
> > --- a/tests/qmp-cmd-test.c
> > +++ b/tests/qmp-cmd-test.c
> > @@ -90,6 +90,7 @@ static bool query_is_blacklisted(const char *cmd)
> >          /* Success depends on target arch: */
> >          "query-cpu-definitions",  /* arm, i386, ppc, s390x */
> >          "query-gic-capabilities", /* arm */
> > +        "query-sve-vector-lengths", /* arm */
> >          /* Success depends on target-specific build configuration: */
> >          "query-pci",              /* CONFIG_PCI */
> >          /* Success depends on launching SEV guest */

Thanks,
drew

