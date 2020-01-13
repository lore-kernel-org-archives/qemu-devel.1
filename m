Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7313BC33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 10:41:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473D220661
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 10:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473D220661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iqxA8-0002pz-AT
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 05:41:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56898)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iqx9V-0002PQ-Kr
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 05:40:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iqx9U-0003tl-9F
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 05:40:57 -0500
Received: from 14.mo7.mail-out.ovh.net ([178.33.251.19]:51893)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iqx9U-0003kB-2Y
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 05:40:56 -0500
Received: from player696.ha.ovh.net (unknown [10.108.16.184])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 2C24414B49A
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 11:40:45 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player696.ha.ovh.net (Postfix) with ESMTPSA id 31414E3135C8;
 Mon, 13 Jan 2020 10:40:43 +0000 (UTC)
Date: Mon, 13 Jan 2020 11:40:41 +0100
From: Greg Kurz <groug@kaod.org>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [PATCH v6 08/11] virtio-9p: introduce ERRP_AUTO_PROPAGATE
Message-ID: <20200113114041.01cddb87@bahia.lan>
In-Reply-To: <20200110194158.14190-9-vsementsov@virtuozzo.com>
References: <20200110194158.14190-1-vsementsov@virtuozzo.com>
 <20200110194158.14190-9-vsementsov@virtuozzo.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 5272870739592649043
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdejtddgudelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieeliedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.251.19
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Jan 2020 22:41:55 +0300
Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com> wrote:

> If we want to add some info to errp (by error_prepend() or
> error_append_hint()), we must use the ERRP_AUTO_PROPAGATE macro.
> Otherwise, this info will not be added when errp == &error_fatal
> (the program will exit prior to the error_append_hint() or
> error_prepend() call).  Fix such cases.
> 
> If we want to check error after errp-function call, we need to
> introduce local_err and then propagate it to errp. Instead, use
> ERRP_AUTO_PROPAGATE macro, benefits are:
> 1. No need of explicit error_propagate call
> 2. No need of explicit local_err variable: use errp directly
> 3. ERRP_AUTO_PROPAGATE leaves errp as is if it's not NULL or
>    &error_fatal, this means that we don't break error_abort
>    (we'll abort on error_set, not on error_propagate)
> 
> This commit is generated by command
> 
>     sed -n '/^virtio-9p$/,/^$/{s/^F: //p}' MAINTAINERS | \
>     xargs git ls-files | grep '\.[hc]$' | \
>     xargs spatch \
>         --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
>         --macro-file scripts/cocci-macro-file.h \
>         --in-place --no-show-diff --max-width 80
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Reported-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Acked-by: Greg Kurz <groug@kaod.org>

>  hw/9pfs/9p-local.c | 12 +++++-------
>  hw/9pfs/9p.c       |  1 +
>  2 files changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index ca641390fb..253814ef2c 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -1481,10 +1481,10 @@ static void error_append_security_model_hint(Error *const *errp)
>  
>  static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
>  {
> +    ERRP_AUTO_PROPAGATE();
>      const char *sec_model = qemu_opt_get(opts, "security_model");
>      const char *path = qemu_opt_get(opts, "path");
>      const char *multidevs = qemu_opt_get(opts, "multidevs");
> -    Error *local_err = NULL;
>  
>      if (!sec_model) {
>          error_setg(errp, "security_model property not set");
> @@ -1518,11 +1518,10 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
>              fse->export_flags &= ~V9FS_FORBID_MULTIDEVS;
>              fse->export_flags &= ~V9FS_REMAP_INODES;
>          } else {
> -            error_setg(&local_err, "invalid multidevs property '%s'",
> +            error_setg(errp, "invalid multidevs property '%s'",
>                         multidevs);
> -            error_append_hint(&local_err, "Valid options are: multidevs="
> +            error_append_hint(errp, "Valid options are: multidevs="
>                                "[remap|forbid|warn]\n");
> -            error_propagate(errp, local_err);
>              return -1;
>          }
>      }
> @@ -1532,9 +1531,8 @@ static int local_parse_opts(QemuOpts *opts, FsDriverEntry *fse, Error **errp)
>          return -1;
>      }
>  
> -    if (fsdev_throttle_parse_opts(opts, &fse->fst, &local_err)) {
> -        error_propagate_prepend(errp, local_err,
> -                                "invalid throttle configuration: ");
> +    if (fsdev_throttle_parse_opts(opts, &fse->fst, errp)) {
> +        error_prepend(errp, "invalid throttle configuration: ");
>          return -1;
>      }
>  
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index 520177f40c..4200c3416b 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -3994,6 +3994,7 @@ void pdu_submit(V9fsPDU *pdu, P9MsgHeader *hdr)
>  int v9fs_device_realize_common(V9fsState *s, const V9fsTransport *t,
>                                 Error **errp)
>  {
> +    ERRP_AUTO_PROPAGATE();
>      int i, len;
>      struct stat stat;
>      FsDriverEntry *fse;


