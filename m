Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F14EDC46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 21:42:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFB632133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 21:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFB632133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjVym-000569-NE
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 17:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49527)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hjVxW-0004ZT-8h
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 17:41:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hjVxV-0002e4-0q
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 17:41:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48550)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hjVxU-0002dk-OC
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 17:41:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9E0713082A8D;
 Fri,  5 Jul 2019 21:41:31 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 141592B593;
 Fri,  5 Jul 2019 21:41:30 +0000 (UTC)
Date: Fri, 5 Jul 2019 18:41:29 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190705214129.GH5198@habkost.net>
References: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
 <1562079681-19204-3-git-send-email-pbonzini@redhat.com>
 <20190705205228.GF5198@habkost.net>
 <2015601d-8979-e5d6-fb14-ed74dc420813@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2015601d-8979-e5d6-fb14-ed74dc420813@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 05 Jul 2019 21:41:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/7] target/i386: introduce generic feature
 dependency mechanism
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
Cc: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 05, 2019 at 11:12:11PM +0200, Paolo Bonzini wrote:
> On 05/07/19 22:52, Eduardo Habkost wrote:
> >> +typedef struct FeatureDep {
> >> +    uint16_t from, to;
> > 
> > Why uint16_t and not FeatureWord?
> 
> Ok.
> 
> >> +    uint64_t from_flag, to_flags;
> > 
> > There are other parts of the code that take a
> > FeatureWord/uint32_t pair (which will become uint64_t).  I'd wrap
> > this into a typedef.  I also miss documentation on the exact
> > meaning of those fields.
> > 
> >     typedef struct FeatureMask {
> >         FeatureWord w;
> >         uint64_t mask;
> >     };
> 
> Sounds good, I was optimizing the layout by putting small fields
> together.  Perhaps prematurely. :)
> 
> >> +    for (l = plus_features; l; l = l->next) {
> >> +        const char *prop = l->data;
> >> +        object_property_set_bool(OBJECT(cpu), true, prop, &local_err);
> >> +        if (local_err) {
> >> +            goto out;
> >> +        }
> >> +    }
> >> +
> >> +    for (l = minus_features; l; l = l->next) {
> >> +        const char *prop = l->data;
> >> +        object_property_set_bool(OBJECT(cpu), false, prop, &local_err);
> >> +        if (local_err) {
> >> +            goto out;
> >> +        }
> >> +    }
> > 
> > Maybe getting rid of plus_features/minus_features (as described
> > in the TODO comment below) will make things simpler.
> 
> This is just moving code.  I can look at getting rid of plus_features
> and minus_features but I was wary of the effects that global properties
> have on query_cpu_model_expansion.

Shouldn't be a problem, as query-cpu-model-expansion
documentation already advises against using "-cpu" when calling
it.


> 
> In any case, that would basically be rewriting "+foo" and "-foo" to
> "foo=on" and "foo=off" respectively, right?

I don't mean changing the command line interface, but just
changing the implementation of "+foo" and "-foo".

In theory the code was already fixed to make this safe, but I
agree this might be tricky.  Let's worry about
plus_features/minus_features later.


> 
> >> +
> >> +    for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
> >> +        FeatureDep *d = &feature_dependencies[i];
> >> +        if ((env->user_features[d->from] & d->from_flag) &&
> >> +            !(env->features[d->from] & d->from_flag)) {
> > 
> > Why does it matter if the feature was cleared explicitly by the
> > user?
> 
> Because the feature set of named CPU models should be internally
> consistent.  I thought of this mechanism as a quick "clean up user's
> choices" pass to avoid having to remember a multitude of VMX features,
> for example it makes "-cpu host,-rdtscp" just work.

If named CPU models are already consistent, ignoring
user_features shouldn't make a difference, right?  It would also
be a useful mechanism to detect inconsistencies in internal CPU
model definitions.

I don't understand why the user_features check would be necessary
to make "-cpu host,-rdtscp" work.

> 
> >> +            uint64_t unavailable_features = env->features[d->to] & d->to_flags;
> >> +
> >> +            /* Not an error unless the dependent feature was added explicitly.  */
> >> +            mark_unavailable_features(cpu, d->to, unavailable_features & env->user_features[d->to],
> >> +                                      "This feature depends on other features that were not requested");
> >> +
> >> +            /* Prevent adding the feature in the loop below.  */
> >> +            env->user_features[d->to] |= d->to_flags;
> >> +            env->features[d->to] &= ~d->to_flags;
> >> +        }
> >> +    }
> > 
> > Maybe move this entire block inside x86_cpu_filter_features()?
> 
> It has to be done before expansion, so that env->user_features is set
> properly before -cpu host is expanded.

I don't get it.  It looks like you only need env->user_features
to be set above because you are handling dependencies before
cpu->max_features is handled.

If you handle dependencies at x86_cpu_filter_features() instead
(after cpu->max_features was already handled), you don't even
need to worry about setting user_features.

> 
> Paolo
> 
> >> +
> >>      /*TODO: Now cpu->max_features doesn't overwrite features
> >>       * set using QOM properties, and we can convert
> >>       * plus_features & minus_features to global properties
> >> @@ -5106,22 +5143,6 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
> >>          }
> >>      }
> >>  
> >> -    for (l = plus_features; l; l = l->next) {
> >> -        const char *prop = l->data;
> >> -        object_property_set_bool(OBJECT(cpu), true, prop, &local_err);
> >> -        if (local_err) {
> >> -            goto out;
> >> -        }
> >> -    }
> >> -
> >> -    for (l = minus_features; l; l = l->next) {
> >> -        const char *prop = l->data;
> >> -        object_property_set_bool(OBJECT(cpu), false, prop, &local_err);
> >> -        if (local_err) {
> >> -            goto out;
> >> -        }
> >> -    }
> >> -
> >>      if (!kvm_enabled() || !cpu->expose_kvm) {
> >>          env->features[FEAT_KVM] = 0;
> >>      }
> >> -- 
> >> 1.8.3.1
> >>
> >>
> >>
> > 
> 

-- 
Eduardo

