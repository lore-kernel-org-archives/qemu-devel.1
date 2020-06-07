Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DABBC433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 09:00:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E672064C
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 09:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qubes-os.org header.i=frederic.pierret@qubes-os.org header.b="QCA0F+0s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22E672064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=qubes-os.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhrA6-0006NT-CY
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 05:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frederic.pierret@qubes-os.org>)
 id 1jhr9V-0005su-0K
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 04:59:37 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21366)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <frederic.pierret@qubes-os.org>)
 id 1jhr9U-0007tZ-6B
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 04:59:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591520372; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hFf+u7ZqJl56dJpbUUUofI2Kjk5L9mCdJrzB1Ky+2I+sl7cBOBbuZCjL8ra2pV2KzXf6lswHTYKAWnLAmC5BHYi9ecpXcThKrHseFZ0ogIGLMRYmaex5NB8vapZN4XSSQeiDDf3L3yNWEEkVJ3vqCkhKoJFQ6+zHLfSSClaZSM0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591520372;
 h=Content-Type:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=mFicpizbUs7p+JhrPDe+ZfTfof6Ndo6jt2yuNfIrNaQ=; 
 b=mAUmcAOvj52TSgnSGZ82XsJD81GPoKGiSPIVJ4ym3RiVSfSgsaaiS27NToptSIg9lfs4TjP3dMk0ar/IL1dp2KXNSTm2uJyAQrE6+knIzSpz+l95B3YZKX85gmtJjy0fWIbMWjE0we3XcjjvAoGAi4iLdGen8iQH8jj0ayFwV6c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=qubes-os.org;
 spf=pass  smtp.mailfrom=frederic.pierret@qubes-os.org;
 dmarc=pass header.from=<frederic.pierret@qubes-os.org>
 header.from=<frederic.pierret@qubes-os.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1591520372; 
 s=s; d=qubes-os.org; i=frederic.pierret@qubes-os.org;
 h=Subject:To:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type;
 bh=mFicpizbUs7p+JhrPDe+ZfTfof6Ndo6jt2yuNfIrNaQ=;
 b=QCA0F+0sxpCHmwlXcJ0usTUG8Y+PrVnqGU15RHKeuTYoi4zXiYB0cQKADNcyhoyR
 oJgXt25Kjkf2u1GV+DZ3+YNUFbi6rbE46btkYpq13+vlUQtPVpgmM1pLPKi0StL9zZ2
 ZHynapDsR8AVSti7wNk9DRFOOX6Jurvy9A1Ikg9Q=
Received: from [10.137.0.45] (92.188.110.153 [92.188.110.153]) by
 mx.zohomail.com with SMTPS id 1591520370592544.2954307207424;
 Sun, 7 Jun 2020 01:59:30 -0700 (PDT)
Subject: Re: [PATCH] Makefile: set PYTHON to python2 instead of python
To: qemu-devel@nongnu.org
References: <20200607085639.7640-1-frederic.pierret@qubes-os.org>
From: =?UTF-8?B?RnLDqWTDqXJpYyBQaWVycmV0?= <frederic.pierret@qubes-os.org>
Message-ID: <c3bf9e85-f217-b88b-23bc-4df1a0686b38@qubes-os.org>
Date: Sun, 7 Jun 2020 10:59:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200607085639.7640-1-frederic.pierret@qubes-os.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0BI12UV8WwMap9uadjv2SnVKt4PNTsAiV"
X-Zoho-Virus-Status: 1
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53;
 envelope-from=frederic.pierret@qubes-os.org; helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/07 04:57:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0BI12UV8WwMap9uadjv2SnVKt4PNTsAiV
Content-Type: multipart/mixed; boundary="IFvNGCvJW61kUmSNG3nIIIHjciOwnnADr"

--IFvNGCvJW61kUmSNG3nIIIHjciOwnnADr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

I should have included [SeaBIOS]. Sorry.

On 2020-06-07 10:56, Fr=C3=A9d=C3=A9ric Pierret (fepitre) wrote:
> Newer distro like CentOS 8 does not include any reference
> to 'python' binary but only 'python2'.
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Makefile b/Makefile
> index c20be15..995dc86 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -22,7 +22,7 @@ LD=3D$(CROSS_PREFIX)ld
>  OBJCOPY=3D$(CROSS_PREFIX)objcopy
>  OBJDUMP=3D$(CROSS_PREFIX)objdump
>  STRIP=3D$(CROSS_PREFIX)strip
> -PYTHON=3Dpython
> +PYTHON=3Dpython2
>  CPP=3Dcpp
>  IASL:=3Diasl
>  LD32BIT_FLAG:=3D-melf_i386
>=20


--IFvNGCvJW61kUmSNG3nIIIHjciOwnnADr--

--0BI12UV8WwMap9uadjv2SnVKt4PNTsAiV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEn6ZLkvlecGvyjiymSEAQtc3FduIFAl7crG8ACgkQSEAQtc3F
duIj2Q//RrLCh3xmtF+Ap+w0hK6ubHgpJlnGxFix4jkCn+vER9EBoevzo6SqPrIH
FMNkLxstlYHcI2ZARpwzVGf3MJ9IlagaBMOijmzGJZgv+RSpNTqY7x9+bnhJ39/e
XEUXZULrlt4Q/WHFNCKDnRAV9OLZGUQPuFQZGVFBmT32uUcUiTEbWFz4z6ls9uPh
zq+Gs/703TwDVJKVNNfOW+DjSqRH0eXLiCQU/9kZBGi67mMO+gCTeHqwpqMaeHPC
tVKY21vaWN9f7w18bwoq5pvUp8Rqz37BkVvuDkvkNhmlFZc0xX74yEW9LevoApkP
/wM6xJv4IVHIovPKf4ZLFqKcOZ7t1IVeJGcdc44WSgqt9gI3FjygIXKBdO33Ef2P
AMSWRurZZF685KcAj/ty6ensN+8LiUOz9w0zop7D0V9YfiOqktr+9qlVxVNthftR
9FdkSBfOwEkRDZvCC7M5T4FnLV9VSTjptfNJZ4U5Gh/sHzS2hS9x0HLMMlkEiGYa
wKsIak+HF3OcYhtaaJMAqlsMQX9Xgv0/IHuzO6r/30LFNCWMHBhHny2sAqPZbn6N
cO2y+tBqGKWnbUFtXgaLe8ZbXtOGfT8CgjPmkkthHC6P2dZkW07NVeBa+llfTy4B
UkfpFfxQYmDSZWrjQNAslHfv6ib97MHetX7Ligmar/i/I8nfu2E=
=4dOq
-----END PGP SIGNATURE-----

--0BI12UV8WwMap9uadjv2SnVKt4PNTsAiV--

