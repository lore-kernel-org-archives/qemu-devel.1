Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5A1C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:06:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76AF1206F2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LlwAPz/h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76AF1206F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxXNX-0007VW-PM
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 11:06:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jxXMv-00070k-MW
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 11:06:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30108
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jxXMt-0002Cq-Um
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 11:06:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595257575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5XNPixfqnMh0gcklKuyAX+lTG0aX33QIaiBBy0JNos=;
 b=LlwAPz/hW/rAkTS9cAjDVmFliNnI8xJww+ixEpV6hK1e8VWu/EPdiTNAyRDKKEFeDI5xC6
 wK3u9MqR45bomvLTF5L3We7QkwJdu6agXuemqQulbwUcRLfXUqghZn6cgd99P0ytTccX8u
 Co0K7osSqDo1ETQBFMqqEpT51sJ7Jw0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-UZlKJWaxNiaNSTAVevZxUw-1; Mon, 20 Jul 2020 11:06:13 -0400
X-MC-Unique: UZlKJWaxNiaNSTAVevZxUw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35094100AA25
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 15:06:12 +0000 (UTC)
Received: from turbo.dinechin.lan (ovpn-114-55.ams2.redhat.com [10.36.114.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3869410027A6;
 Mon, 20 Jul 2020 15:06:04 +0000 (UTC)
References: <20200624131045.14512-1-kraxel@redhat.com>
 <20200624131045.14512-11-kraxel@redhat.com>
User-agent: mu4e 1.5.5; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v5 10/10] chardev: enable modules, use for braille
In-reply-to: <20200624131045.14512-11-kraxel@redhat.com>
Date: Mon, 20 Jul 2020 17:06:02 +0200
Message-ID: <7hk0yyql9h.fsf@turbo.dinechin.lan>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dinechin@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=205.139.110.61; envelope-from=dinechin@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 02:16:39
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
> Removes brlapi library dependency from core qemu.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  Makefile.objs         | 1 +
>  chardev/char.c        | 2 +-
>  util/module.c         | 1 +
>  chardev/Makefile.objs | 5 ++++-
>  4 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile.objs b/Makefile.objs
> index ca555ede0710..2dfcd19713f8 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -71,6 +71,7 @@ common-obj-$(CONFIG_TPM) += tpm.o
>
>  common-obj-y += backends/
>  common-obj-y += chardev/
> +common-obj-m += chardev/
>
>  common-obj-$(CONFIG_SECCOMP) += qemu-seccomp.o
>  qemu-seccomp.o-cflags := $(SECCOMP_CFLAGS)
> diff --git a/chardev/char.c b/chardev/char.c
> index e3051295ac37..df697f3ce9e0 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -527,7 +527,7 @@ static const ChardevClass *char_get_class(const char *driver, Error **errp)
>      const ChardevClass *cc;
>      char *typename = g_strdup_printf("chardev-%s", driver);
>
> -    oc = object_class_by_name(typename);
> +    oc = module_object_class_by_name(typename);
>      g_free(typename);
>
>      if (!object_class_dynamic_cast(oc, TYPE_CHARDEV)) {
> diff --git a/util/module.c b/util/module.c
> index a74214eac052..32b0547b8266 100644
> --- a/util/module.c
> +++ b/util/module.c
> @@ -272,6 +272,7 @@ static struct {
>      { "vhost-user-gpu-device", "hw-", "display-virtio-gpu"    },
>      { "vhost-user-gpu-pci",    "hw-", "display-virtio-gpu"    },
>      { "vhost-user-vga",        "hw-", "display-virtio-gpu"    },
> +    { "chardev-braille",       "chardev-", "baum"             },
>  };
>
>  static bool module_loaded_qom_all;
> diff --git a/chardev/Makefile.objs b/chardev/Makefile.objs
> index d68e1347f9af..3a58c9d329d6 100644
> --- a/chardev/Makefile.objs
> +++ b/chardev/Makefile.objs
> @@ -18,8 +18,11 @@ chardev-obj-$(CONFIG_WIN32) += char-win.o
>  chardev-obj-$(CONFIG_WIN32) += char-win-stdio.o
>
>  common-obj-y += msmouse.o wctablet.o testdev.o
> -common-obj-$(CONFIG_BRLAPI) += baum.o
> +
> +ifeq ($(CONFIG_BRLAPI),y)
> +common-obj-m += baum.o

Shouldn't that be a .mo?

>  baum.o-cflags := $(SDL_CFLAGS)
>  baum.o-libs := $(BRLAPI_LIBS)
> +endif
>
>  common-obj-$(CONFIG_SPICE) += spice.o


--
Cheers,
Christophe de Dinechin (IRC c3d)


