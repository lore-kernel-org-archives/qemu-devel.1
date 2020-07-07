Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DA4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:27:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35BB7206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:27:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35BB7206DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsiwZ-0005Iq-F7
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 04:27:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jsivj-0004Sp-27
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:26:19 -0400
Received: from 5.mo3.mail-out.ovh.net ([87.98.178.36]:57117)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jsivh-0008KC-1M
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:26:18 -0400
Received: from player168.ha.ovh.net (unknown [10.110.103.226])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 02F3D258479
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2020 10:26:13 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player168.ha.ovh.net (Postfix) with ESMTPSA id A96BB14163190;
 Tue,  7 Jul 2020 08:26:04 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005e4918421-b6bb-4bf9-9074-daa97007fe4b,E152094F47616500A3A802F2EB970733BF761B34)
 smtp.auth=groug@kaod.org
Date: Tue, 7 Jul 2020 10:26:03 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 07/44] qemu-option: Make uses of find_desc_by_name()
 more similar
Message-ID: <20200707102603.525ace75@bahia.lan>
In-Reply-To: <20200706080950.403087-8-armbru@redhat.com>
References: <20200706080950.403087-1-armbru@redhat.com>
 <20200706080950.403087-8-armbru@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3577265482111949198
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudeggddufeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhduieekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=87.98.178.36; envelope-from=groug@kaod.org;
 helo=5.mo3.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 04:26:15
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

On Mon,  6 Jul 2020 10:09:13 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> This is to make the next commit easier to review.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  util/qemu-option.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index fd1fd23521..1df55bc881 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -270,6 +270,7 @@ static void qemu_opt_del_all(QemuOpts *opts, const char *name)
>  const char *qemu_opt_get(QemuOpts *opts, const char *name)
>  {
>      QemuOpt *opt;
> +    const QemuOptDesc *desc;
>  
>      if (opts == NULL) {
>          return NULL;
> @@ -277,7 +278,7 @@ const char *qemu_opt_get(QemuOpts *opts, const char *name)
>  
>      opt = qemu_opt_find(opts, name);
>      if (!opt) {
> -        const QemuOptDesc *desc = find_desc_by_name(opts->list->desc, name);
> +        desc = find_desc_by_name(opts->list->desc, name);
>          if (desc && desc->def_value_str) {
>              return desc->def_value_str;
>          }
> @@ -348,6 +349,7 @@ static bool qemu_opt_get_bool_helper(QemuOpts *opts, const char *name,
>                                       bool defval, bool del)
>  {
>      QemuOpt *opt;
> +    const QemuOptDesc *desc;
>      bool ret = defval;
>  
>      if (opts == NULL) {
> @@ -356,7 +358,7 @@ static bool qemu_opt_get_bool_helper(QemuOpts *opts, const char *name,
>  
>      opt = qemu_opt_find(opts, name);
>      if (opt == NULL) {
> -        const QemuOptDesc *desc = find_desc_by_name(opts->list->desc, name);
> +        desc = find_desc_by_name(opts->list->desc, name);
>          if (desc && desc->def_value_str) {
>              parse_option_bool(name, desc->def_value_str, &ret, &error_abort);
>          }
> @@ -384,6 +386,7 @@ static uint64_t qemu_opt_get_number_helper(QemuOpts *opts, const char *name,
>                                             uint64_t defval, bool del)
>  {
>      QemuOpt *opt;
> +    const QemuOptDesc *desc;
>      uint64_t ret = defval;
>  
>      if (opts == NULL) {
> @@ -392,7 +395,7 @@ static uint64_t qemu_opt_get_number_helper(QemuOpts *opts, const char *name,
>  
>      opt = qemu_opt_find(opts, name);
>      if (opt == NULL) {
> -        const QemuOptDesc *desc = find_desc_by_name(opts->list->desc, name);
> +        desc = find_desc_by_name(opts->list->desc, name);
>          if (desc && desc->def_value_str) {
>              parse_option_number(name, desc->def_value_str, &ret, &error_abort);
>          }
> @@ -421,6 +424,7 @@ static uint64_t qemu_opt_get_size_helper(QemuOpts *opts, const char *name,
>                                           uint64_t defval, bool del)
>  {
>      QemuOpt *opt;
> +    const QemuOptDesc *desc;
>      uint64_t ret = defval;
>  
>      if (opts == NULL) {
> @@ -429,7 +433,7 @@ static uint64_t qemu_opt_get_size_helper(QemuOpts *opts, const char *name,
>  
>      opt = qemu_opt_find(opts, name);
>      if (opt == NULL) {
> -        const QemuOptDesc *desc = find_desc_by_name(opts->list->desc, name);
> +        desc = find_desc_by_name(opts->list->desc, name);
>          if (desc && desc->def_value_str) {
>              parse_option_size(name, desc->def_value_str, &ret, &error_abort);
>          }
> @@ -540,18 +544,18 @@ void qemu_opt_set_bool(QemuOpts *opts, const char *name, bool val,
>                         Error **errp)
>  {
>      QemuOpt *opt;
> -    const QemuOptDesc *desc = opts->list->desc;
> +    const QemuOptDesc *desc;
>  
> -    opt = g_malloc0(sizeof(*opt));
> -    opt->desc = find_desc_by_name(desc, name);
> -    if (!opt->desc && !opts_accepts_any(opts)) {
> +    desc = find_desc_by_name(opts->list->desc, name);
> +    if (!desc && !opts_accepts_any(opts)) {
>          error_setg(errp, QERR_INVALID_PARAMETER, name);
> -        g_free(opt);
>          return;
>      }
>  
> +    opt = g_malloc0(sizeof(*opt));
>      opt->name = g_strdup(name);
>      opt->opts = opts;
> +    opt->desc = desc;
>      opt->value.boolean = !!val;
>      opt->str = g_strdup(val ? "on" : "off");
>      QTAILQ_INSERT_TAIL(&opts->head, opt, next);
> @@ -561,18 +565,18 @@ void qemu_opt_set_number(QemuOpts *opts, const char *name, int64_t val,
>                           Error **errp)
>  {
>      QemuOpt *opt;
> -    const QemuOptDesc *desc = opts->list->desc;
> +    const QemuOptDesc *desc;
>  
> -    opt = g_malloc0(sizeof(*opt));
> -    opt->desc = find_desc_by_name(desc, name);
> -    if (!opt->desc && !opts_accepts_any(opts)) {
> +    desc = find_desc_by_name(opts->list->desc, name);
> +    if (!desc && !opts_accepts_any(opts)) {
>          error_setg(errp, QERR_INVALID_PARAMETER, name);
> -        g_free(opt);
>          return;
>      }
>  
> +    opt = g_malloc0(sizeof(*opt));
>      opt->name = g_strdup(name);
>      opt->opts = opts;
> +    opt->desc = desc;
>      opt->value.uint = val;
>      opt->str = g_strdup_printf("%" PRId64, val);
>      QTAILQ_INSERT_TAIL(&opts->head, opt, next);


