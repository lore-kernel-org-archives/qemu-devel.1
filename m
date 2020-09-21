Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3733BC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:45:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 784D9207BC
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 08:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9pxOxJf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784D9207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKHRk-0008RX-KF
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 04:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56338)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKHOM-0004CA-Ur
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:41:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kKHOK-0003wy-BX
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600677703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AHtbKFsPjrczbiCnPLqsIFgvPmOlYaKvh+314t+WBpQ=;
 b=G9pxOxJfE91kewi131vVGnmsqTvpj7NBz+1ylXCAe5zVFBrnPVM+gcrsOkGWc85JJT2Dis
 cT+x/DfVVJQWrx84VhW2gCLb5rU5pXsdcvVjdxu2WNDrIevG8nyZn7cLX+XrqYLoy0VnUc
 Yo2H2q+jZMMmM0j67xv1EVs9A1QigiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-XidPdK7ZOPavNRE1DSU3Rw-1; Mon, 21 Sep 2020 04:41:41 -0400
X-MC-Unique: XidPdK7ZOPavNRE1DSU3Rw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB1B21005504
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 08:41:40 +0000 (UTC)
Received: from localhost (ovpn-114-170.ams2.redhat.com [10.36.114.170])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83F0A6886A;
 Mon, 21 Sep 2020 08:41:37 +0000 (UTC)
Date: Mon, 21 Sep 2020 09:41:36 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 0/2] vhost-vdpa: add trace functions in vhost-vdpa.c
Message-ID: <20200921084136.GB71121@stefanha-x1.localdomain>
References: <20200920162434.868041-1-lvivier@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200920162434.868041-1-lvivier@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LpQ9ahxlCli8rRTG"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--LpQ9ahxlCli8rRTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2020 at 06:24:32PM +0200, Laurent Vivier wrote:
> Add trace events functions in vdpa functions.
>=20
> Modify qemu_hexdump() to be able to dump the vdpa config
> in trace logs in hexadecimal form.
>=20
> Laurent Vivier (2):
>   util/hexdump: introduce qemu_hexdump_line()
>   vhost-vdpa: add trace-events
>=20
>  hw/virtio/trace-events | 29 ++++++++++++++
>  hw/virtio/vhost-vdpa.c | 85 +++++++++++++++++++++++++++++++++++++++---
>  include/qemu-common.h  |  8 ++++
>  util/hexdump.c         | 54 +++++++++++++++++----------
>  4 files changed, 151 insertions(+), 25 deletions(-)

Please take this through the VIRTIO/vhost/vDPA tree:

Acked-by: Stefan Hajnoczi <stefanha@redhat.com>

--LpQ9ahxlCli8rRTG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9oZ0AACgkQnKSrs4Gr
c8hCiAf+IrJdPyV83AnyDNdprHZStFs2qjxrwnoqjfDTROi7mW27fuQcuhjaOX53
reLW4EB6SxHljYw3KdTJzyNvO3sxpU0kxH5VDl+AAu5fZUJN0GxTzw8jH8evPePv
4GH8DIvXc5mL6icOOuHRrh9T7XGghV1xxCCxPtjuL0HNI70JP74tJ2Zf0V5qmWZI
9dCe6643DlZef+hXZTbTqVQEfudGiB8fifMq+7uXTDWZwL07J/h4RjH4WxTN/YpW
AjrU4iJYVZjp3/PB4Te6jH3WN72MdgRojitHx5CK26vAKH+rwgjkJRv/9NGNTjrF
3yaTUQvndrOkTdqQHKX3u9GCveMpnw==
=Uq3E
-----END PGP SIGNATURE-----

--LpQ9ahxlCli8rRTG--


