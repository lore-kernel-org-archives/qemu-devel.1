Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C85C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B688206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:26:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B688206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsiw4-0004ez-Ik
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 04:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jsivN-000449-Bm
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:25:57 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:51632)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jsivH-00089X-SF
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:25:57 -0400
Received: from player714.ha.ovh.net (unknown [10.108.54.230])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id BA08F1E192C
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2020 10:25:39 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player714.ha.ovh.net (Postfix) with ESMTPSA id D7813140D8925;
 Tue,  7 Jul 2020 08:25:29 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0026803412c-1cb8-4627-91bc-9c6fc86ef39b,E152094F47616500A3A802F2EB970733BF761B34)
 smtp.auth=groug@kaod.org
Date: Tue, 7 Jul 2020 10:25:28 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 06/44] qemu-option: Check return value instead of
 @err where convenient
Message-ID: <20200707102528.2cec2bbb@bahia.lan>
In-Reply-To: <871rloct0d.fsf@dusky.pond.sub.org>
References: <20200706080950.403087-1-armbru@redhat.com>
 <20200706080950.403087-7-armbru@redhat.com>
 <20200706175917.460e4817@bahia.lan>
 <871rloct0d.fsf@dusky.pond.sub.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3567695330479806862
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudeggddufeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejudegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=87.98.165.38; envelope-from=groug@kaod.org;
 helo=6.mo2.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 04:25:40
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 06 Jul 2020 22:01:38 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Greg Kurz <groug@kaod.org> writes:
> 
> > On Mon,  6 Jul 2020 10:09:12 +0200
> > Markus Armbruster <armbru@redhat.com> wrote:
> >
> >> Convert uses like
> >> 
> >>     opts = qemu_opts_create(..., &err);
> >>     if (err) {
> >>         ...
> >>     }
> >> 
> >> to
> >> 
> >>     opts = qemu_opts_create(..., &err);
> >
> > The patch doesn't strictly do that since it also converts &err to errp.
> 
> Yes, and that's actually why I do it.  I'll change the commit message to
> say so:
> 
>    to
>    
>        opts = qemu_opts_create(..., errp);
> 

Ok.

> > This is okay because most of the changes also drop the associated
> > error_propagate(), with the exception of block/parallels.c for which
> > I had to check how local_err is used. As already noted by Vladimir
> > earlier this generates an harmless "no-op error_propagate", but it
> > could be worth mentioning that in the changelog for future reviews :)
> 
> Yes, error_propagate() becomes a no-op for one out of three error paths
> through it.  There's similar "partial no-opification" elsewhere in this
> series, notably in PATCH 36.
> 
> Concrete suggestions for improving the commit message further are
> welcome!
> 

What about this ?

The change in block/parallels.c doesn't provide any clue on the usage
of local_err. As usual it is expected to be equal to NULL at the time
qemu_opts_create() is called, and the goto on the error path jumps
here:

fail_options:
    error_propagate(errp, local_err);

So, if qemu_opts_create() fails, we end up doing error_propagate(errp, NULL)
which is a harmles no-op.

> >>     if (!opts) {
> >>         ...
> >>     }
> >> 
> >> Eliminate error_propagate() that are now unnecessary.  Delete @err
> >> that are now unused.
> >> 
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> Reviewed-by: Eric Blake <eblake@redhat.com>
> >> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> ---
> >>  block/parallels.c  |  4 ++--
> >>  blockdev.c         |  5 ++---
> >>  qdev-monitor.c     |  5 ++---
> >>  util/qemu-config.c | 10 ++++------
> >>  util/qemu-option.c | 12 ++++--------
> >
> > Maybe some other potential candidates ?
> >
> > chardev/char.c:
> >
> >    opts = qemu_opts_create(qemu_find_opts("chardev"), label, 1, &local_err);
> >     if (local_err) {
> >         error_report_err(local_err);
> >         return NULL;
> >     }
> >
> > monitor/hmp-cmds.c:
> >
> >     opts = qemu_opts_from_qdict(qemu_find_opts("netdev"), qdict, &err);
> >     if (err) {
> >         goto out;
> >     }
> >
> >
> >     opts = qemu_opts_from_qdict(qemu_find_opts("object"), qdict, &err);
> >     if (err) {
> >         goto end;
> >     }
> 
> Don't fit my clarified commit message, because I can't replace &err by
> errp there.
> 

Sure.

> I found these:
> 
>   diff --git a/block/blkdebug.c b/block/blkdebug.c
>   index 7194bc7f06..471b597dfe 100644
>   --- a/block/blkdebug.c
>   +++ b/block/blkdebug.c
>   @@ -294,17 +294,13 @@ static int read_config(BDRVBlkdebugState *s, const char *filename,
> 
>        d.s = s;
>        d.action = ACTION_INJECT_ERROR;
>   -    qemu_opts_foreach(&inject_error_opts, add_rule, &d, &local_err);
>   -    if (local_err) {
>   -        error_propagate(errp, local_err);
>   +    if (qemu_opts_foreach(&inject_error_opts, add_rule, &d, errp)) {
>            ret = -EINVAL;
>            goto fail;
>        }
> 
>        d.action = ACTION_SET_STATE;
>   -    qemu_opts_foreach(&set_state_opts, add_rule, &d, &local_err);
>   -    if (local_err) {
>   -        error_propagate(errp, local_err);
>   +    if (qemu_opts_foreach(&set_state_opts, add_rule, &d, errp)) {
>            ret = -EINVAL;
>            goto fail;
>        }
> 
> However, I really need to get a pull request out...  Can patch them
> later.
> 

Yeah and we might probably find a few more, but certainly not much
after this colossal effort of yours.

> > With or without the extra changes:
> >
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> 
> Thanks!
> 

My pleasure.

