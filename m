Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995D8C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:33:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660AD20656
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 06:33:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660AD20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48985 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOccH-0004UL-9J
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 02:33:17 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOcbW-0004Ax-9u
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:32:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hOcbV-0000u4-C4
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:32:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hOcbV-0000t5-6W
	for qemu-devel@nongnu.org; Thu, 09 May 2019 02:32:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C3DDA87645
	for <qemu-devel@nongnu.org>; Thu,  9 May 2019 06:32:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com
	[10.36.116.45])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 345525D9D4;
	Thu,  9 May 2019 06:32:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 5909011AA3; Thu,  9 May 2019 08:32:20 +0200 (CEST)
Date: Thu, 9 May 2019 08:32:20 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <20190509063220.cfahgzlujtcv5etr@sirius.home.kraxel.org>
References: <20190503130034.24916-1-marcandre.lureau@redhat.com>
	<20190503130034.24916-5-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503130034.24916-5-marcandre.lureau@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Thu, 09 May 2019 06:32:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 4/6] Add vhost-user-input-pci
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> +static const VirtioPCIDeviceTypeInfo vhost_user_input_pci_info = {
> +    .base_name = TYPE_VHOST_USER_INPUT_PCI,
> +    .generic_name = "vhost-user-input-pci",
> +    .transitional_name = "vhost-user-input-pci-transitional",
> +    .non_transitional_name = "vhost-user-input-pci-non-transitional",

virtio-input is virtio 1.0 only, so we don't need these variants.
Incremental fix below, if you ack that I can squash it for the pull req.
Or you send a v3 (in case you have other changes pending).

cheers,
  Gerd

--- a/hw/virtio/vhost-user-input-pci.c
+++ b/hw/virtio/vhost-user-input-pci.c
@@ -13,7 +13,7 @@
 
 typedef struct VHostUserInputPCI VHostUserInputPCI;
 
-#define TYPE_VHOST_USER_INPUT_PCI "vhost-user-input-pci-base"
+#define TYPE_VHOST_USER_INPUT_PCI "vhost-user-input-pci"
 
 #define VHOST_USER_INPUT_PCI(obj) \
     OBJECT_CHECK(VHostUserInputPCI, (obj), TYPE_VHOST_USER_INPUT_PCI)
@@ -37,9 +37,7 @@ static void vhost_user_input_pci_instance_init(Object *obj)
 
 static const VirtioPCIDeviceTypeInfo vhost_user_input_pci_info = {
     .base_name = TYPE_VHOST_USER_INPUT_PCI,
-    .generic_name = "vhost-user-input-pci",
-    .transitional_name = "vhost-user-input-pci-transitional",
-    .non_transitional_name = "vhost-user-input-pci-non-transitional",
+    .generic_name = TYPE_VHOST_USER_INPUT_PCI,
     .parent = TYPE_VIRTIO_INPUT_PCI,
     .instance_size = sizeof(VHostUserInputPCI),
     .instance_init = vhost_user_input_pci_instance_init,

