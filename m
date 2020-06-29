Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8803C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 23:09:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B45C020776
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 23:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JLKMqzrt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B45C020776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq2u7-0006lf-Vk
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 19:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jq2tW-0006Ca-Ps
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 19:08:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27713
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jq2tU-0003K0-Re
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 19:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593472135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SC42t8WaieQ7WnllPFd5Xe81/5843oVjyHywjfwau2I=;
 b=JLKMqzrtYuM5bDVE7gm3HC2Sp4fqN66PX38BFCF12zX0Gwj7nHKbiCmBFWUzgrWj9eLBMH
 3ddaDeEsn2XRgnICboOVEhVqnqOE0gDpw5Mt/X+rGZ5TDoMlpr8vglHGlo14vCnm32aQXw
 BgiL/DIew1Suy5VjHFHWU8ETYik02sM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-eKj06PEePJ-oDw2e0Fb6jw-1; Mon, 29 Jun 2020 19:08:53 -0400
X-MC-Unique: eKj06PEePJ-oDw2e0Fb6jw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45B4E107ACCA;
 Mon, 29 Jun 2020 23:08:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-41.ams2.redhat.com
 [10.36.112.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E574C9CFF1;
 Mon, 29 Jun 2020 23:08:43 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1ABFA59CC; Tue, 30 Jun 2020 01:08:43 +0200 (CEST)
Date: Tue, 30 Jun 2020 01:08:43 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH 08/10] build: Add SPICE_CFLAGS and SPICE_LIBS to relevant
 files
Message-ID: <20200629230843.b4s7rajxw5qfp3ei@sirius.home.kraxel.org>
References: <20200626164307.3327380-1-dinechin@redhat.com>
 <20200626164307.3327380-9-dinechin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200626164307.3327380-9-dinechin@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 19:08:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

>  obj-$(CONFIG_PC) += pc.o pc_sysfw.o
> +pc.o-cflags += $(SPICE_CFLAGS)

Hmm, looks strange.  Why does pc.c need spice?

> +qmp-cmds.o-cflags += $(SPICE_CFLAGS)
> +hmp-cmds.o-cflags += $(SPICE_CFLAGS)

spice monitor commands need this I guess?

> +misc.o-cflags += $(SPICE_CFLAGS)

Why this?

> +vl.o-cflags := $(GPROF_CFLAGS) $(SDL_CFLAGS) $(SPICE_CFLAGS)

spice init probably.

> -stub-obj-y += vmgenid.o
>  stub-obj-y += sysbus.o
>  stub-obj-y += tpm.o
>  stub-obj-y += trace-control.o
> +stub-obj-y += vmgenid.o

Huh?

> -spice-app.mo-cflags := $(GIO_CFLAGS)
> -spice-app.mo-libs := $(GIO_LIBS)
> +spice-app.mo-cflags := $(GIO_CFLAGS) $(SPICE_CFLAGS)
> +spice-app.mo-libs := $(GIO_LIBS) $(SPICE_LIBS)

Good.

> --- a/util/module.c
> +++ b/util/module.c
> @@ -22,11 +22,11 @@
>  #ifdef CONFIG_MODULE_UPGRADES
>  #include "qemu-version.h"
>  #endif
> -#ifdef CONFIG_TRACE_RECORDER
>  #include "trace/recorder.h"
> -#endif
>  
>  
> +RECORDER(modules, 16, "QEMU load modules");
> +
>  typedef struct ModuleEntry
>  {
>      void (*init)(void);
> @@ -85,6 +85,15 @@ void register_dso_module_init(void (*fn)(void), module_init_type type)
>  {
>      ModuleEntry *e;
>  
> +#ifdef CONFIG_TRACE_RECORDER
> +    static const char *name[] = {
> +        "MIGRATION", "BLOCK", "OPTS", "QOM",
> +        "TRACE", "XEN_BACKEND", "LIBQOS", "FUZZ_TARGET",
> +        "MAX"
> +    };
> +#endif
> +    record(modules, "Register DSO module init %p type %u %+s",
> +           fn, type, name[type]);
>      init_lists();
>  
>      e = g_malloc0(sizeof(*e));

Unrelated change.

(the recorder stuff should probably integrate with qemu trace support,
so you can record any trace point qemu has, but that'll be another patch
series ...)

take care,
  Gerd


