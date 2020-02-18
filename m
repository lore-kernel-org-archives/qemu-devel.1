Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7B2C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:54:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC9920801
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MmZhMakx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC9920801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43Ko-0005vs-SR
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:54:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1j43K1-0004tU-1k
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1j43Jz-00046k-SQ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:53:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54424
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1j43Jz-00046Q-On
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:53:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582034035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HcwwVMALHqX12F3OOLAywv9X1pBGQd25XLEysTlPP1M=;
 b=MmZhMakxZhaRof/rLJXUdhUxnPlAY3O0h4Be0t+b6YO/Le0w7R034+BpF+P0AKPNsWvgMo
 JrwUjvOvJlIsy/rvbOdX7+NbHlJJ+zunCF890Un4v32kjqwIaBXpWnRKtOZJAUi5Xe3t+b
 Ik7aoOgCo/cWM9e8KW8/pSefKepYBR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-fXHvlKtdOz6ydhVDZi7bHQ-1; Tue, 18 Feb 2020 08:53:46 -0500
X-MC-Unique: fXHvlKtdOz6ydhVDZi7bHQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 387A48014DA;
 Tue, 18 Feb 2020 13:53:45 +0000 (UTC)
Received: from localhost (unknown [10.36.118.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1F3E78B550;
 Tue, 18 Feb 2020 13:53:41 +0000 (UTC)
Date: Tue, 18 Feb 2020 13:53:40 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v2] virtio: increase virtuqueue size for virtio-scsi and
 virtio-blk
Message-ID: <20200218135340.GG786556@stefanha-x1.localdomain>
References: <20200213145927.7539-1-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200213145927.7539-1-dplotnikov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qoTlaiD+Y2fIM3Ll"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: kwolf@redhat.com, fam@euphon.net, ehabkost@redhat.com,
 qemu-block@nongnu.org, mst@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--qoTlaiD+Y2fIM3Ll
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2020 at 05:59:27PM +0300, Denis Plotnikov wrote:
> v1:
>   * seg_max default value changing removed
>=20
> ---
> The goal is to reduce the amount of requests issued by a guest on
> 1M reads/writes. This rises the performance up to 4% on that kind of
> disk access pattern.
>=20
> The maximum chunk size to be used for the guest disk accessing is
> limited with seg_max parameter, which represents the max amount of
> pices in the scatter-geather list in one guest disk request.
>=20
> Since seg_max is virqueue_size dependent, increasing the virtqueue
> size increases seg_max, which, in turn, increases the maximum size
> of data to be read/write from a guest disk.
>=20
> More details in the original problem statment:
> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.html
>=20
> Suggested-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  hw/block/virtio-blk.c | 2 +-
>  hw/core/machine.c     | 2 ++
>  hw/scsi/virtio-scsi.c | 2 +-
>  3 files changed, 4 insertions(+), 2 deletions(-)

I fixed up the "virtuqueue" typo in the commit message and the
mis-formatted commit description (git-am(1) stops including lines after
the first "---").

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--qoTlaiD+Y2fIM3Ll
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5L7GQACgkQnKSrs4Gr
c8hwiQf/dYBumO42i/mscb3aoWr7wggZjlcfL+cWdQ9ert7P302Lc8BBowc2LO9n
ebAQHBgt9qYQ6k2PTqVGe0qi2P2mykDu/YknfXY9GkpJH9Ntl/8BPf9fS2LL7VpL
DULHZ9ceY4NAekf1+DnW1ReFklXp+78coaPuUhkDERzIq6OQeKJ+QJgPPAj4sJYR
3tIqA6lHaYTKLbdjPPV9GjcBPzTmiNYISHNlIyDnTa60a53HeoLnRSBONjptnJCD
5I283/OW/VagENmmGRSA/w0dcRpVr7BfjjajfeeJv4N+hWuNLkayM7/N5iOPGmtH
enDURvFPnreumzFBmXg9N5M1U/+iAg==
=w3fx
-----END PGP SIGNATURE-----

--qoTlaiD+Y2fIM3Ll--


