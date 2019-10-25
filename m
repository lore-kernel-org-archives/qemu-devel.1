Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F9FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F5582070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5582070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNxtW-0000d0-MR
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iNxs8-0005LU-4x
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iNxs7-0004RO-4m
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:35:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38904 helo=mx1.redhat.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iNxs6-0004RC-Vr
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:35:11 -0400
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A0631414DEEC
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 11:35:10 +0000 (UTC)
Received: by mail-qk1-f199.google.com with SMTP id v143so1796832qka.21
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 04:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=gquKGJ7sbyRgClU5gNYl2zs8V2N4mRiFMe/U4uutH9w=;
 b=lWTIJr03mBC2phrk1MDYQvfw9W3TMS1hYhU9JD5epzNiFHI+LU8WB0U8U2V8uFjfZZ
 pqKiSkAM53SgCjCkXAQb7t5DB+hsjNImyAx1or5RyGc6o9okUQ5qLe35fs4t8YoPtTLV
 jtKzwJ2FyXVU0iuh23wuw2vhqlmRZMfGHJwsBTqdep/QrtvLZwznvJwHnzZXhqAasb/D
 jr6+94kl9JE2MbHjkFd6biTXZjrxA9RTqIGQqy76IOSuSampvvcjgrQJO1vwkfSG1Mqi
 dIg4FKj9INCjmNuBlGQ+joevrQOM0e/a6X8DFknS7JXmRrIMDQ6tEgl0yixPuI9fe/tx
 2ggg==
X-Gm-Message-State: APjAAAUyWJY62/8WIYFNEo4O0y5r+ASuUKbrMjTqpJLh88qlgKo9/STT
 E8v3jwGSvgtEehEl0bvV9fNNB6JKJI5n7n7xnxq8VY74monwHC7Xrb2f51OW5ifmgvC8o4hNMzH
 OZRq69lTBFUeZfZY=
X-Received: by 2002:ac8:3168:: with SMTP id h37mr2483827qtb.311.1572003250268; 
 Fri, 25 Oct 2019 04:34:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqznwABcxa2Cl+2n098sDnEbZ6mD2JC7hcU08YTBEp29sWMAtnu33rl0/rSaCRYO54wDeOi+7g==
X-Received: by 2002:ac8:3168:: with SMTP id h37mr2483796qtb.311.1572003250011; 
 Fri, 25 Oct 2019 04:34:10 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 c21sm1117710qtg.61.2019.10.25.04.34.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2019 04:34:09 -0700 (PDT)
Date: Fri, 25 Oct 2019 07:34:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>
Subject: Re: [PATCH v7 0/8] Packed virtqueue for virtio
Message-ID: <20191025073257-mutt-send-email-mst@kernel.org>
References: <20191025083527.30803-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191025083527.30803-1-eperezma@redhat.com>
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 66.187.233.73
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-block@nongnu.org, Amit Shah <amit@kernel.org>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Jens Freimann <jfreimann@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 25, 2019 at 10:35:19AM +0200, Eugenio P=E9rez wrote:
> Hi:
>=20
> This is an updated version of packed virtqueue support based on Wei and=
 Jason's
> V6, mainly solving the clang leak detector error CI gave.


Looks good, I will queue this up.

It would be nice to add libqos based tests on top,
based on Stefan's work.


> Please review.
>=20
> Changes from V6:
> - Commit reorder: Squash bugfix and sepparate big changes into smaller =
commits.
>=20
> Changes from V5:
> - Fix qemu's CI asan error.
> - Move/copy rcu comments.
> - Merge duplicated vdev->broken check between split and packet version.
>=20
> Eugenio P=E9rez (2):
>   virtio: Free blk virqueues at unrealize()
>   virtio: Free rnd virqueue at unrealize()
>=20
> Jason Wang (4):
>   virtio: basic packed virtqueue support
>   virtio: event suppression support for packed ring
>   vhost_net: enable packed ring support
>   virtio: add property to enable packed virtqueue
>=20
> Wei Xu (2):
>   virtio: basic structure for packed ring
>   virtio: device/driver area size calculation refactor for split ring
>=20
>  hw/block/virtio-blk.c       |    7 +-
>  hw/char/virtio-serial-bus.c |    2 +-
>  hw/net/vhost_net.c          |    2 +
>  hw/scsi/virtio-scsi.c       |    3 +-
>  hw/virtio/virtio-rng.c      |    1 +
>  hw/virtio/virtio.c          | 1154 +++++++++++++++++++++++++++++++++++=
+++-----
>  include/hw/virtio/virtio.h  |   14 +-
>  7 files changed, 1045 insertions(+), 138 deletions(-)
>=20
> --=20
> 2.16.5

