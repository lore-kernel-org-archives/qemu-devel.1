Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3317AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:47:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FD19206BE
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 19:47:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD19206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jstYo-0004Ot-BJ
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 15:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jstY8-0003yX-VM
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 15:46:40 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:55073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jstY6-0008Bs-Ss
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 15:46:40 -0400
Received: from player786.ha.ovh.net (unknown [10.110.115.111])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id C428EA878D
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2020 21:46:36 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player786.ha.ovh.net (Postfix) with ESMTPSA id E8117144DB9DD;
 Tue,  7 Jul 2020 19:46:25 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006e919ac95-b28f-47e0-8712-358c624a9f18,E152094F47616500A3A802F2EB970733BF761B34)
 smtp.auth=groug@kaod.org
Date: Tue, 7 Jul 2020 21:46:24 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 10/45] qemu-option: Simplify around
 find_default_by_name()
Message-ID: <20200707214624.1e91cb41@bahia.lan>
In-Reply-To: <20200707160613.848843-11-armbru@redhat.com>
References: <20200707160613.848843-1-armbru@redhat.com>
 <20200707160613.848843-11-armbru@redhat.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 15067918454365723022
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudehgddufeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepheekhfdtheegheehjeeludefkefhvdelfedvieehhfekhfdufffhueeuvdfftdfhnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.76.150; envelope-from=groug@kaod.org;
 helo=10.mo178.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 15:46:37
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

On Tue,  7 Jul 2020 18:05:38 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  util/qemu-option.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/util/qemu-option.c b/util/qemu-option.c
> index 14e211ddd8..e7b540a21b 100644
> --- a/util/qemu-option.c
> +++ b/util/qemu-option.c
> @@ -277,7 +277,6 @@ static void qemu_opt_del_all(QemuOpts *opts, const char *name)
>  const char *qemu_opt_get(QemuOpts *opts, const char *name)
>  {
>      QemuOpt *opt;
> -    const char *def_val;
>  
>      if (opts == NULL) {
>          return NULL;
> @@ -285,12 +284,10 @@ const char *qemu_opt_get(QemuOpts *opts, const char *name)
>  
>      opt = qemu_opt_find(opts, name);
>      if (!opt) {
> -        def_val = find_default_by_name(opts, name);
> -        if (def_val) {
> -            return def_val;
> -        }
> +        return find_default_by_name(opts, name);
>      }
> -    return opt ? opt->str : NULL;
> +
> +    return opt->str;
>  }
>  
>  void qemu_opt_iter_init(QemuOptsIter *iter, QemuOpts *opts, const char *name)
> @@ -319,8 +316,7 @@ const char *qemu_opt_iter_next(QemuOptsIter *iter)
>  char *qemu_opt_get_del(QemuOpts *opts, const char *name)
>  {
>      QemuOpt *opt;
> -    const char *def_val;
> -    char *str = NULL;
> +    char *str;
>  
>      if (opts == NULL) {
>          return NULL;
> @@ -328,11 +324,7 @@ char *qemu_opt_get_del(QemuOpts *opts, const char *name)
>  
>      opt = qemu_opt_find(opts, name);
>      if (!opt) {
> -        def_val = find_default_by_name(opts, name);
> -        if (def_val) {
> -            str = g_strdup(def_val);
> -        }
> -        return str;
> +        return g_strdup(find_default_by_name(opts, name));
>      }
>      str = opt->str;
>      opt->str = NULL;


