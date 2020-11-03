Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C8BC388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:39:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99AB20773
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 17:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGPyDFul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99AB20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka0HG-000304-Nf
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 12:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ka0Fr-0001Z6-1r
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:37:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1ka0Fn-0008Ij-V7
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 12:37:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604425074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5zUoVI0hF3DS+2MFVZblcUP/Xuwbw3hWTEiG6nOay4U=;
 b=cGPyDFulzO79zn1gV+tjJO0jpBZhcDlB4cvhD3xwdVsoSw4Ide2b98XfJYu2KTuP/dUc8/
 PJXI0sQuuRTmwI2XM7nVumUe8IqJbUwR5DZItGdRujWeActUZcjnzJxol89e9t9/s8z63C
 bEW6MLQ7RBY6UfMktMb2/kXhcHku4uw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-MF0rk2jEPqaFGEM8B584Pw-1; Tue, 03 Nov 2020 12:37:49 -0500
X-MC-Unique: MF0rk2jEPqaFGEM8B584Pw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E85D81099F6B;
 Tue,  3 Nov 2020 17:37:47 +0000 (UTC)
Received: from localhost (ovpn-115-37.ams2.redhat.com [10.36.115.37])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83F0460BF1;
 Tue,  3 Nov 2020 17:37:44 +0000 (UTC)
Date: Tue, 3 Nov 2020 17:37:43 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.2 v3 0/7] util/vfio-helpers: Generic code
 strengthening
Message-ID: <20201103173743.GD259481@stefanha-x1.localdomain>
References: <20201103020733.2303148-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201103020733.2303148-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2020 at 03:07:26AM +0100, Philippe Mathieu-Daud=E9 wrote:
> v3:
> - Extract reviewed patches from
>   "util/vfio-helpers: Allow using multiple MSIX IRQs"
> - Added "Assert offset is aligned to page size"
>   which would have helped debugging:
>   "block/nvme: Fix use of write-only doorbells page on Aarch64 arch"
>=20
> Missing review: 7
>=20
> Based-on: <20201029093306.1063879-1-philmd@redhat.com>
>=20
> Philippe Mathieu-Daud=E9 (7):
>   util/vfio-helpers: Improve reporting unsupported IOMMU type
>   util/vfio-helpers: Trace PCI I/O config accesses
>   util/vfio-helpers: Trace PCI BAR region info
>   util/vfio-helpers: Trace where BARs are mapped
>   util/vfio-helpers: Improve DMA trace events
>   util/vfio-helpers: Convert vfio_dump_mapping to trace events
>   util/vfio-helpers: Assert offset is aligned to page size
>=20
>  util/vfio-helpers.c | 43 ++++++++++++++++++++++++++-----------------
>  util/trace-events   | 10 ++++++++--
>  2 files changed, 34 insertions(+), 19 deletions(-)
>=20
> --=20
> 2.26.2
>=20
>=20

Thanks, applied to my block tree:
https://gitlab.com/stefanha/qemu/commits/block

Stefan

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+hlWcACgkQnKSrs4Gr
c8hncwf/T5a2OSPd3a+DGHCOg0avNGm4vyyJEs0Rw7rAndJ0lk4S+LfgEaMIGTX5
261Bije1zeBIpDFx89KKnt1odRw78joMGzijHx9b4mcczuLOpOlJiqs01IK4+xQz
w0emrqRXN9nn7FLdKD3+9LHxe1MouhHjUydxdA56woCS3EdqVrOzUzKQPsRZhe8p
yAOvtVuozpba+Xdq+XRoGBfw8KyVvoq8m/gPyHsSaLkzCC+4LYDVST5hDMXsgwJr
REil154p+EoO0WY1dPoweXUTpO13/tnKK26sgL21LAAg4R36vNiNPWEao6h1MeYP
kELWrIXdcJD8fX+PFI26PLnwejhiVg==
=Rw4S
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--


