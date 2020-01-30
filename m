Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155A7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:59:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D30BD2051A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 14:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jS6/DiY1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D30BD2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixBIE-0005xM-2q
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 09:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ixBHW-0005JF-67
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:58:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ixBHU-0004Uz-VJ
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:58:58 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29027
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ixBHU-0004Ug-R2
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 09:58:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580396336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mMrncPKYJjEF+ysiZnqEvv0QLKUhyIsU36C4jrTRlic=;
 b=jS6/DiY1TfzSsEDYJiMp44pMbJ2exl94WWD9LxVatK16xukgDw5J418CHB7JfVs2kCvR22
 LH/blcqdGEmyukyBUKL70p6PDWQw3R2s1CAIkCIdeDgdGr9wLboE0koGGELfqAJwwQgsBu
 xIiWZfSKs9JC+2xYzuzswvXJt2u3gUk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-tY8kBWQpPGqejHMtuyRH2Q-1; Thu, 30 Jan 2020 09:58:46 -0500
X-MC-Unique: tY8kBWQpPGqejHMtuyRH2Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A439CDB60;
 Thu, 30 Jan 2020 14:58:44 +0000 (UTC)
Received: from localhost (unknown [10.36.118.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB81C100194E;
 Thu, 30 Jan 2020 14:58:41 +0000 (UTC)
Date: Thu, 30 Jan 2020 14:58:40 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Denis Plotnikov <dplotnikov@virtuozzo.com>
Subject: Re: [PATCH v1 2/4] virtio: increase virtuqueue size for virtio-scsi
 and virtio-blk
Message-ID: <20200130145840.GH180311@stefanha-x1.localdomain>
References: <20200129140702.5411-1-dplotnikov@virtuozzo.com>
 <20200129140702.5411-3-dplotnikov@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <20200129140702.5411-3-dplotnikov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MGu/vTNewDGZ7tmp"
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, mst@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com,
 den@virtuozzo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--MGu/vTNewDGZ7tmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2020 at 05:07:00PM +0300, Denis Plotnikov wrote:
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
> of data to be read/write from guest disk.
>=20
> More details in the original problem statment:
> https://lists.gnu.org/archive/html/qemu-devel/2017-12/msg03721.html
>=20
> Suggested-by: Denis V. Lunev <den@openvz.org>
> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
> ---
>  hw/core/machine.c          | 3 +++
>  include/hw/virtio/virtio.h | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 3e288bfceb..8bc401d8b7 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -28,6 +28,9 @@
>  #include "hw/mem/nvdimm.h"
> =20
>  GlobalProperty hw_compat_4_2[] =3D {
> +    { "virtio-blk-device", "queue-size", "128"},
> +    { "virtio-scsi-device", "virtqueue_size", "128"},
> +    { "vhost-blk-device", "virtqueue_size", "128"},

vhost-blk-device?!  Who has this?  It's not in qemu.git so please omit
this line. ;-)

On the other hand, do you want to do this for the vhost-user-blk,
vhost-user-scsi, and vhost-scsi devices that exist in qemu.git?  Those
devices would benefit from better performance too.

--MGu/vTNewDGZ7tmp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4y7yAACgkQnKSrs4Gr
c8j3yQf/fLGA6WL61DUwvEFDPvkiK2PNNcRnC5FvlEoenP8Dk8Q8Ol3aeQLlpJ4C
14jyZU10YvWn6WeMtPYTyC3wbv++w7J9irpJsimJHPfcl7zOqxSV4D6lvN1l0gAu
SiS0YotiJwrN5aUNWJsXfJcmUtZKD/LgmLcK2SqD5mi5Q1mHgeUT5vxVCKXxizIH
BvNd1bdTpOhQNF5Y1nw3MhQJNdFJAnVOhQxghHZrGcKARSFX6QtHqNjcVhZQklF4
sBAd3sVSZoYJZjs8letLPVUG4ftR8h4EbCMoHcSIgf4TZBXolZ7yA/ktCfZlO/1E
DOPAveWr/Ji58v2bG2xyA2LaOSMEhQ==
=9G86
-----END PGP SIGNATURE-----

--MGu/vTNewDGZ7tmp--


