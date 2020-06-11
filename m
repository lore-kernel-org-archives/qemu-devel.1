Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FB1C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:14:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC04520747
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:14:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC04520747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjKEX-0004YH-R6
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 06:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jjKDm-00041e-St
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 06:14:06 -0400
Received: from 7.mo5.mail-out.ovh.net ([178.32.124.100]:56766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jjKDl-0007Qj-T4
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 06:14:06 -0400
Received: from player157.ha.ovh.net (unknown [10.108.42.66])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 1FEC328740E
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 12:14:01 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id 250F513471E40;
 Thu, 11 Jun 2020 10:13:55 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-99G00357a7afba-e7e8-4861-9108-185b9fd86db8,8E3DA20A17A7E5167CC729B80B53FA75D16C5C19)
 smtp.auth=groug@kaod.org
Date: Thu, 11 Jun 2020 12:13:54 +0200
From: Greg Kurz <groug@kaod.org>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v2 2/3] spapr: Use error_append_hint() in spapr_caps.c
Message-ID: <20200611121354.0a4d2939@bahia.lan>
In-Reply-To: <deb1914f-f476-18e3-10f8-2a4aa0a1dddd@redhat.com>
References: <159186635896.48605.3457464705220760573.stgit@bahia.lan>
 <159186660024.48605.6756496231687601694.stgit@bahia.lan>
 <deb1914f-f476-18e3-10f8-2a4aa0a1dddd@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 281756453166618918
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudehkedgvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhduheejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.32.124.100; envelope-from=groug@kaod.org;
 helo=7.mo5.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 06:14:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jun 2020 11:50:57 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> On 11/06/2020 11:10, Greg Kurz wrote:
> > We have a dedicated error API for hints. Use it instead of embedding
> > the hint in the error message, as recommanded in the "qapi/error.h"
> > header file.
> > 
> > Since spapr_caps_apply() passes &error_fatal, all functions must
> > also call the ERRP_AUTO_PROPAGATE() macro for error_append_hint()
> > to be functional.
> > 
> > While here, add some missing braces around one line statements that
> > are part of the patch context. Also have cap_fwnmi_apply(), which
> > already uses error_append_hint() to call ERRP_AUTO_PROPAGATE() as
> > well.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr_caps.c |   95 +++++++++++++++++++++++++++++----------------------
> >  1 file changed, 54 insertions(+), 41 deletions(-)
> > 
> > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > index efdc0dbbcfc0..2cb7ba8f005a 100644
> > --- a/hw/ppc/spapr_caps.c
> > +++ b/hw/ppc/spapr_caps.c
> ...
> > @@ -248,6 +249,7 @@ SpaprCapPossible cap_cfpc_possible = {
> >  static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
> >                                   Error **errp)
> >  {
> > +    ERRP_AUTO_PROPAGATE();
> >      Error *local_err = NULL;
> 
> I think you should rename it, something like "local_warn" to not be
> confused with the _auto_errp_prop.local_err...
> 
> or don't use ERRP_AUTO_PROPAGE(), use the local_err instead and move the
> warning inside the braces of the if.
> 
> Same comment for cap_safe_bounds_check_apply() and
> cap_safe_indirect_branch_apply()
> 

Hmm... local_err isn't useful actually. It looks like we just want
to call warn_report() directly instead of error_setg(&local_err)
and warn_report_err(local_err). I'll post a v3.

> >      uint8_t kvm_val =  kvmppc_get_cap_safe_cache();
> >  
> > @@ -258,13 +260,14 @@ static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
> >                     cap_cfpc_possible.vals[val]);
> >      } else if (kvm_enabled() && (val > kvm_val)) {
> >          error_setg(errp,
> > -                   "Requested safe cache capability level not supported by kvm,"
> > -                   " try appending -machine cap-cfpc=%s",
> > -                   cap_cfpc_possible.vals[kvm_val]);
> > +                   "Requested safe cache capability level not supported by KVM");
> > +        error_append_hint(errp, "Try appending -machine cap-cfpc=%s\n",
> > +                          cap_cfpc_possible.vals[kvm_val]);
> >      }
> >  
> > -    if (local_err != NULL)
> > +    if (local_err != NULL) {
> >          warn_report_err(local_err);
> > +    }
> >  }
> >  
> >  SpaprCapPossible cap_sbbc_possible = {
> 
> Thanks,
> Laurent
> 


