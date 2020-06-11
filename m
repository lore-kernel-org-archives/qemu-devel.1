Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F4AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68AAE206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 10:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68AAE206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjKe7-0008OP-Fh
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 06:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jjKcw-0007Uu-3s
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 06:40:06 -0400
Received: from 14.mo1.mail-out.ovh.net ([178.32.97.215]:53270)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jjKcv-0004hW-1H
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 06:40:05 -0400
Received: from player739.ha.ovh.net (unknown [10.108.35.158])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id CEE6F1C803E
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 12:40:01 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player739.ha.ovh.net (Postfix) with ESMTPSA id D0E2DF3E05EE;
 Thu, 11 Jun 2020 10:39:53 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0025f1456af-df46-4c47-8108-bff08ebe0943,8E3DA20A17A7E5167CC729B80B53FA75D16C5C19)
 smtp.auth=groug@kaod.org
Date: Thu, 11 Jun 2020 12:39:52 +0200
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v2 2/3] spapr: Use error_append_hint() in spapr_caps.c
Message-ID: <20200611123952.15f465dd@bahia.lan>
In-Reply-To: <cb7b9613-b76e-c527-1120-7ba8e88a8039@virtuozzo.com>
References: <159186635896.48605.3457464705220760573.stgit@bahia.lan>
 <159186660024.48605.6756496231687601694.stgit@bahia.lan>
 <deb1914f-f476-18e3-10f8-2a4aa0a1dddd@redhat.com>
 <20200611121354.0a4d2939@bahia.lan>
 <cb7b9613-b76e-c527-1120-7ba8e88a8039@virtuozzo.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 720857416614648147
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudehledgtdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.32.97.215; envelope-from=groug@kaod.org;
 helo=14.mo1.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 06:40:02
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
Cc: Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jun 2020 13:21:51 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> 11.06.2020 13:13, Greg Kurz wrote:
> > On Thu, 11 Jun 2020 11:50:57 +0200
> > Laurent Vivier <lvivier@redhat.com> wrote:
> > 
> >> On 11/06/2020 11:10, Greg Kurz wrote:
> >>> We have a dedicated error API for hints. Use it instead of embedding
> >>> the hint in the error message, as recommanded in the "qapi/error.h"
> >>> header file.
> >>>
> >>> Since spapr_caps_apply() passes &error_fatal, all functions must
> >>> also call the ERRP_AUTO_PROPAGATE() macro for error_append_hint()
> >>> to be functional.
> >>>
> >>> While here, add some missing braces around one line statements that
> >>> are part of the patch context. Also have cap_fwnmi_apply(), which
> >>> already uses error_append_hint() to call ERRP_AUTO_PROPAGATE() as
> >>> well.
> >>>
> >>> Signed-off-by: Greg Kurz <groug@kaod.org>
> >>> ---
> >>>   hw/ppc/spapr_caps.c |   95 +++++++++++++++++++++++++++++----------------------
> >>>   1 file changed, 54 insertions(+), 41 deletions(-)
> >>>
> >>> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> >>> index efdc0dbbcfc0..2cb7ba8f005a 100644
> >>> --- a/hw/ppc/spapr_caps.c
> >>> +++ b/hw/ppc/spapr_caps.c
> >> ...
> >>> @@ -248,6 +249,7 @@ SpaprCapPossible cap_cfpc_possible = {
> >>>   static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
> >>>                                    Error **errp)
> >>>   {
> >>> +    ERRP_AUTO_PROPAGATE();
> >>>       Error *local_err = NULL;
> >>
> >> I think you should rename it, something like "local_warn" to not be
> >> confused with the _auto_errp_prop.local_err...
> >>
> >> or don't use ERRP_AUTO_PROPAGE(), use the local_err instead and move the
> >> warning inside the braces of the if.
> >>
> >> Same comment for cap_safe_bounds_check_apply() and
> >> cap_safe_indirect_branch_apply()
> >>
> > 
> > Hmm... local_err isn't useful actually. It looks like we just want
> > to call warn_report() directly instead of error_setg(&local_err)
> > and warn_report_err(local_err). I'll post a v3.
> 
> something like this I think:
> 

Not even that... we have one path (KVM) that directly
uses errp and the other path (TCG) that does:

Error *local_err = NULL;

error_setg(&local_err, ...);

if (local_err) {
    warn_report_err(local_err);
}

It really looks like we just want to call warn_report().

> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -250,24 +250,23 @@ static void cap_safe_cache_apply(SpaprMachineState *spapr, uint8_t val,
>                                    Error **errp)
>   {
>       ERRP_AUTO_PROPAGATE();
> -    Error *local_err = NULL;
>       uint8_t kvm_val =  kvmppc_get_cap_safe_cache();
>   
>       if (tcg_enabled() && val) {
>           /* TCG only supports broken, allow other values and print a warning */
> -        error_setg(&local_err,
> +        error_setg(errp,
>                      "TCG doesn't support requested feature, cap-cfpc=%s",
>                      cap_cfpc_possible.vals[val]);
> +        if (*errp) {
> +            warn_report_err(*errp);
> +            *errp = NULL;
> +        }
>       } else if (kvm_enabled() && (val > kvm_val)) {
>           error_setg(errp,
>                      "Requested safe cache capability level not supported by KVM");
>           error_append_hint(errp, "Try appending -machine cap-cfpc=%s\n",
>                             cap_cfpc_possible.vals[kvm_val]);
>       }
> -
> -    if (local_err != NULL) {
> -        warn_report_err(local_err);
> -    }
>   }
> 
> 
> Or, we need to implement warn_report_errp() function, as I proposed in earlier version of auto-propagation series.
> 
> =====
> 
> side idea: what if we make Error to be some kind of enum of pointer-to-pointer and pointer-to-function?
> 
> Than, instead of passing pointers to error_abort and error_fatal as special casing, we'll pass pointers to functions,
> which do appropriate handling of error. And we'll be able to pass warn_report function. Not about this patch set,
> but seems interesting, isn't it?
> 


