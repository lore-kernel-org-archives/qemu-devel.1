Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDDDC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:01:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 932402077D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tc/mTdH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932402077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeeds-0004ks-Cr
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:01:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jeecY-0003ph-Ad
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:00:23 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46046
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jeecV-0000K6-EJ
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590757217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VzL67TkNMMFyFj64fc4jnl9Nk70EwY6EbAtyobGH6JU=;
 b=Tc/mTdH8w25P0ImWQQS4PhImhRuraHJUw8VhqU0tm97/svuB/bDf38d5VQKMlCODQOME1Q
 rz2olEqjGatNWipJ0ezMALpaLgMFasbACEbiKCedoitNH9dUpXREc15hp8Use3z4WvOU+M
 +eHnnmk5rQtTiiF30Y6UVv/w/KWyIiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-RLoTctnLMP6EYQdsQEpvhQ-1; Fri, 29 May 2020 09:00:13 -0400
X-MC-Unique: RLoTctnLMP6EYQdsQEpvhQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9C8B18A822F
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:00:12 +0000 (UTC)
Received: from localhost (ovpn-114-38.ams2.redhat.com [10.36.114.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8029BA103F;
 Fri, 29 May 2020 13:00:07 +0000 (UTC)
Date: Fri, 29 May 2020 14:00:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] virtio-pci: fix queue_enable write
Message-ID: <20200529130006.GA367530@stefanha-x1.localdomain>
References: <20200529030728.7687-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200529030728.7687-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 01:27:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2020 at 11:07:28AM +0800, Jason Wang wrote:
> Spec said: The driver uses this to selectively prevent the device from
> executing requests from this virtqueue. 1 - enabled; 0 - disabled.
>=20
> Though write 0 to queue_enable is forbidden by the sepc, we should not
> assume that the value is 1.
>=20
> Fix this by ignoring the write value other than 1.
>=20
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  hw/virtio/virtio-pci.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7RB1YACgkQnKSrs4Gr
c8gOEwf+OPbDIWhvZ3ViB81vj2s2CyX9rY1qqCfyd/bj19XJcFYpFzD/ITvntArU
b8x9Wl9huYY9upl81hAYu6/dt2+pw11XwwLzDo0YG8Ntp7dSjAxEjDSQS+lgVRKF
nPIqPRd5F2obxDK+Kdxe0Wghus8BmcS63OgReLykI+9mOsTskv+TC+V/jA80s5AK
FdFZwWjAG1UhKJDTXD4CqL8jDrIV0XMxbk5+/6YFWxwgQQ+QowAr02erAgDY4d69
cwqNw/nJb1/3rbrXfgx1WBeDVjCv5SF384Z2ct8l3NzNlUG6op12tsoUUfFPsyGa
JJRvO0zrNhRmbqUfDwgPxLf0oXulsw==
=UvWN
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--


