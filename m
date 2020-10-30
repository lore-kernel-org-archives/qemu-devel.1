Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A2FC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28823206F7
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gvmhXteQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28823206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYV4b-0000L8-PU
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:08:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kYV0g-0006HO-6I
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:04:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45904)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kYV0U-00068A-BJ
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:04:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604066633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+DWrWQeUTGCs6mcbq3lWKQHOnc4S05aAIx37995cxv4=;
 b=gvmhXteQxDgM//iLFHR60hslgMDryhRL/gpvSJJpyWsiACP3136PKU+b3FYB3i9sxOU1H7
 QOqugPvNk4WIuDPUuv/QraCzqr/e68LuFW3JNPKWZUZt5E2+OBzPIxnFkM7xUrQYQWwozb
 8L8fM60fx5Fc/xNhkZiBnaDO2NdDs0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-AQTnpW2EOAKIaAJaekk41A-1; Fri, 30 Oct 2020 10:03:51 -0400
X-MC-Unique: AQTnpW2EOAKIaAJaekk41A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C52C01005A9;
 Fri, 30 Oct 2020 14:03:45 +0000 (UTC)
Received: from localhost (ovpn-113-41.ams2.redhat.com [10.36.113.41])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17DD019C71;
 Fri, 30 Oct 2020 14:03:40 +0000 (UTC)
Date: Fri, 30 Oct 2020 14:03:40 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.2 v2 12/25] block/nvme: Introduce Completion Queue
 definitions
Message-ID: <20201030140340.GD330921@stefanha-x1.localdomain>
References: <20201029093306.1063879-1-philmd@redhat.com>
 <20201029093306.1063879-13-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201029093306.1063879-13-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Hf61M2y+wYpnELGG"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Eric Auger <eric.auger@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Hf61M2y+wYpnELGG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2020 at 10:32:53AM +0100, Philippe Mathieu-Daud=E9 wrote:
> Rename Submission Queue flags with 'Sq' to differentiate
> submission queue flags from command queue flags, and introduce
> Completion Queue flag definitions.
>=20
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  include/block/nvme.h | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

I mentioned more possible cleanups in the previous revision, but they
are not a blocker:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Hf61M2y+wYpnELGG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+cHTwACgkQnKSrs4Gr
c8gZ+AgAjsqk0Q865rKWD4kXoEwXMYZlX7QbH8U0mAwXMXtVMFGlxXhAPo4BSApO
hWAi2pVzTTKEqlA4VRAQLPdj+gpic7jpvKE90N3PJmeqwFE7fJsMObwKua0alNug
doIfG4eBORrDrdr+hD31Wua27Iddc9U1kTJyY1hS3fju5FqktuUHwE+3quAjCsbw
dEM6ciAmy5Pxw4ho7j1xGDqAjpluSL7HNnkUVrU41spD2P3GVLnVZm6z4o0bWka+
BforO0284aiIBWhrfk0c4o2c78LKYrk10bYl31ULNIKiG+MgEBPmSGxkRKgmJodk
yZmnwnZ4qnJ4vim8cCkGFeb6jK6KJw==
=fSeJ
-----END PGP SIGNATURE-----

--Hf61M2y+wYpnELGG--


