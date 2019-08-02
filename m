Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6444C32753
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:50:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83DB120679
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 09:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DB120679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htUCp-0007Yi-SV
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 05:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57619)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1htUCN-0006z8-Fn
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1htUCL-0000XM-UP
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:50:07 -0400
Received: from 17.mo3.mail-out.ovh.net ([87.98.178.58]:44822)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1htUCL-0000Tg-OX
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 05:50:05 -0400
Received: from player159.ha.ovh.net (unknown [10.109.160.244])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id F325821FEAD
 for <qemu-devel@nongnu.org>; Fri,  2 Aug 2019 11:49:56 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player159.ha.ovh.net (Postfix) with ESMTPSA id 60B748761BFB;
 Fri,  2 Aug 2019 09:49:52 +0000 (UTC)
Date: Fri, 2 Aug 2019 11:49:50 +0200
From: Greg Kurz <groug@kaod.org>
To: Daniel Black <daniel@linux.ibm.com>
Message-ID: <20190802114950.17d89b13@bahia.lan>
In-Reply-To: <20190802110348.60f22d92@volution.ozlabs.ibm.com>
References: <20190801033819.29664-1-daniel@linux.ibm.com>
 <20190801124159.75d9fa48@bahia.lan>
 <20190802110348.60f22d92@volution.ozlabs.ibm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 523543460084947376
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrleekgddugeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.178.58
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] spapr: quantify error
 messages regarding capability settings
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
Cc: "open list:sPAPR" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Aug 2019 11:03:48 +1000
Daniel Black <daniel@linux.ibm.com> wrote:

> On Thu, 1 Aug 2019 12:41:59 +0200
> Greg Kurz <groug@kaod.org> wrote:
> 
> > On Thu,  1 Aug 2019 13:38:19 +1000
> > Daniel Black <daniel@linux.ibm.com> wrote:
> > 
> > > Its not immediately obvious how cap-X=Y setting need to be applied
> > > to the command line so, for spapr capability error messages, this
> > > has been clarified to:
> > > 
> ...
> > > index bbb001f84a..1c0222a081 100644
> > > --- a/hw/ppc/spapr_caps.c
> > > +++ b/hw/ppc/spapr_caps.c
> > > @@ -37,6 +37,8 @@
> > >  
> > >  #include "hw/ppc/spapr.h"
> > >  
> > > +#define CAPABILITY_ERROR(X) "appending -machine " X  
> > 
> > I would make that:
> > 
> > #define CAPABILITY_HINT() "try appending -machine " X
> > 
> > because it is really an hint for the user, not an
> > error,
> 
> Works for me. At the lowest layer it is a hint.
> 
> > and all original strings have "try",
> 
> True.
> 
> > except...
> 
> 
> > > @@ -249,11 +255,13 @@ static void
> > > cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val, if
> > > (tcg_enabled() && val) { /* TCG only supports broken, allow other
> > > values and print a warning */ error_setg(&local_err,
> > > -                   "TCG doesn't support requested feature,
> > > cap-cfpc=%s",
> > > +                   "TCG doesn't support requested feature, "
> > > +                   CAPABILITY_ERROR("cap-cfpc=%s"),  
> > 
> > ... this one, but it doesn't look like a hint to me. It just tells
> > which is the unsupported cap.
> 
> This is one of 3 that local_error (commit
> 006e9d3618698eeef2f3e07628d22cb6f5c2a039) - intentionally just a
> warning and to TLDR the commit/Suraj conversation; defaults apply
> to all machine types; hardware security measures don't make sense in
> TCG; hence warning.
> 

Sure. What I meant is that the warning for "cap-cfpc" should be left alone,
otherwise we get:

$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries,accel=tcg
qemu-system-ppc64: warning: TCG doesn't support requested feature, appending -machine cap-cfpc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-sbbc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-ibs=workaround

and even weirder:

$ ppc64-softmmu/qemu-system-ppc64 -nodefaults -nographic -machine pseries,accel=tcg -machine cap-cfpc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature, appending -machine cap-cfpc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-sbbc=workaround
qemu-system-ppc64: warning: TCG doesn't support requested feature, cap-ibs=workaround

> For every function with CAPABILITY_[ERROR|HINT] its called by
> spapr_caps_apply, has its errp as &error_fatal (intentionally - spoke
> to Suraj - migrations to machines without capabilities need to fail and
> defaults (kvm) should be secure unless explicitly disabled).
> 
> > >                     cap_cfpc_possible.vals[val]);
> > >      } else if (kvm_enabled() && (val > kvm_val)) {
> > >          error_setg(errp,
> > > -"Requested safe cache capability level not supported by kvm, try
> > > cap-cfpc=%s", +"Requested safe cache capability level not supported
> > > by kvm, try "
> > > +                   CAPABILITY_ERROR("cap-cfpc=%s"),
> > >                     cap_cfpc_possible.vals[kvm_val]);  
> > 
> > Also, we have a dedicated API for hints, which are only printed under
> > the monitor but ignored under QMP.
> 
> Ok.
>  
> > Not sure why it isn't used here but it should be something like:
> 
> If error_append_hint should be used for fatal errors (all that use
> errp), then this patten should be applied further to
> CAPABILITY_[HINT|ERROR] functions.
> 

Hmm... looking again at error_append_hint(), it shouldn't be passed
&error_fatal or &error_abort. This calls for an extra local_err and
error_propagate() dance... Definitely not in the scope of this patch.

> If error_append_hint needs to apply to warnings
> cap_[cfpc/sbbc/ibs]_apply functions need to use it.
> 

The current warnings from commit 006e9d3618698eeef2f3e07628d22cb6f5c2a039
don't contain hints. We could potentially add one that says "try appending
-machine cap-blah=broken" but it doesn't bring much...

> Would I be right in I'm assuming that the below pattern needs to apply
> to both of these cases?
> 
> >         error_setg(errp, 
> >                    "Requested safe cache capability level not
> > supported by kvm");
> >         error_append_hint(errp,
> > CAPABILITY_HINT("cap-cfpc=%s") "\n", cap_cfpc_possible.vals[kvm_val]);
> 
> This is going a little beyond the scope of fixing a message, ok, but
> lets not extend the scope too much more.
> 

Yes, I agree. Your patch should only be about fixing the message.
I'll have a look at the error_append_hint() story when I'm back
from holidays :)

So, to sum up:
- s/CAPABILITY_ERROR/CAPABILITY_HINT and move "try" there
- drop the unwanted change in the "cap-cfpc" warning

With these fixed:

Reviewed-by: Greg Kurz <groug@kaod.org>

Cheers,

--
Greg

