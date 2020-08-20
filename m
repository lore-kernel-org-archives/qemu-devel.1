Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B62C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:00:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE5E207FB
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 01:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="KqtY+H+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE5E207FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8Yw3-0007CK-5c
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 21:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8YvG-00065F-KX; Wed, 19 Aug 2020 20:59:18 -0400
Received: from ozlabs.org ([203.11.71.1]:34197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k8YvC-0007Lt-O1; Wed, 19 Aug 2020 20:59:18 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BX5rR6bxxz9sTb; Thu, 20 Aug 2020 10:59:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1597885143;
 bh=YVRLoLx4p9wGsOkN5rYW3GldF0CsCX/f203JATbnfH0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KqtY+H+fdf3Bly4y5dZcRCbbve/UptFlY45pX7eJT/JREKDVmMqknwU8OAwn4Zjex
 kHUqs6NBTvOQ5/Dj7iViaxgykoe6dtA4yMioUTrwb3w4Y5PwBIUA727Iombw5OFN8G
 g1OXRODx6xqKmEzIOmN0xzH9gXxyR+Q1ub3jn//8=
Date: Thu, 20 Aug 2020 10:58:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 2/8] linux-headers: Update for KVM_DEV_XIVE_GRP_SOURCE_INFO
Message-ID: <20200820005851.GE271315@yekko.fritz.box>
References: <20200819130843.2230799-1-clg@kaod.org>
 <20200819130843.2230799-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Content-Disposition: inline
In-Reply-To: <20200819130843.2230799-3-clg@kaod.org>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:59:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>,
 Gustavo Romero <gromero@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2020 at 03:08:37PM +0200, C=E9dric Le Goater wrote:
> To be sent with the linux-headers update when support is merged.

Ah, so this isn't ready to go just yet.

>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  linux-headers/asm-powerpc/kvm.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/=
kvm.h
> index 264e266a85bf..aeb8e8c4633b 100644
> --- a/linux-headers/asm-powerpc/kvm.h
> +++ b/linux-headers/asm-powerpc/kvm.h
> @@ -690,6 +690,7 @@ struct kvm_ppc_cpu_char {
>  #define KVM_DEV_XIVE_GRP_SOURCE_CONFIG	3	/* 64-bit source identifier */
>  #define KVM_DEV_XIVE_GRP_EQ_CONFIG	4	/* 64-bit EQ identifier */
>  #define KVM_DEV_XIVE_GRP_SOURCE_SYNC	5       /* 64-bit source identifier=
 */
> +#define KVM_DEV_XIVE_GRP_SOURCE_INFO	6       /* 64-bit source identifier=
 */
> =20
>  /* Layout of 64-bit XIVE source attribute values */
>  #define KVM_XIVE_LEVEL_SENSITIVE	(1ULL << 0)
> @@ -721,6 +722,13 @@ struct kvm_ppc_xive_eq {
>  	__u8  pad[40];
>  };
> =20
> +#define KVM_XIVE_SOURCE_FLAG_STORE_EOI	0x00000001
> +
> +/* Layout of source characteristics (8 bytes) */
> +struct kvm_ppc_xive_src {
> +	__u64 flags;
> +};
> +
>  #define KVM_XIVE_EQ_ALWAYS_NOTIFY	0x00000001
> =20
>  #define KVM_XIVE_TIMA_PAGE_OFFSET	0

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl89yssACgkQbDjKyiDZ
s5J93A/+LSvQxdt5VERna2lsWljCrownx5Qk9EXx+p0d/vVCIFmBtZkBPX4ssRjG
mTiVJtyoLO5DXmvPPssyfCoJzjbgUEibDwd2EIWXtLoZh7lH25IJdIezlGLbGBWV
/wGSXROARBTu64WR8yDcuDPsO+AAGKMTBGdiAHi6Qye6TJ6WrGrm54Y/Jlwml0SF
luuGKlPu4bP8vvjyVMCqmuAZfvnZ5Vpr8TtFyDJZtO98UNWfsohYwWVnt4EMqxk8
GBjKVhavjZ4muAW4QlKkJUvEgOFdq3OLFIuh1GVvfOG29xp60McATLLY2HbnAqxA
cqkDCcBlF4xRkfmz3fe6/PuaJujep6cIQQFsa4gIzTRAVJGUqLAK5jUXiKqr+5dS
Qm5tIOuQ4HI+tbTYppU65UjDZI9brzua9mrcHebYtFLHi//ubT+SxVOIXesQQC+E
4apFnfvq9pmCR6r4c5iUKvKhWrgwzneJmKXPrWPbKuOgyJaFWYnkiItsl7XjN0E4
YAImQOHmUCNiSCtqEHPHFpfx06B9dTD52lTzXsWZAeuKdSxQ6CC/riBkKyFeHFaB
hexhjBSnOQviwew6/i10L1TSbaedI+h89XILo38JeSs4TJUgPe9ySP6SybWpZrTV
4ix1jgq9Rb8B716Mz/fUl5eaaa3uv0U0G5dJ8bvpMM2HnU8oXG0=
=rRS3
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--

