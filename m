Return-Path: <SRS0=nsQZ=2M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BAF9C2D0C0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 13:03:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C31206CB
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2019 13:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D+l482XG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C31206CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47629 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ij0tm-00066o-0n
	for qemu-devel@archiver.kernel.org; Sun, 22 Dec 2019 08:03:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ij0sr-0005Yo-9U
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 08:02:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ij0sn-00067Z-0c
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 08:02:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58561
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ij0sk-00065T-St
 for qemu-devel@nongnu.org; Sun, 22 Dec 2019 08:02:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577019769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EF+cOW1aj50YsyXYYtuJvPS3mzBxL+FrYzYr7AmWXPI=;
 b=D+l482XGaUlZXeGzat1+0DJ8DDoJrgtc6abv+c5dvRk6EUUYUS+i2WbB6R81NBT0iRp/TS
 ba80z7Jv3UMTPq5RUwlqnt9ywmbNimEt1koLPGS77Gq3YjXlAAtus2qfD6pPosAVIFifgg
 OBnYn1GVRt5rITCgwq+eePb88/E5MNE=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-jR9Zh94ZMLK0_vnHh2Qyzw-1; Sun, 22 Dec 2019 08:02:47 -0500
Received: by mail-qt1-f198.google.com with SMTP id k27so9367472qtu.12
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2019 05:02:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iUMpv90PlaAzMPnNvwWcKkD23S9vzhuQNx+pI7uOLio=;
 b=bHPtn5G8Ce8pyqZ0eUvSZIrtPpvO26MFlXbpIfcaDvFbgHaGf8i5aHA6QSL+vyPXDY
 RlzZkRPU2hyBadr4FHjLrbESWatsPUEzepciXvfknQ6n/2wjghn5wSrVTgxdoz2M7S3X
 OAKJPUW//exK+tcT/MtRfffIpYGj8TwFzYyFMDwgrT2fpoW/wQBhHRoiAl8qi4+RYZl9
 W/rGWrH6w7Qisy8cc+HfH7CVSWtHFnyHnoU2Ne0mvhF/Q/oQbXfAhg6yF0jMa1DwDbK7
 xP5W7oukK+qTIfiUXR35+m/ltHVm/ijKxqpAfn1OyUsoWMyUXeHQiJYOvWZDxOcBfFIL
 mHuw==
X-Gm-Message-State: APjAAAWInLTZdMV5XXmBfAOXpzKy4mLghiU16voOEvPaFR8k8ldkzSiJ
 MNrJoqaIZ4H3PQ0HJKRPnZK1S1DRM2w+j+0BEelsdNvquW7Ym1n2L7cCzi5b7z+pIxwardT513j
 SAvKva8DaIIJnNS8=
X-Received: by 2002:ae9:c205:: with SMTP id j5mr20680933qkg.58.1577019767320; 
 Sun, 22 Dec 2019 05:02:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqzdFGjsctw3UskRmkfEulBQoeui/U96h6HA1SQNpIKQ+1m1grddfPxX3FLm6Yic8WyP8DCLSA==
X-Received: by 2002:ae9:c205:: with SMTP id j5mr20680914qkg.58.1577019767091; 
 Sun, 22 Dec 2019 05:02:47 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id j185sm4779167qkc.96.2019.12.22.05.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2019 05:02:45 -0800 (PST)
Date: Sun, 22 Dec 2019 08:02:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL 00/24] virtio, pci, pc: fixes, features
Message-ID: <20191222080202-mutt-send-email-mst@kernel.org>
References: <20191219132621.16595-1-mst@redhat.com>
 <CAFEAcA9HVKxVi4vg7F4ELRpjgk=vFtREXRfJySGy5mdjsJuj9A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9HVKxVi4vg7F4ELRpjgk=vFtREXRfJySGy5mdjsJuj9A@mail.gmail.com>
X-MC-Unique: jR9Zh94ZMLK0_vnHh2Qyzw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Dec 20, 2019 at 06:24:43PM +0000, Peter Maydell wrote:
> On Thu, 19 Dec 2019 at 13:27, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following changes since commit b0ca999a43a22b38158a222233d3f5881648=
bb4f:
> >
> >   Update version for v4.2.0 release (2019-12-12 16:45:57 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to d4fbea918a37c0586f1a0e15ac6ef04c9fc7b96b=
:
> >
> >   vhost-user-scsi: reset the device if supported (2019-12-19 08:25:35 -=
0500)
> >
> > ----------------------------------------------------------------
> > virtio, pci, pc: fixes, features
> >
> > Bugfixes all over the place.
> > HMAT support.
> > New flags for vhost-user-blk utility.
> >
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
>=20
> Compile failure on OSX:
> /Users/pm215/src/qemu-for-merges/hw/core/numa.c:427:20: error: format
> specifies type 'unsigned char' but the argument has type 'int'
> [-Werror,-Wformat]
>                    node->level - 1);
> ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
> /Users/pm215/src/qemu-for-merges/include/qapi/error.h:166:35: note:
> expanded from macro 'error_setg'
>                         (fmt), ## __VA_ARGS__)
>                                   ^~~~~~~~~~~
> /Users/pm215/src/qemu-for-merges/hw/core/numa.c:440:20: error: format
> specifies type 'unsigned char' but the argument has type 'int'
> [-Werror,-Wformat]
>                    node->level + 1);
> ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
> /Users/pm215/src/qemu-for-merges/include/qapi/error.h:166:35: note:
> expanded from macro 'error_setg'
>                         (fmt), ## __VA_ARGS__)
>                                   ^~~~~~~~~~~
> 2 errors generated.
>=20
> thanks
> -- PMM


I think I fixed this up, can you try again with
new for_upstream at cd8b62554728373e3dcdbc450a3d76a9ce4e7beb please?


