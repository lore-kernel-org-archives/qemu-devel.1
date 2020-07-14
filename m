Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42067C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 04:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9B742065D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 04:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHqB+0cH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9B742065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvCLg-00031h-92
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 00:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jvCL7-0002bw-0I
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 00:14:45 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25635
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1jvCL4-000722-5y
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 00:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594700081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0T570xxamcTyCkniSz0e1NtIHgv/b2WWocqPrIKvv0w=;
 b=JHqB+0cHsvrnw7fiUutRrBVImLZkyA3qluJxaAv/bUjwwT7lPP79dg+n9GyInnWJ2i5tbT
 yq31uSgGVZH1hGfXjzOrb5Qr50RBrxcv3VcQXnMcUvvxhiBnm560kvMPRbt9NPZige0h0g
 Ej+kKscOKnJFgNDk+k9qXL9Ppx8Ljzk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-Ioa0Ky7YM7-F_ViCYvjboQ-1; Tue, 14 Jul 2020 00:14:38 -0400
X-MC-Unique: Ioa0Ky7YM7-F_ViCYvjboQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 676E1800400;
 Tue, 14 Jul 2020 04:14:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-247.rdu2.redhat.com
 [10.10.112.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8404F5C679;
 Tue, 14 Jul 2020 04:14:33 +0000 (UTC)
Date: Tue, 14 Jul 2020 00:14:31 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v5 11/12] python/machine.py: re-add sigkill warning
 suppression
Message-ID: <20200714041431.GI2983508@localhost.localdomain>
References: <20200710050649.32434-1-jsnow@redhat.com>
 <20200710050649.32434-12-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200710050649.32434-12-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZOudaV4lSIjFTlHv"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 21:30:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ZOudaV4lSIjFTlHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2020 at 01:06:48AM -0400, John Snow wrote:
> If the user kills QEMU on purpose, we don't need to warn them about that
> having happened: they know already.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  python/qemu/machine.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--ZOudaV4lSIjFTlHv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl8NMScACgkQZX6NM6Xy
CfPqdRAAvB4yRX+FwBsK7e90kkmRnc/nk/RzF5cFhOvYofaGDccaYlWR7FmYq36i
+E1CEQtForCbSbC33hXl1q+N3OoegsTS+9VO7206LZHGvBayJCiMKgFXmei3UsUM
xyNmhm6TlvPKvBW6CsY9VcwxyR6CbnSRyvg4NtOYtJ1SFvvUs6hPSph5gqVV6Zvg
gq1TW8GXrxD5u6A6YjEZ80r1Ka4Ipvg2hfHcbo/Puaq/dM74BB/MFNYKLHFxw5DR
Zy0x6w8bRRZU9Bbimj2Sf7qHVbcg04cHelLPiO2NgBDVMFKxgOhPT+6zzEfkkYrL
9M1FE1xbU0wVB/oYL3/RwPbiMEKxiCkOAwVdHZzH0Y9sgedt/nINc8fbh9NjcY5v
oLWlRws3ljBX3/G4mxrStx2ayS+ArFxjBkJ5y8Cu6Dt694LQdEQuRk2PXUVVzIeo
C6dQieuIpPhywS2UVv2qy8F/VRAj/c57lxrRt6OIXsYbDHQd9e19svEtyi0e09UM
+WgpOMekFtlyQle/g0UONWeXCfNCkZ/lGA3t9QxXYM/oqP/V/HmNHarM0K8Hbj9R
bux4XTO5LOD0hCJsuZ2Je1sT6T1UvpCLHo5g50RD1KIHxFoyRiGjW6XQpqJRG5YL
4ItHTSbjwwNyuyXXDJdnLFN1+Q9i1q8wGKTbngzIrNdfSCmrSQw=
=hrXS
-----END PGP SIGNATURE-----

--ZOudaV4lSIjFTlHv--


