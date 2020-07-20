Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3935BC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0322E22B4E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 15:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fm+I2pBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0322E22B4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxXMU-0006Q7-Ai
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 11:05:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jxXLo-0005ox-Qj
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 11:05:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36039
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dinechin@redhat.com>)
 id 1jxXLj-0001v1-2e
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 11:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595257502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LY4FYz7ecyXOstwS8bYmb41J6/ZVs3a+h5hMz+giOYg=;
 b=Fm+I2pBYr+VSyCCTbrMJzeGBee2/VTYOa1oeMG6AWEFugelohVvb3Z/Yn8HhaJMWxQokir
 LMtaqra7rs6G7Ukse5mMfrPhdAaNL5lbX6bzxgqcdcTkaP2+xOyLzCRYBwyGWNBODhB/y4
 l5zj+B74LZoRRWIYlvoCWgHvDn8LXxU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-rJEw9v5DP0GYJnKgNgdIiA-1; Mon, 20 Jul 2020 11:03:37 -0400
X-MC-Unique: rJEw9v5DP0GYJnKgNgdIiA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5447E80183C
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 15:03:36 +0000 (UTC)
Received: from turbo.dinechin.lan (ovpn-114-55.ams2.redhat.com [10.36.114.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 078722B6DB;
 Mon, 20 Jul 2020 15:03:28 +0000 (UTC)
References: <20200624131045.14512-1-kraxel@redhat.com>
 <20200624131045.14512-10-kraxel@redhat.com>
User-agent: mu4e 1.5.5; emacs 26.3
From: Christophe de Dinechin <dinechin@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v5 09/10] vga: build virtio-gpu as module
In-reply-to: <20200624131045.14512-10-kraxel@redhat.com>
Date: Mon, 20 Jul 2020 17:03:26 +0200
Message-ID: <7hmu3uqldt.fsf@turbo.dinechin.lan>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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
> Drops libvirglrenderer.so dependency from core qemu.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  util/module.c            |  6 ++++++
>  hw/display/Makefile.objs | 23 +++++++++++++----------
>  2 files changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/util/module.c b/util/module.c
> index 7c76d2a84b94..a74214eac052 100644
> --- a/util/module.c
> +++ b/util/module.c
> @@ -266,6 +266,12 @@ static struct {
>      { "usb-redir",             "hw-", "usb-redirect"          },
>      { "qxl-vga",               "hw-", "display-qxl"           },
>      { "qxl",                   "hw-", "display-qxl"           },
> +    { "virtio-gpu-device",     "hw-", "display-virtio-gpu"    },
> +    { "virtio-gpu-pci",        "hw-", "display-virtio-gpu"    },
> +    { "virtio-vga",            "hw-", "display-virtio-gpu"    },
> +    { "vhost-user-gpu-device", "hw-", "display-virtio-gpu"    },
> +    { "vhost-user-gpu-pci",    "hw-", "display-virtio-gpu"    },
> +    { "vhost-user-vga",        "hw-", "display-virtio-gpu"    },
>  };
>
>  static bool module_loaded_qom_all;
> diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
> index d619594ad4d3..e907f3182b0c 100644
> --- a/hw/display/Makefile.objs
> +++ b/hw/display/Makefile.objs
> @@ -49,16 +49,19 @@ common-obj-m += qxl.mo
>  qxl.mo-objs = qxl.o qxl-logger.o qxl-render.o
>  endif
>
> -common-obj-$(CONFIG_VIRTIO_GPU) += virtio-gpu-base.o virtio-gpu.o virtio-gpu-3d.o
> -common-obj-$(CONFIG_VHOST_USER_GPU) += vhost-user-gpu.o
> -common-obj-$(call land,$(CONFIG_VIRTIO_GPU),$(CONFIG_VIRTIO_PCI)) += virtio-gpu-pci.o
> -common-obj-$(call land,$(CONFIG_VHOST_USER_GPU),$(CONFIG_VIRTIO_PCI)) += vhost-user-gpu-pci.o
> -common-obj-$(CONFIG_VIRTIO_VGA) += virtio-vga.o
> -common-obj-$(CONFIG_VHOST_USER_VGA) += vhost-user-vga.o
> -virtio-gpu.o-cflags := $(VIRGL_CFLAGS)
> -virtio-gpu.o-libs += $(VIRGL_LIBS)
> -virtio-gpu-3d.o-cflags := $(VIRGL_CFLAGS)
> -virtio-gpu-3d.o-libs += $(VIRGL_LIBS)
> +ifeq ($(CONFIG_VIRTIO_GPU),y)
> +common-obj-m += virtio-gpu.mo
> +virtio-gpu-obj-$(CONFIG_VIRTIO_GPU) += virtio-gpu-base.o virtio-gpu.o virtio-gpu-3d.o
> +virtio-gpu-obj-$(CONFIG_VHOST_USER_GPU) += vhost-user-gpu.o
> +virtio-gpu-obj-$(call land,$(CONFIG_VIRTIO_GPU),$(CONFIG_VIRTIO_PCI)) += virtio-gpu-pci.o
> +virtio-gpu-obj-$(call land,$(CONFIG_VHOST_USER_GPU),$(CONFIG_VIRTIO_PCI)) += vhost-user-gpu-pci.o
> +virtio-gpu-obj-$(CONFIG_VIRTIO_VGA) += virtio-vga.o
> +virtio-gpu-obj-$(CONFIG_VHOST_USER_VGA) += vhost-user-vga.o
> +virtio-gpu.mo-objs := $(virtio-gpu-obj-y)
> +virtio-gpu.mo-cflags := $(VIRGL_CFLAGS)
> +virtio-gpu.mo-libs := $(VIRGL_LIBS)
> +endif
> +
>  common-obj-$(CONFIG_DPCD) += dpcd.o
>  common-obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx_dp.o

Reviewed-by: Christophe de Dinechin <dinechin@redhat.com>

--
Cheers,
Christophe de Dinechin (IRC c3d)


