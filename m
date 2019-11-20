Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE3CC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:42:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AC5822429
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 10:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gHb8kJJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AC5822429
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNR9-0008Q2-Jy
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 05:42:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58516)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iXNPa-0006Vl-S4
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:40:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iXNPZ-0007Vo-Qw
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:40:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45320
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iXNPZ-0007QO-Mp
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 05:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574246435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/IVqEgwwbm9WW9myZqUoBQ1tELAES93r+57W4TfGMxY=;
 b=gHb8kJJ42WdjH0iQqN1HIjfMbkfx/A9Q2TBgFLlcjXbd3lirM96LokvSOFIxRGisVL7v0X
 kogNe18ZKs5H2I0ZsVT1/zuPqyjS+y6esq/i1qluGG6Sy1WAVusI5iKZ93uQWZOOH8ah/4
 /WeBkMUroakQn5hUh3orZ1/CXnudD7U=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-Sfp8I_INO1W1HkLNZrRt_w-1; Wed, 20 Nov 2019 05:40:33 -0500
Received: by mail-qv1-f69.google.com with SMTP id a4so16837891qvz.20
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 02:40:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zV2eu2IL5FnT0YjOsKyWME9RLWSkkm1210R1jzRO+/0=;
 b=if6ZpMQhOb/txnKjPD+zJKUbmY5BaqflMJlq+l3ukHeNiEVJd1LattWJ1pQDdjA7MK
 /GU1sMRjLNNMEiFkIr3xBlNAsu/IHl6PDoBFZuhJmKsr1E5xe1+7pSO5Z01C5vy4Nw/e
 RinbsyeTNG3TgM7iZWEYHoJzKeGZEoTlRUMcohvwm4e5FZAdCZ1yPIpWF0IYNn77B+lp
 oqXcAavdL/ALTtzCWv324LgWat1XPy8VTBizBuv+E1OVfxZF/17QEEO9imFKjs6jwN9Q
 Ry5/cnhIE+LkaSACocplHipTG5YILNw8vHOsgX9m0GJID6Xei27yt9HbXBuBL+vRu1og
 Bu2g==
X-Gm-Message-State: APjAAAWed3/YCmJ8Zqm+zoasDcsxcgOXBhBGjUhfgP1jw08K5stRUjFb
 kzpmRnJ2vrbh192kGt0Alr1Eh9UKNwuluwLy7RvTgpP7dcyxNOhZzYmuPhba2F0+rtjwHo8icGV
 QmrrTxVVNEF34858=
X-Received: by 2002:ae9:ef50:: with SMTP id d77mr1711783qkg.430.1574246433137; 
 Wed, 20 Nov 2019 02:40:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqxCUx77ika9Bj52tcwutXAO3zIvfIb7y3xOA9kXHEm/npx27GcvkzCXzCPbaKGsisWDcLm8qQ==
X-Received: by 2002:ae9:ef50:: with SMTP id d77mr1711775qkg.430.1574246432924; 
 Wed, 20 Nov 2019 02:40:32 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id g16sm11385078qkm.59.2019.11.20.02.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 02:40:32 -0800 (PST)
Date: Wed, 20 Nov 2019 05:40:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Subject: Re: [PATCH 2/4] net/virtio: return early when failover primary
 alread added
Message-ID: <20191120053930-mutt-send-email-mst@kernel.org>
References: <20191114141613.15804-1-jfreimann@redhat.com>
 <20191114141613.15804-2-jfreimann@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191114141613.15804-2-jfreimann@redhat.com>
X-MC-Unique: Sfp8I_INO1W1HkLNZrRt_w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: peter.maydell@linaro.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 14, 2019 at 03:16:11PM +0100, Jens Freimann wrote:
> Bail out when primary device was already added before.
> This avoids printing a wrong warning message during reboot.
>=20
> Fixes: 9711cd0dfc3f ("net/virtio: add failover support")
> Signed-off-by: Jens Freimann <jfreimann@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/net/virtio-net.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 946039c0dc..ac4d19109e 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -759,6 +759,10 @@ static void failover_add_primary(VirtIONet *n, Error=
 **errp)
>  {
>      Error *err =3D NULL;
> =20
> +    if (n->primary_dev) {
> +        return;
> +    }
> +
>      n->primary_device_opts =3D qemu_opts_find(qemu_find_opts("device"),
>              n->primary_device_id);
>      if (n->primary_device_opts) {
> --=20
> 2.21.0


