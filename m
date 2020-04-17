Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A528AC2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 06:43:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B58D20771
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 06:43:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0RGKHVB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B58D20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPKiN-0000mn-KH
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 02:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jPKgF-00076N-KP
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 02:40:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jPKgE-0007ok-Hd
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 02:40:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27371
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jPKgC-0007mA-NT
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 02:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587105647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fEMxjAYNaA24PRwCIBTPQwHjswgDw/0sJlHDOVvm1G0=;
 b=G0RGKHVBGCWhukryt+9GpYPQKZ65rP6bz76xHaELuibvrxwuO1anf5QRb4sXZRNhJhb1Iv
 1T7KY8xsKwIUXeoL9epfUcryf59XElChn5UKUculiYqoN5wJAd2moeiwtugD2AfEvPmWT6
 k1lyN1Ci570AtmdLddJQMwBAioZBb4A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-2eY-1d94P_-ssnl8yY77gg-1; Fri, 17 Apr 2020 02:40:44 -0400
X-MC-Unique: 2eY-1d94P_-ssnl8yY77gg-1
Received: by mail-wr1-f70.google.com with SMTP id h95so519494wrh.11
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 23:40:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=2mHImV1cMqRM3Vy0b2SFiCR52s4bh8qmJiZQmqCJy9w=;
 b=QTMrDBd+i/QgrkLdzQFCgXe24ZiDiFKXCXsSwdR81Xeiw1MIm9eulMd1KzKhSewrJI
 VsI8XJuPBndXO7Oltifn3E8IW3e97IYwL8rnUCYoX+oY8MYr3FP7Z4XFuJ1wMxD6i+t2
 HhxTTLPPEDLgl3s4jOmmjDstXfRvDY8po+idhEVBtKGMVpqF4imO9NnGlSLj1wm99t3Y
 86FwZQ80J/27WB/0fN78gY0Pew21Jxx3vA1FzbzSpzxbKpOehK4C9/AofDi/F+x+ciLf
 X/WO+lCrD3sd6w+nZFzmXbXtPgCO3b6IgKxciUDbEZablNVL0jAsHNGoSYKYZjcaOgkx
 tm5A==
X-Gm-Message-State: AGi0Pubp3DJgY7ETXPFwjrFbItyODgZ1UjMyIumOhqzp1zEWMp75uAdu
 DgyKnDvC+3M0dJ9vIkDSpEMiSM8Dord/SMjH6N/mH/cB8x5kKnv/5ZZghZSNlJdgelqw/kPwiu4
 nDKndmXGsP/UZaw4=
X-Received: by 2002:a1c:9e43:: with SMTP id h64mr1749155wme.0.1587105642864;
 Thu, 16 Apr 2020 23:40:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypKzlAP17UU5r0iAIWNFd7owlN6f/orkvhQ1YHL+Xld4z3riVhqvA9+PyWSCH4So4BHxOoywrA==
X-Received: by 2002:a1c:9e43:: with SMTP id h64mr1749122wme.0.1587105642603;
 Thu, 16 Apr 2020 23:40:42 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
 by smtp.gmail.com with ESMTPSA id v21sm6436460wmj.8.2020.04.16.23.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2020 23:40:42 -0700 (PDT)
Date: Fri, 17 Apr 2020 02:40:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.0 00/12] various bugfixes
Message-ID: <20200417024020-mutt-send-email-mst@kernel.org>
References: <20200414133052.13712-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200414133052.13712-1-philmd@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Fabien Chouteau <chouteau@adacore.com>,
 Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>, Max Reitz <mreitz@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 14, 2020 at 03:30:40PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Collection of bugfixes for 5.0.
>=20
> Only vhost-user-gpu/grlib_ahb_apb_pnp patches are reviewed.
>=20
> As 5.0-rc3 is tomorrow, I thought it could help to gather
> them and resend altogether.


So who's applying all this stuff? Peter?

> Regards,
>=20
> Phil.
>=20
> Mansour Ahmadi (1):
>   hw/block/pflash: Check return value of blk_pwrite()
>=20
> Philippe Mathieu-Daud=E9 (11):
>   Revert "prevent crash when executing guest-file-read with large count"
>   qga: Extract guest_file_handle_find() to commands-common.h
>   qga: Extract qmp_guest_file_read() to common commands.c
>   qga: Restrict guest-file-read count to 48 MB to avoid crashes
>   vhost-user-gpu: Release memory returned by vu_queue_pop() with free()
>   hw/openrisc/pic_cpu: Use qdev gpio rather than qemu_allocate_irqs()
>   hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to AHB PnP
>     registers
>   hw/misc/grlib_ahb_apb_pnp: Fix AHB PnP 8-bit accesses
>   hw/display/sm501: Avoid heap overflow in sm501_2d_operation()
>   gdbstub: Do not use memset() on GByteArray
>   gdbstub: Introduce gdb_get_freg32() to get float32 registers
>=20
>  qga/qapi-schema.json                    |  6 +++--
>  include/exec/gdbstub.h                  | 22 ++++++++++++++++
>  qga/commands-common.h                   | 21 +++++++++++++++
>  contrib/vhost-user-gpu/vhost-user-gpu.c |  4 +--
>  contrib/vhost-user-gpu/virgl.c          |  2 +-
>  hw/block/pflash_cfi01.c                 |  8 +++++-
>  hw/block/pflash_cfi02.c                 |  8 +++++-
>  hw/display/sm501.c                      |  6 +++++
>  hw/misc/grlib_ahb_apb_pnp.c             | 11 ++++++++
>  hw/openrisc/pic_cpu.c                   |  5 ++--
>  qga/commands-posix.c                    | 29 +++++---------------
>  qga/commands-win32.c                    | 35 ++++++-------------------
>  qga/commands.c                          | 33 +++++++++++++++++++++++
>  target/arm/gdbstub.c                    |  3 +--
>  target/sh4/gdbstub.c                    |  6 ++---
>  target/xtensa/gdbstub.c                 |  6 ++---
>  16 files changed, 136 insertions(+), 69 deletions(-)
>  create mode 100644 qga/commands-common.h
>=20
> --=20
> 2.21.1


