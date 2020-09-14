Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAE4C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:06:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C72020715
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 16:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AYq/ZnmN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C72020715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHqzp-0001Df-8T
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 12:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kHpJD-0001pl-9P
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:18:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kHpJB-0000ku-E8
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 10:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600093096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pHOIGQPbtopccAorHZ23av7PCHO0J7zXSXdiXtLkwFo=;
 b=AYq/ZnmN4GAmSVkxBDmLh4blJbRfh/UHsNTwcRBTcuLQn3yNIHmHwZ8EpPtwiWBPF2y1BK
 uJnMOzPW07F6a7DmhL8hvW/+nsFwSteg4APfAFLUc4gQpEZ1EG9p0Vew/rdW+Mq03UHRF8
 gI9RLeQ/A8gYkgCJobSrbqt8xJAwhgk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-PGcTUXE5PNmy8y5wSE7_fA-1; Mon, 14 Sep 2020 10:18:12 -0400
X-MC-Unique: PGcTUXE5PNmy8y5wSE7_fA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89E611084C86;
 Mon, 14 Sep 2020 14:18:11 +0000 (UTC)
Received: from localhost (ovpn-114-32.ams2.redhat.com [10.36.114.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56CDB7B7B5;
 Mon, 14 Sep 2020 14:18:08 +0000 (UTC)
Date: Mon, 14 Sep 2020 14:46:35 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] docs/system: clarify deprecation scheduled
Message-ID: <20200914134635.GO579094@stefanha-x1.localdomain>
References: <20200811104736.17140-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200811104736.17140-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7gLe/sNPhR777EPF"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: libvir-list@redhat.com, philmd@redhat.com,
 Daniel Berrange <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--7gLe/sNPhR777EPF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2020 at 11:47:36AM +0100, Stefan Hajnoczi wrote:
> The sentence explaining the deprecation schedule is ambiguous. Make it
> clear that a feature deprecated in the Nth release is guaranteed to
> remain available in the N+1th release. Removal can occur in the N+2nd
> release or later.
>=20
> As an example of this in action, see commit
> 25956af3fe5dd0385ad8017bc768a6afe41e2a74 ("block: Finish deprecation of
> 'qemu-img convert -n -o'"). The feature was deprecated in QEMU 4.2.0. It
> was present in the 5.0.0 release and removed in the 5.1.0 release.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/system/deprecated.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Ping?

>=20
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 851dbdeb8a..fecfb2f1c1 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -4,9 +4,9 @@ Deprecated features
>  In general features are intended to be supported indefinitely once
>  introduced into QEMU. In the event that a feature needs to be removed,
>  it will be listed in this section. The feature will remain functional
> -for 2 releases prior to actual removal. Deprecated features may also
> -generate warnings on the console when QEMU starts up, or if activated
> -via a monitor command, however, this is not a mandatory requirement.
> +for 1 more release after deprecation. Deprecated features may also gener=
ate
> +warnings on the console when QEMU starts up, or if activated via a monit=
or
> +command, however, this is not a mandatory requirement.
> =20
>  Prior to the 2.10.0 release there was no official policy on how
>  long features would be deprecated prior to their removal, nor
> --=20
> 2.26.2
>=20

--7gLe/sNPhR777EPF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9fdDsACgkQnKSrs4Gr
c8gc3ggAkMegKwFe9fk/PYRAg6OM+TPAxsDkvGk1E+TWpFH5i7+tRZZm5U+WzsE3
pqnnbWpzIBXwxW9jChxph6RFvV2xwKDv4m9kis8Ve06mC+zvbgpKrtgk+qYpDDdM
Er4sLI4vZh0E3J3mAB05Ur+LddSgjIyNcRjuWcCT14+Tbv/twsQyrRFg5ZifIO/b
HhtEtWZ4ZuHk8My+fQzyUYx4Vg6nz01t00GV+OLKizI7U9y7XMOr+ItsWCo+zX9r
6/D1cVT0KRxJgGb3MLtTiHL5vm4aVCxY0jdVjmf5O9b7xxNujV1OZh0LpqjfXSm1
gAkXpiQN0KXTAuebbdPUVdhXhx35vw==
=xOnc
-----END PGP SIGNATURE-----

--7gLe/sNPhR777EPF--


