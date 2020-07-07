Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A000EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:48:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74EC22064B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EC22064B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsjGv-0008S9-Pl
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 04:48:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jsjGG-0007as-4n
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:47:32 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:55517)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jsjGD-0003MP-3j
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:47:31 -0400
Received: from player738.ha.ovh.net (unknown [10.110.115.91])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 31EE71E0B87
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2020 10:47:26 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player738.ha.ovh.net (Postfix) with ESMTPSA id A132A143996EF;
 Tue,  7 Jul 2020 08:47:15 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0027c03e827-a480-40f3-a0c0-f17f8015c639,E152094F47616500A3A802F2EB970733BF761B34)
 smtp.auth=groug@kaod.org
Date: Tue, 7 Jul 2020 10:47:14 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 08/44] qemu-option: Factor out helper
 find_default_by_name()
Message-ID: <20200707104714.7c34f24b@bahia.lan>
In-Reply-To: <20200706080950.403087-9-armbru@redhat.com>
References: <20200706080950.403087-1-armbru@redhat.com>
 <20200706080950.403087-9-armbru@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 3935301649653143950
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudehgddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehkefhtdehgeehheejledufeekhfdvleefvdeihefhkefhudffhfeuuedvffdthfenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeefkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=188.165.52.147; envelope-from=groug@kaod.org;
 helo=8.mo2.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 04:47:26
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

On Mon,  6 Jul 2020 10:09:14 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  util/qemu-option.c | 47 ++++++++++++++++++++++++++--------------------
>  1 file changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index 1df55bc881..14e211ddd8 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -142,6 +142,13 @@ static const QemuOptDesc *find_desc_by_name(const QemuOptDesc *desc,
>      return NULL;
>  }
>  
> +static const char *find_default_by_name(QemuOpts *opts, const char *name)
> +{
> +    const QemuOptDesc *desc = find_desc_by_name(opts->list->desc, name);
> +
> +    return desc ? desc->def_value_str : NULL;
> +}
> +
>  void parse_option_size(const char *name, const char *value,
>                         uint64_t *ret, Error **errp)
>  {
> @@ -270,7 +277,7 @@ static void qemu_opt_del_all(QemuOpts *opts, const char *name)
>  const char *qemu_opt_get(QemuOpts *opts, const char *name)
>  {
>      QemuOpt *opt;
> -    const QemuOptDesc *desc;
> +    const char *def_val;
>  
>      if (opts == NULL) {
>          return NULL;
> @@ -278,9 +285,9 @@ const char *qemu_opt_get(QemuOpts *opts, const char *name)
>  
>      opt = qemu_opt_find(opts, name);
>      if (!opt) {
> -        desc = find_desc_by_name(opts->list->desc, name);
> -        if (desc && desc->def_value_str) {
> -            return desc->def_value_str;
> +        def_val = find_default_by_name(opts, name);
> +        if (def_val) {
> +            return def_val;
>          }
>      }
>      return opt ? opt->str : NULL;
> @@ -312,7 +319,7 @@ const char *qemu_opt_iter_next(QemuOptsIter *iter)
>  char *qemu_opt_get_del(QemuOpts *opts, const char *name)
>  {
>      QemuOpt *opt;
> -    const QemuOptDesc *desc;
> +    const char *def_val;
>      char *str = NULL;
>  
>      if (opts == NULL) {
> @@ -321,9 +328,9 @@ char *qemu_opt_get_del(QemuOpts *opts, const char *name)
>  
>      opt = qemu_opt_find(opts, name);
>      if (!opt) {
> -        desc = find_desc_by_name(opts->list->desc, name);
> -        if (desc && desc->def_value_str) {
> -            str = g_strdup(desc->def_value_str);
> +        def_val = find_default_by_name(opts, name);
> +        if (def_val) {
> +            str = g_strdup(def_val);
>          }
>          return str;
>      }


This could be possibly abbreviated to:

    if (!opt) {
        return g_strdup(find_default_by_name(opts, name));
    }

since g_strdup(NULL) returns NULL, but the more verbose version
is nice as well and it is consistent with the other changes, so:

Reviewed-by: Greg Kurz <groug@kaod.org>

> @@ -349,7 +356,7 @@ static bool qemu_opt_get_bool_helper(QemuOpts *opts, const char *name,
>                                       bool defval, bool del)
>  {
>      QemuOpt *opt;
> -    const QemuOptDesc *desc;
> +    const char *def_val;
>      bool ret = defval;
>  
>      if (opts == NULL) {
> @@ -358,9 +365,9 @@ static bool qemu_opt_get_bool_helper(QemuOpts *opts, const char *name,
>  
>      opt = qemu_opt_find(opts, name);
>      if (opt == NULL) {
> -        desc = find_desc_by_name(opts->list->desc, name);
> -        if (desc && desc->def_value_str) {
> -            parse_option_bool(name, desc->def_value_str, &ret, &error_abort);
> +        def_val = find_default_by_name(opts, name);
> +        if (def_val) {
> +            parse_option_bool(name, def_val, &ret, &error_abort);
>          }
>          return ret;
>      }
> @@ -386,7 +393,7 @@ static uint64_t qemu_opt_get_number_helper(QemuOpts *opts, const char *name,
>                                             uint64_t defval, bool del)
>  {
>      QemuOpt *opt;
> -    const QemuOptDesc *desc;
> +    const char *def_val;
>      uint64_t ret = defval;
>  
>      if (opts == NULL) {
> @@ -395,9 +402,9 @@ static uint64_t qemu_opt_get_number_helper(QemuOpts *opts, const char *name,
>  
>      opt = qemu_opt_find(opts, name);
>      if (opt == NULL) {
> -        desc = find_desc_by_name(opts->list->desc, name);
> -        if (desc && desc->def_value_str) {
> -            parse_option_number(name, desc->def_value_str, &ret, &error_abort);
> +        def_val = find_default_by_name(opts, name);
> +        if (def_val) {
> +            parse_option_number(name, def_val, &ret, &error_abort);
>          }
>          return ret;
>      }
> @@ -424,7 +431,7 @@ static uint64_t qemu_opt_get_size_helper(QemuOpts *opts, const char *name,
>                                           uint64_t defval, bool del)
>  {
>      QemuOpt *opt;
> -    const QemuOptDesc *desc;
> +    const char *def_val;
>      uint64_t ret = defval;
>  
>      if (opts == NULL) {
> @@ -433,9 +440,9 @@ static uint64_t qemu_opt_get_size_helper(QemuOpts *opts, const char *name,
>  
>      opt = qemu_opt_find(opts, name);
>      if (opt == NULL) {
> -        desc = find_desc_by_name(opts->list->desc, name);
> -        if (desc && desc->def_value_str) {
> -            parse_option_size(name, desc->def_value_str, &ret, &error_abort);
> +        def_val = find_default_by_name(opts, name);
> +        if (def_val) {
> +            parse_option_size(name, def_val, &ret, &error_abort);
>          }
>          return ret;
>      }


