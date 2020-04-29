Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B1C2C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38DD520775
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 08:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdAVtH6s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38DD520775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTiWN-00022w-Cy
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 04:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTiUz-0000nZ-7J
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:55:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTiRa-0005YR-Ii
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:55:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57783
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jTiRa-0005YG-2z
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 04:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588150308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a07XQU7M1jmwraNk/G25Gid9EyUj7auQZkIAgB+k6iQ=;
 b=TdAVtH6sP2i8zJq07kXqKehIn6pQf1MfHpQDq8zmy6y6glfJHr1Z5IJXPW1vi4YHPQQqZX
 Dpy+DPKZODfKZGUd2dhd4HskHsaj0CUjNpQSJo5uZlPjDPy4HJ5SYwChHFX4/I/pTS4kNy
 paLkIH6fDt93L/qwBWXKvp+dq1JL4wY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-vy_ljQf2NGOumbaTdUQENw-1; Wed, 29 Apr 2020 04:51:46 -0400
X-MC-Unique: vy_ljQf2NGOumbaTdUQENw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9612E107ACCA;
 Wed, 29 Apr 2020 08:51:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97FFB100034E;
 Wed, 29 Apr 2020 08:51:41 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 75AE11753B; Wed, 29 Apr 2020 10:51:25 +0200 (CEST)
Date: Wed, 29 Apr 2020 10:51:25 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH 4/5] ramfb: add sanity checks to
 ramfb_create_display_surface
Message-ID: <20200429085125.ui4jxrsmgd35yoqr@sirius.home.kraxel.org>
References: <20200422100211.30614-1-kraxel@redhat.com>
 <20200422100211.30614-5-kraxel@redhat.com>
 <b4af9628-1585-9dc5-214d-b55db4760da1@redhat.com>
 <20200423114129.lil77p4iqy3jc5v7@sirius.home.kraxel.org>
 <7eb38a07-a50c-2695-2ca7-822f5c1408eb@redhat.com>
 <20200427111144.iphotoyrq65yrjd7@sirius.home.kraxel.org>
 <0755beb7-324d-42e3-6e3a-d1a594f64c44@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0755beb7-324d-42e3-6e3a-d1a594f64c44@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org,
 hqm03ster@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  Hi,

> > Not fully sure we can do that without breaking something, might be a
> > negative stride is used for upside down images (last scanline comes
> > first in memory).
>=20
> Ugh... Upside down images???... Well, OK, I guess. :)

Well, in the unix world (x11, wayland) x=3D0,y=3D0 is the upper left corner=
.
In the windows world x=3D0,y=3D0 is the lower left corner, in opengl too.
If you don't handle this correctly your guest display might show up
upside down ;)

qxl uses negative strides to signal that.  Looking at the code I see qxl
handles this locally (grep for qxl_stride in qxl-render.c), it doesn't
propagate into ui/console.c, so it should be safe to change the
qemu_create_displaysurface_from() arguments to unsigned from qxl point
of view.

take care,
  Gerd


