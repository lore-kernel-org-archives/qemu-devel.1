Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC12CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D8E9206DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D8E9206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsTZX-0002SC-9l
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jsTWm-0000LS-TY
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 11:59:32 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:36113)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jsTWk-0001pD-Od
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 11:59:32 -0400
Received: from player761.ha.ovh.net (unknown [10.110.208.131])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id B32F51E0748
 for <qemu-devel@nongnu.org>; Mon,  6 Jul 2020 17:59:27 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player761.ha.ovh.net (Postfix) with ESMTPSA id BBC9C141A034E;
 Mon,  6 Jul 2020 15:59:18 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006bb76730e-bc5c-40da-8ae8-3b1db8a46564,
 C4ABCEF356A601883B7DEB1AA4190402CFF29AFD) smtp.auth=groug@kaod.org
Date: Mon, 6 Jul 2020 17:59:17 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 06/44] qemu-option: Check return value instead of
 @err where convenient
Message-ID: <20200706175917.460e4817@bahia.lan>
In-Reply-To: <20200706080950.403087-7-armbru@redhat.com>
References: <20200706080950.403087-1-armbru@redhat.com>
 <20200706080950.403087-7-armbru@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 5359002082299517326
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudefgdelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehkefhtdehgeehheejledufeekhfdvleefvdeihefhkefhudffhfeuuedvffdthfenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeiuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=188.165.48.182; envelope-from=groug@kaod.org;
 helo=7.mo2.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 11:59:28
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

On Mon,  6 Jul 2020 10:09:12 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Convert uses like
> 
>     opts = qemu_opts_create(..., &err);
>     if (err) {
>         ...
>     }
> 
> to
> 
>     opts = qemu_opts_create(..., &err);

The patch doesn't strictly do that since it also converts &err to errp.
This is okay because most of the changes also drop the associated
error_propagate(), with the exception of block/parallels.c for which
I had to check how local_err is used. As already noted by Vladimir
earlier this generates an harmless "no-op error_propagate", but it
could be worth mentioning that in the changelog for future reviews :)

>     if (!opts) {
>         ...
>     }
> 
> Eliminate error_propagate() that are now unnecessary.  Delete @err
> that are now unused.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/parallels.c  |  4 ++--
>  blockdev.c         |  5 ++---
>  qdev-monitor.c     |  5 ++---
>  util/qemu-config.c | 10 ++++------
>  util/qemu-option.c | 12 ++++--------

Maybe some other potential candidates ?

chardev/char.c:

   opts = qemu_opts_create(qemu_find_opts("chardev"), label, 1, &local_err);
    if (local_err) {
        error_report_err(local_err);
        return NULL;
    }

monitor/hmp-cmds.c:

    opts = qemu_opts_from_qdict(qemu_find_opts("netdev"), qdict, &err);
    if (err) {
        goto out;
    }


    opts = qemu_opts_from_qdict(qemu_find_opts("object"), qdict, &err);
    if (err) {
        goto end;
    }

With or without the extra changes:

Reviewed-by: Greg Kurz <groug@kaod.org>

>  5 files changed, 14 insertions(+), 22 deletions(-)
> 
> diff --git a/block/parallels.c b/block/parallels.c
> index 63a1cde8af..f26f03c926 100644
> --- a/block/parallels.c
> +++ b/block/parallels.c
> @@ -824,8 +824,8 @@ static int parallels_open(BlockDriverState *bs, QDict *options, int flags,
>          }
>      }
>  
> -    opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, &local_err);
> -    if (local_err != NULL) {
> +    opts = qemu_opts_create(&parallels_runtime_opts, NULL, 0, errp);
> +    if (!opts) {
>          goto fail_options;
>      }
>  
> diff --git a/blockdev.c b/blockdev.c
> index 31d5eaf6bf..b52ed9de86 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -504,9 +504,8 @@ static BlockBackend *blockdev_init(const char *file, QDict *bs_opts,
>      /* Check common options by copying from bs_opts to opts, all other options
>       * stay in bs_opts for processing by bdrv_open(). */
>      id = qdict_get_try_str(bs_opts, "id");
> -    opts = qemu_opts_create(&qemu_common_drive_opts, id, 1, &error);
> -    if (error) {
> -        error_propagate(errp, error);
> +    opts = qemu_opts_create(&qemu_common_drive_opts, id, 1, errp);
> +    if (!opts) {
>          goto err_no_opts;
>      }
>  
> diff --git a/qdev-monitor.c b/qdev-monitor.c
> index 13a13a811a..079cb6001e 100644
> --- a/qdev-monitor.c
> +++ b/qdev-monitor.c
> @@ -799,9 +799,8 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
>      QemuOpts *opts;
>      DeviceState *dev;
>  
> -    opts = qemu_opts_from_qdict(qemu_find_opts("device"), qdict, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    opts = qemu_opts_from_qdict(qemu_find_opts("device"), qdict, errp);
> +    if (!opts) {
>          return;
>      }
>      if (!monitor_cur_is_qmp() && qdev_device_help(opts)) {
> diff --git a/util/qemu-config.c b/util/qemu-config.c
> index 772f5a219e..c0d0e9b8ef 100644
> --- a/util/qemu-config.c
> +++ b/util/qemu-config.c
> @@ -493,9 +493,8 @@ static void config_parse_qdict_section(QDict *options, QemuOptsList *opts,
>          goto out;
>      }
>  
> -    subopts = qemu_opts_create(opts, NULL, 0, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    subopts = qemu_opts_create(opts, NULL, 0, errp);
> +    if (!subopts) {
>          goto out;
>      }
>  
> @@ -538,10 +537,9 @@ static void config_parse_qdict_section(QDict *options, QemuOptsList *opts,
>              }
>  
>              opt_name = g_strdup_printf("%s.%u", opts->name, i++);
> -            subopts = qemu_opts_create(opts, opt_name, 1, &local_err);
> +            subopts = qemu_opts_create(opts, opt_name, 1, errp);
>              g_free(opt_name);
> -            if (local_err) {
> -                error_propagate(errp, local_err);
> +            if (!subopts) {
>                  goto out;
>              }
>  
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index 0ebfd97a98..fd1fd23521 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -670,11 +670,9 @@ void qemu_opts_set(QemuOptsList *list, const char *id,
>                     const char *name, const char *value, Error **errp)
>  {
>      QemuOpts *opts;
> -    Error *local_err = NULL;
>  
> -    opts = qemu_opts_create(list, id, 1, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    opts = qemu_opts_create(list, id, 1, errp);
> +    if (!opts) {
>          return;
>      }
>      qemu_opt_set(opts, name, value, errp);
> @@ -1012,10 +1010,8 @@ QemuOpts *qemu_opts_from_qdict(QemuOptsList *list, const QDict *qdict,
>      QemuOpts *opts;
>      const QDictEntry *entry;
>  
> -    opts = qemu_opts_create(list, qdict_get_try_str(qdict, "id"), 1,
> -                            &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> +    opts = qemu_opts_create(list, qdict_get_try_str(qdict, "id"), 1, errp);
> +    if (!opts) {
>          return NULL;
>      }
>  


