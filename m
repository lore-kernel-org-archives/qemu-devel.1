Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D621CC04AA9
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6B1F20873
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6B1F20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46846 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM6V0-0007U1-Ux
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:51:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1hM6AU-0005Jg-Si
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:30:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1hM6AP-0003Vm-Ls
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:30:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24268)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1hM6AL-0002Ea-Vl
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:30:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E774130917AA;
	Thu,  2 May 2019 07:28:43 +0000 (UTC)
Received: from kaapi (ovpn-116-23.phx2.redhat.com [10.3.116.23])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 26D235DA34;
	Thu,  2 May 2019 07:28:39 +0000 (UTC)
Date: Thu, 2 May 2019 12:58:37 +0530 (IST)
From: P J P <ppandit@redhat.com>
X-X-Sender: pjp@kaapi
To: Gerd Hoffmann <kraxel@redhat.com>
In-Reply-To: <20190425063534.32747-1-ppandit@redhat.com>
Message-ID: <nycvar.YSQ.7.76.1905021257340.11724@xnncv>
References: <20190425063534.32747-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 02 May 2019 07:28:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qxl: check release info object
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
Cc: Bugs SysSec <bugs-syssec@rub.de>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502072837.mhRaqDXAnKB0AYU8rRRv2k5rs7FTdSkXBGT_ad8odU0@z>

+-- On Thu, 25 Apr 2019, P J P wrote --+
| When releasing spice resources in release_resource() routine,
| if release info object 'ext.info' is null, it leads to null
| pointer dereference. Add check to avoid it.
| 
| diff --git a/hw/display/qxl.c b/hw/display/qxl.c
| index c8ce5781e0..632923add2 100644
| --- a/hw/display/qxl.c
| +++ b/hw/display/qxl.c
| @@ -777,6 +777,9 @@ static void interface_release_resource(QXLInstance *sin,
|      QXLReleaseRing *ring;
|      uint64_t *item, id;
|  
| +    if (!ext.info) {
| +        return;
| +    }
|      if (ext.group_id == MEMSLOT_GROUP_HOST) {
|          /* host group -> vga mode update request */
|          QXLCommandExt *cmdext = (void *)(intptr_t)(ext.info->id);
| 

Ping...!
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F

