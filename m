Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49623C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1758020663
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 17:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nf8yUPQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1758020663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jos8G-0001uo-Ai
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 13:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jos7b-0001L1-1m
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 13:26:39 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60891
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jos7Z-0000AW-I5
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 13:26:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593192397;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=esyB4+t3qsym6DQCSbOYMNLRb563kKgivJQJD+9VGgA=;
 b=Nf8yUPQTJmlMQHI1oF6QRU/OGU2NTJpt1SNSHcOrV1BApVASYnDWrmgIQT21HeMR/CRruI
 WjCO7TADuhh6VqxZHJyNUR0SpjoQ4xE20/jtiU+skP74A0Q/mhEBQ1sXSunibQIFooJ9MJ
 oYF0cKLaZT8TrGymNbcP/PJyIFlGB5Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-j68kDxbnPlCJQKilRQL8OA-1; Fri, 26 Jun 2020 13:26:33 -0400
X-MC-Unique: j68kDxbnPlCJQKilRQL8OA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 266BB193F560;
 Fri, 26 Jun 2020 17:26:32 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0391E19C4F;
 Fri, 26 Jun 2020 17:26:17 +0000 (UTC)
Date: Fri, 26 Jun 2020 18:26:13 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH 08/10] build: Add SPICE_CFLAGS and SPICE_LIBS to relevant
 files
Message-ID: <20200626172613.GN1028934@redhat.com>
References: <20200626164307.3327380-1-dinechin@redhat.com>
 <20200626164307.3327380-9-dinechin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200626164307.3327380-9-dinechin@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/26 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 26, 2020 at 06:43:05PM +0200, Christophe de Dinechin wrote:
> Instead of adding the spice build flags to the top-level build
> options, add them where they are necessary. This is a step to move the
> burden of linking with spice libraries away from the top-level qemu.
> 
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> ---
>  configure                |  4 ++--
>  hw/display/Makefile.objs |  1 +
>  hw/i386/Makefile.objs    |  1 +
>  monitor/Makefile.objs    |  3 +++
>  softmmu/Makefile.objs    |  2 +-
>  stubs/Makefile.objs      |  2 +-
>  ui/Makefile.objs         |  4 ++--
>  util/module.c            | 13 +++++++++++--
>  8 files changed, 22 insertions(+), 8 deletions(-)

> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index f32b9e47a3..1df8bb3814 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -19,10 +19,10 @@ stub-obj-y += replay.o
>  stub-obj-y += runstate-check.o
>  stub-obj-$(CONFIG_SOFTMMU) += semihost.o
>  stub-obj-y += set-fd-handler.o
> -stub-obj-y += vmgenid.o
>  stub-obj-y += sysbus.o
>  stub-obj-y += tpm.o
>  stub-obj-y += trace-control.o
> +stub-obj-y += vmgenid.o
>  stub-obj-y += vmstate.o
>  stub-obj-$(CONFIG_SOFTMMU) += win32-kbd-hook.o
>

This looks unrelated to this series.



> diff --git a/util/module.c b/util/module.c
> index 2fa93561fe..29b4806520 100644
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

This looks unrelated too, but in general debugging should go via QEMU's
standard trace backends.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


