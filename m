Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC81C388F9
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:50:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF29C24197
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 14:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzg1cAAR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF29C24197
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVbvS-0003Oz-Vt
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 10:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVbtP-0001kZ-Sb
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:48:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38722)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kVbtL-0006Ov-14
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 10:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603378114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=whsDFJkCHr9GCpPLUeRnAlkmd43y6ZOFxl2sjIsEplU=;
 b=gzg1cAARDffrQdDHrrx3Jm0iRBWi6H9jZImjIWBbkkob2MFPTeUXq8JY16IjIw4BCbyMQk
 cxSuqgEdb+jY373snyhXt7Qlg1DMD2Y5uyrq9xXD6pNUwztISQ1agrnW/WByPWtmNH1man
 3Y2nIhAvPg7ccaknkoF16Qu36RfYBzY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-F-8C4SOYNEeX80LsVs8pFQ-1; Thu, 22 Oct 2020 10:48:32 -0400
X-MC-Unique: F-8C4SOYNEeX80LsVs8pFQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94E72804B7E;
 Thu, 22 Oct 2020 14:47:36 +0000 (UTC)
Received: from localhost (ovpn-114-229.ams2.redhat.com [10.36.114.229])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E583960BFA;
 Thu, 22 Oct 2020 14:47:35 +0000 (UTC)
Date: Thu, 22 Oct 2020 15:47:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 14/16] util/vfio-helpers: Introduce
 qemu_vfio_pci_msix_set_irq()
Message-ID: <20201022144734.GN761187@stefanha-x1.localdomain>
References: <20201020172428.2220726-1-philmd@redhat.com>
 <20201020172428.2220726-15-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201020172428.2220726-15-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="U6leaJ20qZQc29iB"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 08:09:01
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--U6leaJ20qZQc29iB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2020 at 07:24:26PM +0200, Philippe Mathieu-Daud=E9 wrote:
> Introduce qemu_vfio_pci_msix_set_irq() to set the event
> notifier of a specific MSIX IRQ. All other registered IRQs
> are left unmodified.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  include/qemu/vfio-helpers.h |  2 ++
>  util/vfio-helpers.c         | 35 +++++++++++++++++++++++++++++++++++
>  util/trace-events           |  1 +
>  3 files changed, 38 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--U6leaJ20qZQc29iB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+Rm4YACgkQnKSrs4Gr
c8g37wf9EFmMai9LVuNcfnoI/h5b6wJIi3mF7dIYjxlSl0k4lnZYg2zPkBAmEhtG
SjR8bhiQyFDWr7heC3mi56vPfWc/Jpe+03XxUqueGYu/K5EM7zLFtK8WXNcrr3cm
KjdaO3HtHX1GSAT7ektsRgssm7x8bI1kQNkSzSg5O35X356lHpFGSdSDk6E0CKvr
JYtBMpZRPvBgeEm8DPPafPhR1cAjqCFOZkpb6v22oxo9aoqbww+nHbjedMPPJh9a
MJPgNqrf9RdhCvySBKOGsu0s3OD9iix3PbY+ordtfnrujL9oZQ5CQ0Z8tA/NxLLg
DBz0Uubzt7vPP+o5sXW8N/g6HsiNXg==
=FCgA
-----END PGP SIGNATURE-----

--U6leaJ20qZQc29iB--


