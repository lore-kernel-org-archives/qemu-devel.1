Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D064C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:31:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AC5E22482
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 14:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XmlPf3JT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC5E22482
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxWpB-0000zn-Ec
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 10:31:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jxWoF-0000IR-Fc
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:30:27 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21960
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jxWoC-0004ui-IZ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 10:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595255423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4SDwaVYyTv2/lxlr2u98RXStWoHHcIqpgrd0eocxidA=;
 b=XmlPf3JT36Tx79CiC7wnmvEVJTgXiWSAD4RdRUVRARllY8jVA8SQMD4tR+I6GsUi2ft+3H
 v2dPkCzdbtqqHUBqCvrBfLd+k23lLRmTuM6JAmddYGI9XrRq/rOXoNGED9PKzzMPkaQwru
 9VVVjcEv1ukn5ugNBuL2YijsbTw3obA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-JPVUKgySM0eFywcF8-zlww-1; Mon, 20 Jul 2020 10:30:18 -0400
X-MC-Unique: JPVUKgySM0eFywcF8-zlww-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88BA88005B0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 14:30:17 +0000 (UTC)
Received: from turbo.dinechin.lan (ovpn-114-55.ams2.redhat.com [10.36.114.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9112E18A54;
 Mon, 20 Jul 2020 14:30:09 +0000 (UTC)
References: <20200624131045.14512-1-kraxel@redhat.com>
 <20200624131045.14512-6-kraxel@redhat.com>
User-agent: mu4e 1.3.9; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v5 05/10] ccid: build smartcard as module
In-reply-to: <20200624131045.14512-6-kraxel@redhat.com>
Date: Mon, 20 Jul 2020 16:30:08 +0200
Message-ID: <7hd04qmf7z.fsf@turbo.dinechin.lan>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
> Drops libcacard.so dependency from core qemu.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  Makefile.objs        | 1 +
>  util/module.c        | 2 ++
>  hw/Makefile.objs     | 1 +
>  hw/usb/Makefile.objs | 4 +++-
>  4 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile.objs b/Makefile.objs
> index 7ce2588b89a3..ca555ede0710 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -59,6 +59,7 @@ common-obj-y += migration/
>  common-obj-y += audio/
>  common-obj-m += audio/
>  common-obj-y += hw/
> +common-obj-m += hw/
>
>  common-obj-y += replay/
>
> diff --git a/util/module.c b/util/module.c
> index ee560a4b4269..89da9a3cce05 100644
> --- a/util/module.c
> +++ b/util/module.c
> @@ -261,6 +261,8 @@ static struct {
>      const char *prefix;
>      const char *module;
>  } const qom_modules[] = {
> +    { "ccid-card-passthru",    "hw-", "usb-smartcard"         },
> +    { "ccid-card-emulated",    "hw-", "usb-smartcard"         },
>  };
>
>  static bool module_loaded_qom_all;
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index 4cbe5e4e57d6..af8fd9a510ed 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -43,4 +43,5 @@ devices-dirs-y += smbios/
>  endif
>
>  common-obj-y += $(devices-dirs-y)
> +common-obj-m += usb/
>  obj-y += $(devices-dirs-y)
> diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
> index fa5c3fa1b877..3c5b3d4fadd3 100644
> --- a/hw/usb/Makefile.objs
> +++ b/hw/usb/Makefile.objs
> @@ -29,11 +29,13 @@ common-obj-$(CONFIG_USB_NETWORK)      += dev-network.o
>
>  ifeq ($(CONFIG_USB_SMARTCARD),y)
>  common-obj-y                          += dev-smartcard-reader.o

I'm curious why you don't use something like:

common-obj-$(CONFIG_USB_SMARTCARD)

Do we want to be able to configure individual elements as modules?
Or is the intent to force as module things that are marked as 'y'?

> -common-obj-$(CONFIG_SMARTCARD)        += smartcard.mo
> +ifeq ($(CONFIG_SMARTCARD),y)
> +common-obj-m                          += smartcard.mo
>  smartcard.mo-objs := ccid-card-passthru.o ccid-card-emulated.o
>  smartcard.mo-cflags := $(SMARTCARD_CFLAGS)
>  smartcard.mo-libs := $(SMARTCARD_LIBS)
>  endif
> +endif
>
>  ifeq ($(CONFIG_POSIX),y)
>  common-obj-$(CONFIG_USB_STORAGE_MTP)  += dev-mtp.o


--
Cheers,
Christophe de Dinechin (IRC c3d)


