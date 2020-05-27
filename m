Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F72C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:04:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 816E4207E8
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:04:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 816E4207E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdrze-00013H-P1
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 05:04:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jdrz0-0000cD-14
 for qemu-devel@nongnu.org; Wed, 27 May 2020 05:04:18 -0400
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:35788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jdryy-0002OH-Hh
 for qemu-devel@nongnu.org; Wed, 27 May 2020 05:04:17 -0400
Received: from player791.ha.ovh.net (unknown [10.110.208.83])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id EE785134EB4
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 11:04:13 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player791.ha.ovh.net (Postfix) with ESMTPSA id BAF4C12B1BBB3;
 Wed, 27 May 2020 09:04:06 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R001c2c961c3-72a4-4bfa-9d6a-3bade6385cae,A19C442F5A36D79893466B97850BD964E95F9B50)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH 2/2] qom: Make "info qom-tree" show children sorted
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200527084754.7531-1-armbru@redhat.com>
 <20200527084754.7531-3-armbru@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <a8313e39-169d-f2ed-09bc-8d51aec322be@kaod.org>
Date: Wed, 27 May 2020 11:04:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527084754.7531-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3246250909929737166
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgtdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejledurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=46.105.74.148; envelope-from=clg@kaod.org;
 helo=10.mo173.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 05:04:14
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: philmd@redhat.com, mark.cave-ayland@ilande.co.uk, berrange@redhat.com,
 ehabkost@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/20 10:47 AM, Markus Armbruster wrote:
> "info qom-tree" prints children in unstable order.  This is a pain
> when diffing output for different versions to find change.  Print it
> sorted.

yes. Thanks for fixing that.

 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

I used the powernv9 machine.

Tested-by: Cédric Le Goater <clg@kaod.org>

> ---
>  qom/qom-hmp-cmds.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/qom/qom-hmp-cmds.c b/qom/qom-hmp-cmds.c
> index cd08233a4c..94bdee9a90 100644
> --- a/qom/qom-hmp-cmds.c
> +++ b/qom/qom-hmp-cmds.c
> @@ -69,22 +69,25 @@ typedef struct QOMCompositionState {
>  
>  static void print_qom_composition(Monitor *mon, Object *obj, int indent);
>  
> -static int print_qom_composition_child(Object *obj, void *opaque)
> +static int qom_composition_compare(const void *a, const void *b, void *ignore)
>  {
> -    QOMCompositionState *s = opaque;
> +    return g_strcmp0(a ? object_get_canonical_path_component(a) : NULL,
> +                     b ? object_get_canonical_path_component(b) : NULL);
> +}
>  
> -    print_qom_composition(s->mon, obj, s->indent);
> +static int insert_qom_composition_child(Object *obj, void *opaque)
> +{
> +    GQueue *children = opaque;
>  
> +    g_queue_insert_sorted(children, obj, qom_composition_compare, NULL);
>      return 0;
>  }
>  
>  static void print_qom_composition(Monitor *mon, Object *obj, int indent)
>  {
> -    QOMCompositionState s = {
> -        .mon = mon,
> -        .indent = indent + 2,
> -    };
>      char *name;
> +    GQueue children;
> +    Object *child;
>  
>      if (obj == object_get_root()) {
>          name = g_strdup("");
> @@ -94,7 +97,12 @@ static void print_qom_composition(Monitor *mon, Object *obj, int indent)
>      monitor_printf(mon, "%*s/%s (%s)\n", indent, "", name,
>                     object_get_typename(obj));
>      g_free(name);
> -    object_child_foreach(obj, print_qom_composition_child, &s);
> +
> +    g_queue_init(&children);
> +    object_child_foreach(obj, insert_qom_composition_child, &children);
> +    while ((child = g_queue_pop_head(&children))) {
> +        print_qom_composition(mon, child, indent + 2);
> +    }
>  }
>  
>  void hmp_info_qom_tree(Monitor *mon, const QDict *dict)
> 


