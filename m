Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95264C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:36:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A411207FC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:36:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A411207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtny-0003AJ-Bk
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53077)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iAtgP-0002zu-1D
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iAtgN-0003Z3-Or
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:29:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iAtgN-0003Yn-IX
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:29:03 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B6A53C057E9F;
 Thu, 19 Sep 2019 10:29:02 +0000 (UTC)
Received: from localhost (unknown [10.36.118.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0CB5919C5B;
 Thu, 19 Sep 2019 10:28:59 +0000 (UTC)
Date: Thu, 19 Sep 2019 11:28:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Oleinik, Alexander" <alxndr@bu.edu>
Message-ID: <20190919102858.GJ3606@stefanha-x1.localdomain>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-7-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="07FIeBX8hApXX6Bi"
Content-Disposition: inline
In-Reply-To: <20190918231846.22538-7-alxndr@bu.edu>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 19 Sep 2019 10:29:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 06/22] fuzz: add configure flag
 --enable-fuzzing
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--07FIeBX8hApXX6Bi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 18, 2019 at 11:19:33PM +0000, Oleinik, Alexander wrote:
> Signed-off-by: Alexander Oleinik <alxndr@bu.edu>
> ---
>  configure | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/configure b/configure
> index 30aad233d1..775f46f55a 100755
> --- a/configure
> +++ b/configure
> @@ -498,6 +498,7 @@ libxml2=3D""
>  debug_mutex=3D"no"
>  libpmem=3D""
>  default_devices=3D"yes"
> +fuzzing=3D"no"
> =20
>  supported_cpu=3D"no"
>  supported_os=3D"no"
> @@ -1521,6 +1522,8 @@ for opt do
>    ;;
>    --disable-libpmem) libpmem=3Dno
>    ;;
> +  --enable-fuzzing) fuzzing=3Dyes
> +  ;;

Please add --disable-fuzzing, the ./configure script says:

  # Always add --enable-foo and --disable-foo command line args.

>    *)
>        echo "ERROR: unknown option $opt"
>        echo "Try '$0 --help' for more information"
> @@ -6429,6 +6432,7 @@ echo "capstone          $capstone"
>  echo "libpmem support   $libpmem"
>  echo "libudev           $libudev"
>  echo "default devices   $default_devices"
> +echo "fuzzing support   $fuzzing"
> =20
>  if test "$supported_cpu" =3D "no"; then
>      echo
> @@ -7258,6 +7262,10 @@ fi
>  if test "$sheepdog" =3D "yes" ; then
>    echo "CONFIG_SHEEPDOG=3Dy" >> $config_host_mak
>  fi
> +if test "$fuzzing" =3D "yes" ; then
> +  FUZZ_LDFLAGS=3D" -fsanitize=3Daddress,fuzzer"
> +  FUZZ_CFLAGS=3D" -fsanitize=3Daddress,fuzzer"
> +fi

Is -fsanitize=3Dfuzzer a clang-only option?  If yes, then please ensure
that there is a friendly error message when ./configure is run with gcc.
You could probe if -fsanitize=3Dfuzzer works and then check that
fuzzing=3Dno when this feature is unavailable.

--07FIeBX8hApXX6Bi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl2DWGoACgkQnKSrs4Gr
c8irbAf+KSkxNsRW2N+HFIUxh54gGgKarGbDilKTOeDG9yGvZnKETjb0Yz02sLET
iIX5OQjzcWqE9Vetvghyw1IOoL+iWZteHStAah4zfBqSOYA62YSXqDLKBzOCIbZu
5s7beSj9SuqvROSH5XSLnIzw7OVWgqigRf6Qj3DbtIbJu8U28PX3v8UoPT8uKxBl
yO/uHUHyD8UUpAFIy+HGm5ZLn27e9zoKLMGNVnC4yxqHiGxnIr4cUbnFouutgGik
b2Xe2EwH1z2p/LL4luIuPnz87frUrxkCJOVKoa7EIUIDOcNxbUqTqtXneLiEh/0s
dmqTV3S8M1RmA/RYzbmm3zTWgCVsnA==
=aerc
-----END PGP SIGNATURE-----

--07FIeBX8hApXX6Bi--

