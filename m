Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE33C7618F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:26:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7D492184E
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 15:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D492184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoUmA-0004QB-TQ
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 11:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59990)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hoUm1-0003yo-4l
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hoUlz-00043D-79
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 11:26:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42130)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hoUlf-0000R0-SB; Fri, 19 Jul 2019 11:25:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0545130B1AD1;
 Fri, 19 Jul 2019 15:20:16 +0000 (UTC)
Received: from localhost (ovpn-117-223.ams2.redhat.com [10.36.117.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2E095C261;
 Fri, 19 Jul 2019 15:20:10 +0000 (UTC)
Date: Fri, 19 Jul 2019 16:20:09 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190719152009.GA24412@stefanha-x1.localdomain>
References: <20190719133530.28688-1-mehta.aaru20@gmail.com>
 <20190719133530.28688-3-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20190719133530.28688-3-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Fri, 19 Jul 2019 15:20:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 02/14] qapi/block-core: add option for
 io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, saket.sinha89@gmail.com,
 Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefan@redhat.com>,
 Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2019 at 07:05:18PM +0530, Aarushi Mehta wrote:
> Only enumerates option for devices that support it
>=20
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  qapi/block-core.json | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0d43d4f37c..0a3d4ae7d2 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2792,11 +2792,13 @@
>  #
>  # @threads:     Use qemu's thread pool
>  # @native:      Use native AIO backend (only Linux and Windows)
> +# @io_uring:    Use linux io_uring (since 4.1)

Please change this to 4.2.  QEMU 4.1 is frozen prior to the upcoming
release and new features aren't being merged.

Stefan

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0x36kACgkQnKSrs4Gr
c8juggf/dt7sfnsMke6vaJikoXox6eWK06SSia1Lr56DhOtWQEb7EZvfpKwlbxrv
mlDLRxcnglgdfxWdKmHPP20Cb9jPXutSuCDjGSNAk20/iE2p+G4LHQlhURq6D/+I
xAP41pDSHjGazfao6dyHA1M8sAVNhfXCn+hkDBHKz6J7Ad56TGTcSiqolzurc51C
ApUAZzvn0oGgaQE+nuQFQ/k5ZZXXDf5JlC8Ihdxd6m1AXS6SKdrJHlQxBiyjVsmW
KJsgYB4t5q8yRDemJHJAldr0RaoeNl8l4am+hMCArcJcNqJfpihF53I3ntacbg6/
V9JuQXJxSqKJcKGCZxH274u4m31XuA==
=kr0B
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--

