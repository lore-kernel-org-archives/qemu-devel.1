Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AB2C04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 07:01:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9E027C73
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 07:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9E027C73
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58826 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXgyM-0007Ch-U8
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 03:01:34 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hXgwe-0005xe-UJ
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:59:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hXgwd-0003SS-1W
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:59:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hXgwb-0003NE-4q
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:59:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A29B0308621B;
	Mon,  3 Jun 2019 06:59:41 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-131.ams2.redhat.com
	[10.36.117.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 33A2066D51;
	Mon,  3 Jun 2019 06:59:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 756AB11AAF; Mon,  3 Jun 2019 08:59:37 +0200 (CEST)
Date: Mon, 3 Jun 2019 08:59:37 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Message-ID: <20190603065937.ogbgxtzao5qlrken@sirius.home.kraxel.org>
References: <20190529072144.26737-1-kraxel@redhat.com>
	<20190529072144.26737-5-kraxel@redhat.com>
	<CAJ+F1C+u9mojgn40JUMN975jf3WsJxnWtd_O0gwDYKtTAauTCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+u9mojgn40JUMN975jf3WsJxnWtd_O0gwDYKtTAauTCA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Mon, 03 Jun 2019 06:59:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 4/4] egl-helpers: add modifier support
 to egl_dmabuf_import_texture()
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
Cc: Alex Williamson <alex.williamson@redhat.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > +#ifdef EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT
> > +    if (dmabuf->modifier) {
> > +        attrs[i++] = EGL_DMA_BUF_PLANE0_MODIFIER_LO_EXT;
> > +        attrs[i++] = (dmabuf->modifier >>  0) & 0xffffffff;
> > +        attrs[i++] = EGL_DMA_BUF_PLANE0_MODIFIER_HI_EXT;
> > +        attrs[i++] = (dmabuf->modifier >> 32) & 0xffffffff;
> > +    }
> > +#endif
> 
> Shouldn't there be at least a warning for #else?

I don't think so.  In most cases (single gpu device in the host) things
will work fine even without specifying the modifier.

cheers,
  Gerd


