Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF97C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D15F620B1F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzTV2AEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D15F620B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxWdY-0006Bw-2T
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 10:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jxWbW-0002s8-Hy
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:17:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24199
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jxWbG-0002pV-BD
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595254621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YCwtlwfbDn462d1r/IyFvYkVgG8sFkAb/kcergJIeyk=;
 b=bzTV2AEIaRF36kNRt7qP9bimqZRG3G5xh366GnhgD6N5GMYvR37GixFE/c5TnaL1JHqKIS
 AOK7vq2/HqFERA+TAjwKlJ9Aom6mr9r8Q0Sxzk615wIrZGO22weM/GYpRJZIupOZJzXwUu
 E1bMl++x6FlXfRLdVpxEbL9iMtPPSpg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-UwvHLOuiOg6hM7EixazEfQ-1; Mon, 20 Jul 2020 10:17:00 -0400
X-MC-Unique: UwvHLOuiOg6hM7EixazEfQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 106745257D
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 14:16:34 +0000 (UTC)
Received: from turbo.dinechin.lan (ovpn-114-55.ams2.redhat.com [10.36.114.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3918010027AC;
 Mon, 20 Jul 2020 14:16:32 +0000 (UTC)
References: <20200624131045.14512-1-kraxel@redhat.com>
 <20200624131045.14512-2-kraxel@redhat.com>
User-agent: mu4e 1.3.9; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v5 01/10] module: qom module support
In-reply-to: <20200624131045.14512-2-kraxel@redhat.com>
Date: Mon, 20 Jul 2020 16:16:30 +0200
Message-ID: <7hlfjemfup.fsf@turbo.dinechin.lan>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dinechin@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 03:17:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
> Add support for qom types provided by modules.  For starters use a
> manually maintained list which maps qom type to module and prefix.
>
> Two load functions are added:  One to load the module for a specific
> type, and one to load all modules (needed for object/device lists as
> printed by -- for example -- qemu -device help).
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/qemu/module.h |  2 ++
>  util/module.c         | 55 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)
>
> diff --git a/include/qemu/module.h b/include/qemu/module.h
> index 011ae1ae7605..9121a475c1b6 100644
> --- a/include/qemu/module.h
> +++ b/include/qemu/module.h
> @@ -70,5 +70,7 @@ void register_dso_module_init(void (*fn)(void), module_init_type type);
>
>  void module_call_init(module_init_type type);
>  bool module_load_one(const char *prefix, const char *lib_name);
> +void module_load_qom_one(const char *type);
> +void module_load_qom_all(void);
>
>  #endif
> diff --git a/util/module.c b/util/module.c
> index e48d9aacc05a..ee560a4b4269 100644
> --- a/util/module.c
> +++ b/util/module.c
> @@ -245,3 +245,58 @@ bool module_load_one(const char *prefix, const char *lib_name)
>  #endif
>      return success;
>  }
> +
> +/*
> + * Building devices and other qom objects modular is mostly useful in
> + * case they have dependencies to external shared libraries, so we can
> + * cut down the core qemu library dependencies.  Which is the case for
> + * only a very few devices & objects.
> + *
> + * So with the expectation that this will be rather the exception than
> + * to rule and the list will not gain that many entries go with a

Nit: Add a comma after "entries"

I would also indicate that this list needs to be sorted by prefix/module

> + * simple manually maintained list for now.
> + */
> +static struct {
> +    const char *type;
> +    const char *prefix;
> +    const char *module;

Because of the sorting rule, it is more intuitive to put the module first
and the type last, for cases where you have

    mod1 prefix1 type1
    mod1 prefix1 type2
    mod1 prefix1 type3
    mod2 prefix2 type1

Visually, I expect the constants to come first.


> +} const qom_modules[] = {
> +};
> +
> +static bool module_loaded_qom_all;
> +
> +void module_load_qom_one(const char *type)
> +{
> +    int i;
> +
> +    if (module_loaded_qom_all) {
> +        return;
> +    }
> +    for (i = 0; i < ARRAY_SIZE(qom_modules); i++) {
> +        if (strcmp(qom_modules[i].type, type) == 0) {
> +            module_load_one(qom_modules[i].prefix,
> +                            qom_modules[i].module);
> +            return;
> +        }
> +    }
> +}
> +
> +void module_load_qom_all(void)
> +{
> +    int i;
> +
> +    if (module_loaded_qom_all) {
> +        return;
> +    }
> +    for (i = 0; i < ARRAY_SIZE(qom_modules); i++) {
> +        if (i > 0 && (strcmp(qom_modules[i - 1].module,
> +                             qom_modules[i].module) == 0 &&
> +                      strcmp(qom_modules[i - 1].prefix,
> +                             qom_modules[i].prefix) == 0)) {
> +            /* one module implementing multiple types -> load only once */

This is the sorting requirement I'm talking about

> +            continue;
> +        }
> +        module_load_one(qom_modules[i].prefix, qom_modules[i].module);
> +    }
> +    module_loaded_qom_all = true;
> +}


--
Cheers,
Christophe de Dinechin (IRC c3d)


