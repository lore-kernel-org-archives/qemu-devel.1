Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDB0C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:26:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 315622084D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 14:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDTcN14a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 315622084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRGKk-0003CX-6O
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 10:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jRGJm-0002BU-K2
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jRGJm-00058g-5w
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:25:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23823
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jRGJl-00056H-NK
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 10:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587565536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8eUZC5T50/0DAtR8iXBX8bpbAwXqG7Tyi/wpZVAJ68s=;
 b=HDTcN14afIn+Uccz1DR0BVWhpwuZjHTMTGZFgmP6aKaKtauM/dVKPIQOvscI41Zek7pDWM
 3VLhfb4vfX3rCo5y0dq7NYyohl3jTXVPARmbtOgzDilZJC7ERLOPiKDFbFw5se4e9LaCnu
 Om6k0tNyRWXYYfb/ixSUct2ey5KfMk4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-KFvNeRGVPFG_G80asSI9MQ-1; Wed, 22 Apr 2020 10:25:35 -0400
X-MC-Unique: KFvNeRGVPFG_G80asSI9MQ-1
Received: by mail-wm1-f71.google.com with SMTP id f81so888767wmf.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 07:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6WOvLtuHBMKEZgjFhOYEvQecHZA07otUIaySV1IVLrs=;
 b=GZDA7qhVCXv2KRvpJM8vMo/iClb7ZbTs+z6ri9SxIVcuKXEyujik/D5lObn3wRNC6o
 cQqTEWFNOeHQpP8IkeXvJLgY4WyMa7Bu147VnRC2XdhsQAXEHBvfimmtQI/TLytw+pSS
 QPHQL79v3qX5D+fiZ41bvhxshH3Yr2Z57bDrtwxLZ2mTgPAwr/LlRmiMHCWpKrsCN215
 7ZSGZ5gQf/C4oAt3+oDyxV/WfWksF1sQPFGTImIFFpltpGRY0ndxXa0FZw5hwoiiauzW
 6H475iRafc9Y3B04uCC47Kt4HNvaLsITpG4Mrl9T5fiIZDZrwL41wrim2mQA0aUVrcNt
 RW3g==
X-Gm-Message-State: AGi0PuZMK2+HBBzITIDMt7ng8f5OvYNMHljdHBlQwpuV0L+5pIToZ/Qa
 9/CN+dYAwicQI1PpDwPHSm6md6uN3QQXboDcTaiOdra30dZ1WqBnfqktwY9/qAfcwqfroJfpoEx
 Y6a4fWKOT+KXVNWg=
X-Received: by 2002:a1c:5403:: with SMTP id i3mr11518916wmb.10.1587565533738; 
 Wed, 22 Apr 2020 07:25:33 -0700 (PDT)
X-Google-Smtp-Source: APiQypLJMJ0NSZJtiYvI+h0qM6qzDjsioNRL5ibiLWzTtvrbZ0ouUz8LTRrSFVg8VBE+Y42jQZXoOA==
X-Received: by 2002:a1c:5403:: with SMTP id i3mr11518900wmb.10.1587565533557; 
 Wed, 22 Apr 2020 07:25:33 -0700 (PDT)
Received: from redhat.com (bzq-79-183-51-3.red.bezeqint.net. [79.183.51.3])
 by smtp.gmail.com with ESMTPSA id m15sm7771861wmc.35.2020.04.22.07.25.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2020 07:25:33 -0700 (PDT)
Date: Wed, 22 Apr 2020 10:25:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] virtio-vga: fix virtio-vga bar ordering
Message-ID: <20200422102504-mutt-send-email-mst@kernel.org>
References: <20200421214853.14412-1-anthoine.bourgeois@gmail.com>
 <20200422020354-mutt-send-email-mst@kernel.org>
 <20200422104941.qp4lkblm7txlglm2@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20200422104941.qp4lkblm7txlglm2@sirius.home.kraxel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/22 09:07:24
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
Cc: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 22, 2020 at 12:49:41PM +0200, Gerd Hoffmann wrote:
> On Wed, Apr 22, 2020 at 02:04:36AM -0400, Michael S. Tsirkin wrote:
> > On Tue, Apr 21, 2020 at 11:48:53PM +0200, Anthoine Bourgeois wrote:
> > > With virtio-vga, pci bar are reordered. Bar #2 is used for compatibil=
ity
> > > with stdvga. By default, bar #2 is used by virtio modern io bar.
> > > This bar is the last one introduce in the virtio pci bar layout and i=
t's
> > > crushed by the virtio-vga reordering. So virtio-vga and
> > > modern-pio-notify are incompatible because virtio-vga failed to
> > > initialize with this option.
> > >=20
> > > This fix exchange the modern io bar with the modern memory bar,
> > > replacing the msix bar that is never impacted anyway.
> > >=20
> > > Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
> >=20
> > Such changes generally need to be tied to machine version.
>=20
> Given that modern-pio-notify is off by default and
> virtio-vga,modern-pio-notify=3Don is broken I think we don't need to worr=
y
> about compatibility in this specific case (assuming the patch is updated
> to not shuffle around the msix bar, see other reply).
>=20
> cheers,
>   Gerd

OK, just worth documenting that this will break cross-version
migration if modern-pio-notify is enabled.


