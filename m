Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E073BC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 01:11:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACDE4208E4
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 01:11:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bUrRiev0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACDE4208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1JZq-00077m-00
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 21:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k1JYr-0005z9-JJ; Thu, 30 Jul 2020 21:10:13 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:43841 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1k1JYo-00058C-Ad; Thu, 30 Jul 2020 21:10:13 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4BHq2H0fgrz9sTC; Fri, 31 Jul 2020 11:09:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1596157799;
 bh=2jWGzFrX2arc6ubChZExLNp+G15CQRbN3NIzN2ZoFTg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bUrRiev07QhEDqFPfEVWZpmi2W7Ogd7HT53SYkHGWtlaJCp+4L7q1FFcIx/8TuPXA
 c7f1wabp1rJPPFu2/L2TW678AdRUY+0uFPt83r0xGIUHur2Qplfhhi9TEWrXxkO9LJ
 S5scm3refphd/STkC2ryHrKSYyXXTYuVzwn3Ga5I=
Date: Fri, 31 Jul 2020 10:09:34 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH-for-5.1? v2 1/2] qemu/osdep: Make QEMU_VMALLOC_ALIGN
 unsigned long
Message-ID: <20200731000934.GA12398@yekko.fritz.box>
References: <20200730141245.21739-1-philmd@redhat.com>
 <20200730141245.21739-2-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20200730141245.21739-2-philmd@redhat.com>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 21:10:00
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
Cc: Kevin Wolf <kwolf@redhat.com>, Kaige Li <likaige@loongson.cn>,
 kvm@vger.kernel.org, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Juan Quintela <quintela@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2020 at 04:12:44PM +0200, Philippe Mathieu-Daud=E9 wrote:
> QEMU_VMALLOC_ALIGN is sometimes expanded to signed type,
> other times to unsigned. Unify using unsigned.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/qemu/osdep.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 20872e793e..085df8d508 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -454,10 +454,10 @@ void qemu_anon_ram_free(void *ptr, size_t size);
>     /* Use 2 MiB alignment so transparent hugepages can be used by KVM.
>        Valgrind does not support alignments larger than 1 MiB,
>        therefore we need special code which handles running on Valgrind. =
*/
> -#  define QEMU_VMALLOC_ALIGN (512 * 4096)
> +#  define QEMU_VMALLOC_ALIGN (512 * 4096UL)
>  #elif defined(__linux__) && defined(__s390x__)
>     /* Use 1 MiB (segment size) alignment so gmap can be used by KVM. */
> -#  define QEMU_VMALLOC_ALIGN (256 * 4096)
> +#  define QEMU_VMALLOC_ALIGN (256 * 4096UL)
>  #elif defined(__linux__) && defined(__sparc__)
>  #include <sys/shm.h>
>  #  define QEMU_VMALLOC_ALIGN MAX(qemu_real_host_page_size, SHMLBA)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8jYT0ACgkQbDjKyiDZ
s5KjwA//eKV+bR6DCp87g7ELnLlOb6HbZW5XRxIG0gdQMtPQ+ToM4HaYm4q2fnCx
Th/siEebjy9xc2Z/6Tx7dOlc7U0eceaJj+6JlowbzadZSV8C/Da2XQh1BcHyA1Uy
OUuFb8lH9YuetFVOYsL23HVRScDNtD+jueTQhnhIMsBHrnFReKcjUMWmiAUu5Z+H
+9ggSarO53o4F9w/QBfavaonRPWIZn++81zZGImJhfNvz8dUbjRjiRnEQ6eSS60H
DQoNollFlDh6r+Pp5g8h/NL/Z3Z2FpjmEh786IBsgnSDSD2JKDwpug6pXnV+Urpo
0QT1JRZ2+odhM669wCVs8oYNdm4M4r9pcATQmzeMFeWk6duzwkGYxVPpEyWhj4b8
9urtEXOgpoT3kjo/XN2T8g/zAXGaApkSBHCZQ0hyCUCx5Akvh+DHSphYVuC5B++Q
JJIWrKhXHecKzNcirHuZVBdMFlLK+W3S9rZ94AwrXV5h2iCD35uHurAqQleRraL3
zfWU5431urLrLtGMFd6AV6+72huqmA66nbO+gPFotPrDYgR+V/bbm4dtUin8SR7u
BWqAIneDqN9cmtimHi3D76vx7hoxMXSf4LI1XrNz7R9dTk94VwY96maqK1r1+s7T
AshAH9KGb8pgC1ZERj6e+BkY/shfNCleDBg2+8wVK2xiZNWbjxw=
=2zfA
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

