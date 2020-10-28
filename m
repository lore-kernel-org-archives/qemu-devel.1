Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0D5C55178
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69CC1247B3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I6/Wgpqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69CC1247B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXn7d-0003ck-89
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXn6I-0001vn-RK
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:10:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXn6G-0005Ov-V8
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:10:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603897856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z7hOMq8opF5nS+ZM3tFJWy4H4q8IS+0Z33R/POzcOTU=;
 b=I6/Wgpqi7FxT+4HVQCV2tJcLFroV+GMWfnKyfYU1yDtviOu3xVZM4WfcEiOCaezgwpzr0M
 IeLhXcv3LfZjyoN4E7zx+QDA5Eeqnq5bcXlxOtPbsAvOsCB2ijILbW0+Tr2oWw0gmCd8tM
 NQsXrPuv/Nv7dGSJbY9imJdyewLTkDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-Z3tKFgZSPO61LlFiIDC7RQ-1; Wed, 28 Oct 2020 11:10:49 -0400
X-MC-Unique: Z3tKFgZSPO61LlFiIDC7RQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7F28100F961;
 Wed, 28 Oct 2020 15:10:43 +0000 (UTC)
Received: from localhost (ovpn-114-6.ams2.redhat.com [10.36.114.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E6B560BF1;
 Wed, 28 Oct 2020 15:10:43 +0000 (UTC)
Date: Wed, 28 Oct 2020 15:10:42 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 13/25] block/nvme: Introduce Completion Queue definitions
Message-ID: <20201028151042.GF231368@stefanha-x1.localdomain>
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-14-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201027135547.374946-14-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="gdTfX7fkYsEEjebm"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--gdTfX7fkYsEEjebm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2020 at 02:55:35PM +0100, Philippe Mathieu-Daud=E9 wrote:
> Rename Submission Queue flags with 'Sq' and introduce
> Completion Queue flag definitions.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  include/block/nvme.h | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/block/nvme.h b/include/block/nvme.h
> index 65e68a82c89..079f884a2d3 100644
> --- a/include/block/nvme.h
> +++ b/include/block/nvme.h
> @@ -491,6 +491,11 @@ typedef struct QEMU_PACKED NvmeCreateCq {
>  #define NVME_CQ_FLAGS_PC(cq_flags)  (cq_flags & 0x1)
>  #define NVME_CQ_FLAGS_IEN(cq_flags) ((cq_flags >> 1) & 0x1)
> =20
> +enum NvmeFlagsCq {
> +    NVME_CQ_PC          =3D 1,
> +    NVME_CQ_IEN         =3D 2,
> +};
> +
>  typedef struct QEMU_PACKED NvmeCreateSq {
>      uint8_t     opcode;
>      uint8_t     flags;
> @@ -508,12 +513,12 @@ typedef struct QEMU_PACKED NvmeCreateSq {
>  #define NVME_SQ_FLAGS_PC(sq_flags)      (sq_flags & 0x1)
>  #define NVME_SQ_FLAGS_QPRIO(sq_flags)   ((sq_flags >> 1) & 0x3)
> =20
> -enum NvmeQueueFlags {
> -    NVME_Q_PC           =3D 1,
> -    NVME_Q_PRIO_URGENT  =3D 0,
> -    NVME_Q_PRIO_HIGH    =3D 1,
> -    NVME_Q_PRIO_NORMAL  =3D 2,
> -    NVME_Q_PRIO_LOW     =3D 3,
> +enum NvmeFlagsSq {
> +    NVME_SQ_PC          =3D 1,
> +    NVME_SQ_PRIO_URGENT =3D 0,
> +    NVME_SQ_PRIO_HIGH   =3D 1,
> +    NVME_SQ_PRIO_NORMAL =3D 2,
> +    NVME_SQ_PRIO_LOW    =3D 3,
>  };

Why have these constants at all if nothing uses them? I would rather
remove dead code than spend time modifying it.

Stefan

--gdTfX7fkYsEEjebm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+ZifIACgkQnKSrs4Gr
c8iLEQgAyrFR3Db7S8d6BgSNuNcC2YPBkrL5JtiAo4oWWno63wx6/C08difl1Jn6
4nVLUTM6U+ZP3IVh06cG3ehCQCBWtLt+KzMQhD6ZDSHfsQ/Xjg7xbd958bQNmylU
XNJslDdN7MEz/KS497KvC+7JwaLSv7P9xwm0HSrNBYwE+7GpK8aHknXp5MjYaN0M
O5CF6f2oFcH8qxZS3pSczSuw1qBN+fEgc4CSxoYv3zg1FhVoh2Co+eMoAa3REMC0
/jeaZOG5oJk+CfAkSET+hgfWNw1tzOy7NFfU9YQYxFSItKNDwr9dGZS0+kQxpSal
sortsAttzEL7bYlHb4oi7ppTb26haw==
=oKNs
-----END PGP SIGNATURE-----

--gdTfX7fkYsEEjebm--


