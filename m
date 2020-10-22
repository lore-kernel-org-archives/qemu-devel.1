Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B91C55179
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45C4024630
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POoWe1st"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45C4024630
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVbx5-0005Af-6m
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 10:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVbv7-0003HO-Qa
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:50:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVbv5-0006aI-DD
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603378220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Er3aHDaF/eapWlG4Y8tjEO7BliWH1+Ze3QGHD5Z4ifs=;
 b=POoWe1stxi1PZjQKPj6bHYaxDvrKI0Swlo+cZkIumpF/qefxV28KCvN3OJho0bGFCkoWJb
 JvMxDNiHYgqeMIzbXT4fp6sxR+SOY1Ay14UogGR2RFVBNav7/8E6BvRq2CEdjoUYC0cLQt
 FmEFuAMUAcuAFpS0Ss15O1TTZGkE3NE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-ZvPBYBt8OzO6ghH7PV-Jyw-1; Thu, 22 Oct 2020 10:50:17 -0400
X-MC-Unique: ZvPBYBt8OzO6ghH7PV-Jyw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45779801817;
 Thu, 22 Oct 2020 14:50:16 +0000 (UTC)
Received: from localhost (ovpn-114-229.ams2.redhat.com [10.36.114.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36C2373682;
 Thu, 22 Oct 2020 14:50:11 +0000 (UTC)
Date: Thu, 22 Oct 2020 15:50:09 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 16/16] util/vfio-helpers: Remove now unused
 qemu_vfio_pci_init_irq()
Message-ID: <20201022145009.GP761187@stefanha-x1.localdomain>
References: <20201020172428.2220726-1-philmd@redhat.com>
 <20201020172428.2220726-17-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201020172428.2220726-17-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="b5sSX5qSQrSInIHt"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:33:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--b5sSX5qSQrSInIHt
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 07:24:28PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Our only user, the NVMe block driver, switched to the MSIX API.
> As this function is now unused, remove it.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  include/qemu/vfio-helpers.h |  2 --
>  util/vfio-helpers.c         | 43 -------------------------------------
>  2 files changed, 45 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--b5sSX5qSQrSInIHt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+RnCEACgkQnKSrs4Gr
c8g7dgf+KZinj3Uw+6AtusYekxVQx9VjL0tgAB2cfPB/ewu2fQ89oRh6xqmj89D0
fvVCuAT/9yt8KQ6ywI5BlT6H2wH4x5y66GrpLD3XcKknQBBBj1kbUYvOAq8hEA0q
xPpBSfso1ufKgRfiasrLt3MQn+cN+g7W4WX33QFMtFq77zgyt3KoyN1uRePNeBpq
xn63QqkL+yc1BNrjukqDZQepjMHJyDcsQ1NNI3gNTJsaqeCq8kFIQDXhzvlN03ms
rNzoPPcg0bcMKL7TZsXo3tbNEhkm9CB70/L3M05UGf6stqAB6jKUfrMwA1oPMXlr
XtJ0+e9NBdl8fynHIrmysHrN5hr9tQ==
=pFFd
-----END PGP SIGNATURE-----

--b5sSX5qSQrSInIHt--


