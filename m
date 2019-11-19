Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FE0C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:14:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB83A2084D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 17:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB83A2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX74k-0003RC-I8
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 12:14:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iX6zb-0005T4-4X
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:08:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iX6zZ-0004KK-FP
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:08:42 -0500
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:44586)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iX6zY-0004Hn-Bo
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 12:08:40 -0500
Received: from player711.ha.ovh.net (unknown [10.108.35.27])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id DF87825AC6E
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 18:08:37 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: groug@kaod.org)
 by player711.ha.ovh.net (Postfix) with ESMTPSA id F41CBC2F13E1;
 Tue, 19 Nov 2019 17:08:32 +0000 (UTC)
Date: Tue, 19 Nov 2019 18:08:30 +0100
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [RFC v5 054/126] virtio-9p: introduce ERRP_AUTO_PROPAGATE
Message-ID: <20191119180830.080b8107@bahia.lan>
In-Reply-To: <aef514db-f55a-bc5d-f9d2-b9a54d9e1ce7@virtuozzo.com>
References: <20191011160552.22907-1-vsementsov@virtuozzo.com>
 <20191011160552.22907-55-vsementsov@virtuozzo.com>
 <20191119175644.058cce0b@bahia.lan>
 <aef514db-f55a-bc5d-f9d2-b9a54d9e1ce7@virtuozzo.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2419840377140779347
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegkedgleekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdduleehrddvuddvrddvledrudeiieenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeduuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.173.103
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 19 Nov 2019 16:59:23 +0000
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> 19.11.2019 19:56, Greg Kurz wrote:
> > Sorry for the late review...
> > 
> > On Fri, 11 Oct 2019 19:04:40 +0300
> > Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:
> > 
> >> If we want to add some info to errp (by error_prepend() or
> >> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
> >> Otherwise, this info will not be added when errp == &fatal_err
> > 
> > s/fatal_err/error_fatal/
> > 
> >> (the program will exit prior to the error_append_hint() or
> >> error_prepend() call).  Fix such cases.
> >>
> >> If we want to check error after errp-function call, we need to
> >> introduce local_err and than propagate it to errp. Instead, use
> > 
> > s/than/then
> > 
> >> ERRP_AUTO_PROPAGATE macro, benefits are:
> >> 1. No need of explicit error_propagate call
> >> 2. No need of explicit local_err variable: use errp directly
> >> 3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
> >>     &error_fatel, this means that we don't break error_abort
> > 
> > s/error_fatel/error_fatal
> > 
> >>     (we'll abort on error_set, not on error_propagate)
> >>
> >> This commit (together with its neighbors) was generated by
> >>
> >> for f in $(git grep -l errp \*.[ch]); do \
> >>      spatch --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
> >>      --macro-file scripts/cocci-macro-file.h --in-place --no-show-diff $f; \
> >> done;
> >>
> >> then fix a bit of compilation problems: coccinelle for some reason
> >> leaves several
> >> f() {
> >>      ...
> >>      goto out;
> >>      ...
> >>      out:
> >> }
> >> patterns, with "out:" at function end.
> >>
> >> then
> >> ./python/commit-per-subsystem.py MAINTAINERS "$(< auto-msg)"
> >>
> >> (auto-msg was a file with this commit message)
> >>
> >> Still, for backporting it may be more comfortable to use only the first
> >> command and then do one huge commit.
> >>
> >> Reported-by: Kevin Wolf <kwolf@redhat.com>
> >> Reported-by: Greg Kurz <groug@kaod.org>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> ---
> >>   hw/9pfs/9p-local.c | 8 ++++----
> >>   hw/9pfs/9p.c       | 1 +
> >>   2 files changed, 5 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> >> index 35635e7e7e..aac7989f16 100644
> >> --- a/hw/9pfs/9p-local.c
> >> +++ b/hw/9pfs/9p-local.c
> >> @@ -1477,9 +1477,9 @@ static void error_append_security_model_hint(Error **errp_in)
> >>   
> >>   static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
> >>   {
> >> +    ERRP_AUTO_PROPAGATE();
> >>       const char *sec_model = qemu_opt_get(opts, "security_model");
> >>       const char *path = qemu_opt_get(opts, "path");
> >> -    Error *local_err = NULL;
> >>   
> >>       if (!sec_model) {
> >>           error_setg(errp, "security_model property not set");
> >> @@ -1507,9 +1507,9 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
> >>           return -1;
> >>       }
> >>   
> >> -    fsdev_throttle_parse_opts(opts, &fse->fst, &local_err);
> >> -    if (local_err) {
> >> -        error_propagate_prepend(errp, local_err,
> >> +    fsdev_throttle_parse_opts(opts, &fse->fst, errp);
> >> +    if (*errp) {
> >> +        error_prepend(errp,
> >>                                   "invalid throttle configuration: ");
> > 
> > The change looks good, apart from the funky indentation.
> > 
> >>           return -1;
> >>       }
> >> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> >> index cce2366219..1df2749e03 100644
> >> --- a/hw/9pfs/9p.c
> >> +++ b/hw/9pfs/9p.c
> >> @@ -3552,6 +3552,7 @@ void pdu_submit(V9fsPDU *pdu, P9MsgHeader *hdr)
> >>   int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
> >>                                  Error **errp)
> >>   {
> >> +    ERRP_AUTO_PROPAGATE();
> > 
> > I don't know coccinelle so I'm not sure why ERRP_AUTO_PROPAGATE() was
> > added here... but it's definitely not needed in this function.
> 
> 
> Because this function calls error_prepend()
> 

My bad, sorry for the noise and:

Acked-by: Greg Kurz <groug@kaod.org>

> > 
> >>       int i, len;
> >>       struct stat stat;
> >>       FsDriverEntry *fse;
> > 
> 
> 


