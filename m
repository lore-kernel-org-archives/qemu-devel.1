Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2635C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 13:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01400206B2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 13:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="htqVtI1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01400206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZwB4-00081R-02
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 08:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kZw9B-0006xz-4p; Tue, 03 Nov 2020 08:14:49 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:58323 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kZw98-000311-Ej; Tue, 03 Nov 2020 08:14:48 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4CQVcc2nnvz9sSs; Wed,  4 Nov 2020 00:14:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1604409280;
 bh=5KKGYc46HYuVj17nvHU0QwaSj1jD5BWhEaBhj9s9iYw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=htqVtI1d4aw3JebmdUcZN33H+KzCoHsw+33ws1xO0cGrbf1V2hKZPm6DdjCDmE/00
 aNKLyGjxKbKGNTA0XPWYOLF5+LIyVkJ3+JXD7V7bH0m9yhpwAhZ4W9sck38zRHTKDy
 apmeAtI2zyv1SnlQKPuW6fT9zP/D2Xkuv2F6GRkE=
Date: Tue, 3 Nov 2020 22:39:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.2 3/4] hw/ppc/spapr_tpm_proxy: Fix hexadecimal
 format string specifier
Message-ID: <20201103113948.GG143651@yekko.fritz.box>
References: <20201103112558.2554390-1-philmd@redhat.com>
 <20201103112558.2554390-4-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="m0vRWufqUC70IDnR"
Content-Disposition: inline
In-Reply-To: <20201103112558.2554390-4-philmd@redhat.com>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, Dov Murik <dovmurik@linux.vnet.ibm.com>,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--m0vRWufqUC70IDnR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2020 at 12:25:57PM +0100, Philippe Mathieu-Daud=E9 wrote:
> The '%u' conversion specifier is for decimal notation.
> When prefixing a format with '0x', we want the hexadecimal
> specifier ('%x').
>=20
> Inspired-by: Dov Murik <dovmurik@linux.vnet.ibm.com>
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/trace-events | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
> index dcc06d49b5a..6d8d095aa28 100644
> --- a/hw/ppc/trace-events
> +++ b/hw/ppc/trace-events
> @@ -19,7 +19,7 @@ spapr_update_dt_failed_size(unsigned cbold, unsigned cb=
new, unsigned magic) "Old
>  spapr_update_dt_failed_check(unsigned cbold, unsigned cbnew, unsigned ma=
gic) "Old blob %u bytes, new blob %u bytes, magic 0x%x"
> =20
>  # spapr_tpm_proxy.c
> -spapr_h_tpm_comm(const char *device_path, uint64_t operation) "tpm_devic=
e_path=3D%s operation=3D0x%"PRIu64
> +spapr_h_tpm_comm(const char *device_path, uint64_t operation) "tpm_devic=
e_path=3D%s operation=3D0x%"PRIx64
>  spapr_tpm_execute(uint64_t data_in, uint64_t data_in_sz, uint64_t data_o=
ut, uint64_t data_out_sz) "data_in=3D0x%"PRIx64", data_in_sz=3D%"PRIu64", d=
ata_out=3D0x%"PRIx64", data_out_sz=3D%"PRIu64
> =20
>  # spapr_iommu.c

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--m0vRWufqUC70IDnR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl+hQYEACgkQbDjKyiDZ
s5Ip7A/+O4OeY7yjLbwtMaoMnrxalSFJDk6nGQK+hEIrgK1TjekfgK/T6OSz7Sl7
dNKzjF+xtwJePuleIYwLzUUehc/Ab/QoG62gz33SIybarJUDUq1GBBX2b6RWuVEg
50i3gC8pWOPhbL7a6y47LSsyAr3GdNvzE1s3vE1lm3KPp7Dtcq9saE+zPyDOK75J
FnlhaF/FFA0xVGiLaI2SiA6wF1i852Ppj9NBZzJyh3to3YfjQqQSdAFQB2+eDIqF
LiovyhGGqaKELqTKhvZxibWQ1GExbRrP0uLz2Elt0N0YP5AH9+6iy57nmmq+xwAs
DON87piOCyQz4IAfFIHVYzka+cU/HBsBkzNbcs6U4uJlTxSgRBFjamxzy/I6IAkp
G1UgkhmSr2+NMGYH4v20zzRpBt424BoYg0JQHTojrgPfT0Lb3raluet8JR8lo28I
M3S9yiyYMo/1nWvM8v2mVRY+LvHp32FPUwiqqwFjJwwoEORV5Rj7HIY6wbjSLqlR
GS9+5hfzZSAlI1CO36+HKucbw6TYJoVLatt921QvorznBh+ew2FJtNgTtOMWm5IY
t7y0rEK1x3RadF6Euv4uL0EsUtSRKuzFBb81OD+/BjZaDZRG/Y+71QE2VTnHeIJl
wgZY4AFR9H25naaGXk+ACQBsK8QUY+JBNo2rs+/8VcVFdNmfLCY=
=4n5J
-----END PGP SIGNATURE-----

--m0vRWufqUC70IDnR--

