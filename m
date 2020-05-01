Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C6EC47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:49:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C21D420836
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 16:49:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BDHi+bBx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C21D420836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUYrA-0000zW-V8
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 12:49:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jUYmE-0005CU-PK
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jUYjg-00043C-Pc
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:44:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21257
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jUYjg-00041j-9r
 for qemu-devel@nongnu.org; Fri, 01 May 2020 12:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588351319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tw9gETxpQCO7cg7IFwyuLQgVs5W7Mze+KnxmngxYUhc=;
 b=BDHi+bBx9EigUIIfVGvKHtsA5CxGjI8ZZejrD/cDbfWJbdxygBx3XueNK0wNqpxkeGf947
 MMGltEVlf2OV+vQkfFYeJUOkeQ6nBgOUK10UiotUJphnYDsgiBmKENoKUVFktOdeIUHTHe
 z3498oirwC7PLziecdUHq0nZiwoQYlU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-Hvp0vDYaOdu4623iDYqyKw-1; Fri, 01 May 2020 12:41:57 -0400
X-MC-Unique: Hvp0vDYaOdu4623iDYqyKw-1
Received: by mail-wr1-f72.google.com with SMTP id r17so5919221wrg.19
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 09:41:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=31AcpZQ32zwVfyympz1e8gVxPB0NAJRlGnnPkL0a+Dk=;
 b=KWlkkchDpi0F+eGIs192/LVjH9OlHpSVRc7X6t3oyaNwG7pKF0OqbMEvnswxdxNn64
 OIJ79RN62S6RlZsVDUpkmSH8ZknGNN3grh+mkr1vYGYMtNNmM3B3iy2BgOAsq998r/6t
 p1z3aBKrfDV9A8LYbZqoo0RHLopoVqGMUng6IutFdQA78GJVAXkthY5eRwRAaR6BX698
 vzSNqqo3zd6SEFfp+J1X7q0lj4BurcJGNnrvH2TXGT+6tX29ukvloaQogzMr/h/QSiZI
 5W1mOgokEjBr7bdhjKCt+FHVENYO7nwZG/TnJP8D+Zf5536ZJt2wNMSLitpLydG1ucR7
 pPuw==
X-Gm-Message-State: AGi0Puaz2S5EIm68wIeHkLcCIwnnH45JPjm0v3/AHZiNogfDrFIxpZAQ
 o2ORK2N7v0a0X82JalWA6fjF7nEfh4ZS2vsS/uyj+RbEB2IwlZ5/qrfsMJLB/zyBQ4bK8U0AuTV
 Furfx5jxx9Eo9sCg=
X-Received: by 2002:a1c:5642:: with SMTP id k63mr368192wmb.188.1588351316538; 
 Fri, 01 May 2020 09:41:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ4nX40H+mD2JaW8pKXbWaJCJSUUYt6RWaTvL/K5YE4/ANK3hcmMoI9p+0EKm4cZ2HcU1/WDg==
X-Received: by 2002:a1c:5642:: with SMTP id k63mr368178wmb.188.1588351316354; 
 Fri, 01 May 2020 09:41:56 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
 by smtp.gmail.com with ESMTPSA id
 h16sm5789778wrw.36.2020.05.01.09.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 09:41:55 -0700 (PDT)
Date: Fri, 1 May 2020 12:41:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH v7 0/7] reference implementation of RSS and hash report
Message-ID: <20200501124038-mutt-send-email-mst@kernel.org>
References: <20200329150953.23812-1-yuri.benditovich@daynix.com>
MIME-Version: 1.0
In-Reply-To: <20200329150953.23812-1-yuri.benditovich@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 08:22:51
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
Cc: yan@daynix.com, jasowang@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 29, 2020 at 06:09:46PM +0300, Yuri Benditovich wrote:
> Support for VIRTIO_NET_F_RSS and VIRTIO_NET_F_HASH_REPORT
> features in QEMU for reference purpose.
> Implements Toeplitz hash calculation for incoming
> packets according to configuration provided by driver.
> Uses calculated hash for decision on receive virtqueue
> and/or reports the hash in the virtio header

Series:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

to be queued through Jason's tree.

> Changes from v6:
> Fixed a bug in patch 5 "reference implementation of hash report"
> that caused the ASAN test to fail
> was: n->rss_data.populate_hash =3D true;
> fixed: n->rss_data.populate_hash =3D !!hash_report;
>=20
> Yuri Benditovich (7):
>   virtio-net: introduce RSS and hash report features
>   virtio-net: implement RSS configuration command
>   virtio-net: implement RX RSS processing
>   tap: allow extended virtio header with hash info
>   virtio-net: reference implementation of hash report
>   vmstate.h: provide VMSTATE_VARRAY_UINT16_ALLOC macro
>   virtio-net: add migration support for RSS and hash report
>=20
>  hw/net/trace-events            |   3 +
>  hw/net/virtio-net.c            | 448 +++++++++++++++++++++++++++++++--
>  include/hw/virtio/virtio-net.h |  16 ++
>  include/migration/vmstate.h    |  10 +
>  net/tap.c                      |  11 +-
>  5 files changed, 460 insertions(+), 28 deletions(-)
>=20
> --=20
> 2.17.1


