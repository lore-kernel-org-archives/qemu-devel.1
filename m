Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D470C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61F3320B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONF6Rt+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F3320B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxWil-00053s-LZ
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 10:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jxWfS-0000vN-M3
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:21:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46426
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jxWfQ-0003X4-Bk
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595254879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yOM5+LaZ+NpEwww2zAfULROns6G6qYD2oxQus1YsOxs=;
 b=ONF6Rt+/XvHnzPYNeuhqYH819epLfadAQ61ZjPT2bdd2eydPxJFbzhIux7ByhL+r8H3Aru
 C3KlniHSXX+01m58ozOWEQO/vDvdasYYeOdRDMFN+Hp4c9dzSvXeepqI24EGfRsnfJMeH+
 IUnDHPiWJc3M0q0kyf0HK+xaPRELVlM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-We7Q6k_1MDm4NExTVyUYjA-1; Mon, 20 Jul 2020 10:21:17 -0400
X-MC-Unique: We7Q6k_1MDm4NExTVyUYjA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBAA98017FB
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 14:21:16 +0000 (UTC)
Received: from turbo.dinechin.lan (ovpn-114-55.ams2.redhat.com [10.36.114.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B43A60E1C;
 Mon, 20 Jul 2020 14:20:57 +0000 (UTC)
References: <20200624131045.14512-1-kraxel@redhat.com>
 <20200624131045.14512-3-kraxel@redhat.com>
User-agent: mu4e 1.3.9; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v5 02/10] object: qom module support
In-reply-to: <20200624131045.14512-3-kraxel@redhat.com>
Date: Mon, 20 Jul 2020 16:20:55 +0200
Message-ID: <7himeimfnc.fsf@turbo.dinechin.lan>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dinechin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 02:11:17
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020-06-24 at 15:10 CEST, Gerd Hoffmann wrote...
> Little helper function to load modules on demand.  In most cases adding
> module loading support for devices and other objects is just
> s/object_class_by_name/module_object_class_by_name/ in the right spot.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/qom/object.h | 12 ++++++++++++
>  qom/object.c         | 14 ++++++++++++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/include/qom/object.h b/include/qom/object.h
> index 94a61ccc3fe8..51f188137f1f 100644
> --- a/include/qom/object.h
> +++ b/include/qom/object.h
> @@ -994,6 +994,18 @@ bool object_class_is_abstract(ObjectClass *klass);
>   */
>  ObjectClass *object_class_by_name(const char *typename);
>
> +/**
> + * module_object_class_by_name:
> + * @typename: The QOM typename to obtain the class for.
> + *
> + * For objects which might be provided by a module.  Behaves like
> + * object_class_by_name, but additionally tries to load the module
> + * needed in case the class is not available.
> + *
> + * Returns: The class for @typename or %NULL if not found.
> + */
> +ObjectClass *module_object_class_by_name(const char *typename);
> +
>  void object_class_foreach(void (*fn)(ObjectClass *klass, void *opaque),
>                            const char *implements_type, bool include_abstract,
>                            void *opaque);
> diff --git a/qom/object.c b/qom/object.c
> index 6ece96bc2bfc..34daaf1280f5 100644
> --- a/qom/object.c
> +++ b/qom/object.c
> @@ -985,6 +985,20 @@ ObjectClass *object_class_by_name(const char *typename)
>      return type->class;
>  }
>
> +ObjectClass *module_object_class_by_name(const char *typename)
> +{
> +    ObjectClass *oc;
> +
> +    oc = object_class_by_name(typename);
> +#ifdef CONFIG_MODULES
> +    if (!oc) {
> +        module_load_qom_one(typename);
> +        oc = object_class_by_name(typename);
> +    }
> +#endif

I'm wondering if there is any reason to only trigger the module load when
you don't find the object class. You could simply call module_load_qom_one
under #ifdef CONFIG_MODULES.

Performance wise, I don't think this makes much of a difference, and it
simplifies the logical flow IMO.

> +    return oc;
> +}
> +
>  ObjectClass *object_class_get_parent(ObjectClass *class)
>  {
>      TypeImpl *type = type_get_parent(class->type);


--
Cheers,
Christophe de Dinechin (IRC c3d)


