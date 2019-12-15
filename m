Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89769C43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 21:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 557CA24673
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 21:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WcjQSelh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 557CA24673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igb4r-0003dk-Dx
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 16:05:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1igb4A-0003Cl-6q
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 16:04:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1igb46-0007f2-NK
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 16:04:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25333
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1igb46-0007Xb-3G
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 16:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576443871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AHF/iNSQsVd2ckl9PegzDBsbBIWjOSIjFFcP+3ZOnKI=;
 b=WcjQSelhNBbHVk0jEU/HCrTd8KDKOktkZpwHelNNgMEPdDl08lYTdt8yw86xr5wmz7+Vg5
 jcbxgZpkqbV3h1FjmrvQ6YsO5M2SabD9sjn6e4630FfQ2UHMBUBP9rSas44pLNRg182XTQ
 9LF562E9vSJaii4tFuFB/YXpbrPp/XM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-Qi6F7M61Oh-Z3MbsjU4FRQ-1; Sun, 15 Dec 2019 16:04:28 -0500
X-MC-Unique: Qi6F7M61Oh-Z3MbsjU4FRQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C8D8107ACC5;
 Sun, 15 Dec 2019 21:04:27 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-5.gru2.redhat.com [10.97.116.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBB2F60933;
 Sun, 15 Dec 2019 21:04:18 +0000 (UTC)
Date: Sun, 15 Dec 2019 16:04:15 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH v3 2/5] python/qemu: accel: Add list_accel() method
Message-ID: <20191215210415.GD22814@localhost.localdomain>
References: <20191212125831.2654-1-wainersm@redhat.com>
 <20191212125831.2654-3-wainersm@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191212125831.2654-3-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SFyWQ0h3ruR435lw"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: fam@euphon.net, ehabkost@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, alex.bennee@linaro.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--SFyWQ0h3ruR435lw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2019 at 07:58:28AM -0500, Wainer dos Santos Moschetta wrote=
:
> Since commit cbe6d6365a48 the command `qemu -accel help` returns
> the list of accelerators enabled in the QEMU binary. This adds
> the list_accel() method which return that same list.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

The degree of changes is certainly subjective, but consider clearing
"Reviewed-by"s, according to:

https://wiki.qemu.org/Contribute/SubmitAPatch#Proper_use_of_Reviewed-by:_ta=
gs_can_aid_review

Alex, Phillipe,

You re-review on this patch is highly appreciated anyway.

> ---
>  python/qemu/accel.py | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/python/qemu/accel.py b/python/qemu/accel.py
> index cbeac10dd1..ddcdbfd9ae 100644
> --- a/python/qemu/accel.py
> +++ b/python/qemu/accel.py
> @@ -14,7 +14,11 @@ accelerators.
>  # the COPYING file in the top-level directory.
>  #
> =20
> +import logging
>  import os
> +import subprocess
> +
> +LOG =3D logging.getLogger(__name__)
> =20
>  # Mapping host architecture to any additional architectures it can
>  # support which often includes its 32 bit cousin.
> @@ -23,6 +27,25 @@ ADDITIONAL_ARCHES =3D {
>      "aarch64" : "armhf"
>  }
> =20
> +def list_accel(qemu_bin):
> +    """
> +    List accelerators enabled in the QEMU binary.
> +
> +    @param qemu_bin (str): path to the QEMU binary.
> +    @raise Exception: if failed to run `qemu -accel help`
> +    @return a list of accelerator names.
> +    """
> +    if not qemu_bin:
> +        return []
> +    try:
> +        out =3D subprocess.check_output([qemu_bin, '-accel', 'help'],
> +                                      universal_newlines=3DTrue)
> +    except:

This is a "generally frowned upon" naked except, but given that its
goal is to present the error to the user, and that it re-raises the
exception, it's much less frowned upon, so it LGTM.

> +        LOG.debug("Failed to get the list of accelerators in %s" % qemu_=
bin)

The ideal use of the logging module log functions is to let them
format the output, passing those values as arguments, ie:

   LOG.debug("Failed to get the list of accelerators in %s", qemu_bin)

See https://docs.python.org/3.7/library/logging.html#logging.Logger.debug

And sorry for failing to catch this on v2.

- Cleber.

> +        raise
> +    # Skip the first line which is the header.
> +    return [acc.strip() for acc in out.splitlines()[1:]]
> +
>  def kvm_available(target_arch=3DNone):
>      host_arch =3D os.uname()[4]
>      if target_arch and target_arch !=3D host_arch:
> --=20
> 2.21.0
>=20

--SFyWQ0h3ruR435lw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl32n8wACgkQZX6NM6Xy
CfMwbg/7Bqc+Wx9f/1Ba5B56g1cHUJZLKQgjljhPjVVjeeOvlxd5FXbT0ARUwCd2
J+airM+vJ044X/mo00zSVsAVBbpr7ChW0JLe9I/Cc2dsul/M/u07hyZGbyj60T3m
pGQPGjRI+7Qw5RqJnLWv1wmYkeWmNKisLNaA+494D/tmmL+Slo7BmsJLmZHCMEGq
yaJo7Oo308SEbK+Dpcq9EFdLQ9ZXdAirlz6GF+7ak3mRz0QOPT37giUwlIMmQEiL
gq8hj4KraxxXknVmfmCkk8xN07eYdKEM31eFCUKbwIexPBOLXjtWYKa5HuwODZCR
CGTFtjBfepbzzYrNFx1Fs+HqXNV/ymEBohvvOua9CaYACtMfksMW6+gZG4PEig2v
RSsRNC+S2f0D0KUjbQKJYTngab/qYZPjPieo/18sWlrWFZHHOR6Z+70c1kX6Qbf4
bMUGlOAcyRlYIfRIz1Bl/581nFB8nJ5/o4+RpXyYx5uKDXJDUby0aSLV4OMQRZy3
sMEDZZGrgIuHlWiSkwPjRqIPJoxAFjgnryD0hVulD7RfCdQ20BRQvYzu09JW7l5B
C0eS7/us2rAUDfRYlIggyx8VtiIGwzChz/WC6bGlIAu3CP5oCaB4w9NgUiW742nL
qcuVu+3iKFL8g4jcb30wseL0BSCDsEy2eRnPUceGnYZaCTGRuhA=
=wIbF
-----END PGP SIGNATURE-----

--SFyWQ0h3ruR435lw--


