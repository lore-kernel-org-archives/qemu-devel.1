Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B189C55186
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23D7E2077D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 12:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2g8Rtvv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23D7E2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRbMb-0008HD-8X
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 08:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jRbLo-0007qp-Hh
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 08:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jRbLn-0006AF-ND
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 08:53:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29482
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jRbLn-0006A1-2n
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 08:53:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587646385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3whGjkSTpqbseMzFGLvqUorvXqy7U+Ee7SowOoChou8=;
 b=P2g8RtvvCM4jrUuVSxTspxTawwjpW1G45uHnPjeJvoRbn387X0JBINeVy/flo/1kSd3Ezq
 b8MrT92VG5taP54qKLW06hkaeYLqRaDlWPqO9hVJ8jqxkHdbfM24sKe/iPvJu3EQEI2WHu
 7/6oh2/6oxYfE9agPCXifjM0lseOn7Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-Puy2MaMYN--jYztsqXzVjQ-1; Thu, 23 Apr 2020 08:53:02 -0400
X-MC-Unique: Puy2MaMYN--jYztsqXzVjQ-1
Received: by mail-wr1-f72.google.com with SMTP id t8so2774277wrq.22
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2020 05:53:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZPkD1f9HCLQl3Nbow3n/TFkyFzTr2cVrM+60wurLKRE=;
 b=Hp1nC5FHP1MIshTCx2wleyFLzpkmYZ1af7oci+xQ/DaKnCBHSt7sVrNgcli6WHjU4M
 lBKAdhuFRbvL5j4KCKnNByEvi19p+SmX4m+/h1kHD2SURroZySNieW1DQVjny5CHqbCp
 lG2su+OfJ7WbLqYAZ019rMSyu78sUS4h7ap6ihSNlVfa/Pm9+CcwcN/xmWVbMdO6fvTW
 sCizXI1fNU3tUR9b2jjJcLltXE7oRp7fyFSd1B3Nft1PNLBc650wgqT8ZJLFft65Z8iO
 qJr7JwjkxhlQNNpfgUnFRLDwIvDPc2/urb/KmHPTpA7apoynz9+ampbVax6JxvrTfmNi
 kxiQ==
X-Gm-Message-State: AGi0Pub5xOJnEmQexLqC2iN3ie7kwxeAJeFg7vJatRHFqvBkz5q1Bb1f
 P8dpczB+IK/bPOvwOPY2QQBfi/gHPJ1iOlbxrD90et3U+JpubiDnggRqA/u+ko69/K6SviQsnOY
 iyWO2hrxc6TjSyg4=
X-Received: by 2002:adf:fa41:: with SMTP id y1mr4714807wrr.131.1587646381445; 
 Thu, 23 Apr 2020 05:53:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypJaTIyTFTmC/x59Z5Pno7OLCuXUHLseRbH/kX1K6znMywEMqbXbLGm6IpMieIKX8sA6qB0vMQ==
X-Received: by 2002:adf:fa41:: with SMTP id y1mr4714786wrr.131.1587646381152; 
 Thu, 23 Apr 2020 05:53:01 -0700 (PDT)
Received: from redhat.com (bzq-109-65-97-189.red.bezeqint.net. [109.65.97.189])
 by smtp.gmail.com with ESMTPSA id m188sm3732441wme.47.2020.04.23.05.53.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2020 05:53:00 -0700 (PDT)
Date: Thu, 23 Apr 2020 08:52:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
Subject: Re: [PATCH v2 1/2] virtio-vga: fix virtio-vga bar ordering
Message-ID: <20200423085202-mutt-send-email-mst@kernel.org>
References: <20200422215455.10244-1-anthoine.bourgeois@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200422215455.10244-1-anthoine.bourgeois@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 05:42:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 22, 2020 at 11:54:54PM +0200, Anthoine Bourgeois wrote:
> With virtio-vga, pci bar are reordered. Bar #2 is used for compatibility
> with stdvga. By default, bar #2 is used by virtio modern io bar.
> This bar is the last one introduce in the virtio pci bar layout and it's
> crushed by the virtio-vga reordering. So virtio-vga and
> modern-pio-notify are incompatible because virtio-vga failed to
> initialize with this option.
>=20
> This fix sets the modern io bar to the bar #5 to avoid conflict.
>=20
> Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>

Gerd, would you say it's required for 5.0?

> ---
>  hw/display/virtio-vga.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/display/virtio-vga.c b/hw/display/virtio-vga.c
> index 2b4c2aa126..95757a6619 100644
> --- a/hw/display/virtio-vga.c
> +++ b/hw/display/virtio-vga.c
> @@ -114,6 +114,7 @@ static void virtio_vga_base_realize(VirtIOPCIProxy *v=
pci_dev, Error **errp)
>       */
>      vpci_dev->modern_mem_bar_idx =3D 2;
>      vpci_dev->msix_bar_idx =3D 4;
> +    vpci_dev->modern_io_bar_idx =3D 5;
> =20
>      if (!(vpci_dev->flags & VIRTIO_PCI_FLAG_PAGE_PER_VQ)) {
>          /*
> --=20
> 2.20.1


