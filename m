Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF1AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:03:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2401C2084C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 09:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2401C2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdry9-00005N-Bx
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 05:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jdrxd-00082Q-EG
 for qemu-devel@nongnu.org; Wed, 27 May 2020 05:02:53 -0400
Received: from 15.mo7.mail-out.ovh.net ([87.98.180.21]:59979)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jdrxc-0001Yq-Cs
 for qemu-devel@nongnu.org; Wed, 27 May 2020 05:02:53 -0400
Received: from player735.ha.ovh.net (unknown [10.110.171.171])
 by mo7.mail-out.ovh.net (Postfix) with ESMTP id 6830216934D
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 11:02:47 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player735.ha.ovh.net (Postfix) with ESMTPSA id C19F612862AD0;
 Wed, 27 May 2020 09:02:39 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R00330758401-ef05-4453-bdb4-b45c241e5e99,A19C442F5A36D79893466B97850BD964E95F9B50)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH 1/2] qom: Constify object_get_canonical_path{,
 _component}()'s parameter
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200527084754.7531-1-armbru@redhat.com>
 <20200527084754.7531-2-armbru@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <05a17baa-c076-77d7-8eab-cf54d97e3798@kaod.org>
Date: Wed, 27 May 2020 11:02:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527084754.7531-2-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3222044062231530446
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedruddvgedgtdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeefffdvtddugeeifeduuefghfejgfeigeeigeeltedthefgieeiveeuiefhgeefgfenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=87.98.180.21; envelope-from=clg@kaod.org;
 helo=15.mo7.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 05:02:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>


> ---
>  include/qom/object.h | 4 ++--
>  qom/object.c         | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/include/qom/object.h b/include/qom/object.h
> index fd453dc8d6..b3eb05d65d 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -1406,7 +1406,7 @@ Object *object_get_internal_root(void);
>   * path is the path within the composition tree starting from the root.
>   * %NULL if the object doesn't have a parent (and thus a canonical path).
>   */
> -char *object_get_canonical_path_component(Object *obj);
> +char *object_get_canonical_path_component(const Object *obj);
>  
>  /**
>   * object_get_canonical_path:
> @@ -1414,7 +1414,7 @@ char *object_get_canonical_path_component(Object *obj);
>   * Returns: The canonical path for a object.  This is the path within the
>   * composition tree starting from the root.
>   */
> -char *object_get_canonical_path(Object *obj);
> +char *object_get_canonical_path(const Object *obj);
>  
>  /**
>   * object_resolve_path:
> diff --git a/qom/object.c b/qom/object.c
> index d0be42c8d6..c02487ec1a 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -1883,7 +1883,7 @@ object_property_add_const_link(Object *obj, const char *name,
>                                  NULL, OBJ_PROP_LINK_DIRECT);
>  }
>  
> -char *object_get_canonical_path_component(Object *obj)
> +char *object_get_canonical_path_component(const Object *obj)
>  {
>      ObjectProperty *prop = NULL;
>      GHashTableIter iter;
> @@ -1908,7 +1908,7 @@ char *object_get_canonical_path_component(Object *obj)
>      return NULL;
>  }
>  
> -char *object_get_canonical_path(Object *obj)
> +char *object_get_canonical_path(const Object *obj)
>  {
>      Object *root = object_get_root();
>      char *newpath, *path = NULL;
> 


