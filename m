Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B567DC55179
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:21:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10163247BD
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cb9OmHDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10163247BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXnG1-0003L3-UL
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXnBw-0000N4-AG
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:16:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36312)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXnBu-0006Ah-IC
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603898205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=upKLzD+0+gUwH7FeM0cC5thMgXHjfHCysCUPXcW6gP8=;
 b=cb9OmHDYMkACQKHlRmLo2zDq+9iI0i2Z9/Vo/JfphYoMYzAD3pCiC0I+XGvHlbtfub93FU
 kqxuSdylo7R7WAoeH1c8JRcHRLLEGA38x2RyZbARmYlna5RTx9guAJVh+nxPtBSSpk0DkX
 Dkmg2dppmUVAqoX2r3GOArHVK+HcVUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-HjBDVkQBMnujBV-m2Za4jg-1; Wed, 28 Oct 2020 11:16:40 -0400
X-MC-Unique: HjBDVkQBMnujBV-m2Za4jg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87FBC80365F;
 Wed, 28 Oct 2020 15:16:38 +0000 (UTC)
Received: from localhost (ovpn-114-6.ams2.redhat.com [10.36.114.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EBC25C1D7;
 Wed, 28 Oct 2020 15:16:34 +0000 (UTC)
Date: Wed, 28 Oct 2020 15:16:33 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 13/25] block/nvme: Introduce Completion Queue definitions
Message-ID: <20201028151633.GH231368@stefanha-x1.localdomain>
References: <20201027135547.374946-1-philmd@redhat.com>
 <20201027135547.374946-14-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201027135547.374946-14-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ik0NlRzMGhMnxrMX"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--ik0NlRzMGhMnxrMX
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

There is also:

  #define NVME_SQ_FLAGS_PC(sq_flags)      (sq_flags & 0x1)
  #define NVME_SQ_FLAGS_QPRIO(sq_flags)   ((sq_flags >> 1) & 0x3)

These macros should use the new constants.

I didn't check if there are additional magic numbers in hw/block/nvme.c
that should be converted.

Stefan

--ik0NlRzMGhMnxrMX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+Zi1EACgkQnKSrs4Gr
c8iqIQf9E1/BKTRpVc1VP2CGiQzLlJauc56imKv4hG2L5JYWZ+3dM6oyHhZ/AbCI
qh0158wyelBHPLEjY37kLwSvkFX8SRlFPcci/1GEx2GUmiADac4yLgFzUDfvnTZy
GWSFhc3ZTQc7y1uU2EfxbC7EnTSI5KPF5Jy2EdGn1jP1feuSJZreHmvyY108md1T
AcOhSUyGQaVQ1rqUOHbe0R8iqNN+qCKf6xgeekG09wUg9oyI1tPLI0qSVAp9syZP
DUfNZs38PUAkEdHwV13w/+bLpuae93El0vEDEtOaDiqhQ0mLFFf/cetafvjCsRZN
zvCwPjh2lOBGJYo8CkyQYAqrdUlGkA==
=1ZqZ
-----END PGP SIGNATURE-----

--ik0NlRzMGhMnxrMX--


