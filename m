Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2264C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 00:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 905DE2073D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 00:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSbg4ZaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 905DE2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieTmu-0004RI-NR
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 19:54:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59470)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ieTm9-0003WD-1X
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 19:53:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ieTm6-0000r0-1T
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 19:53:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22795
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ieTm5-0000or-DL
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 19:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575939192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kvrnNhvCF8NUnh3lLgK1pjpHBar+0DizhPnAuX4M+aQ=;
 b=KSbg4ZaA5YGsuejPslZBa1UJmQYZA0kdDwIHhZGJRCl/FKpdaYyV99F9lixSI33gvoHvOO
 coV3oLqaA3egBB1WLn+hZNplHTMNbWMKBWIGS/WYnD1nnT2x5wqMZ48VY2s5SuFJfhNaQj
 QH6BRyRMemH7uEHDHPEOcNiHJUTKMQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-RLykTEymO0WuI3cMBBX0QA-1; Mon, 09 Dec 2019 19:53:09 -0500
X-MC-Unique: RLykTEymO0WuI3cMBBX0QA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AC261804490;
 Tue, 10 Dec 2019 00:53:08 +0000 (UTC)
Received: from localhost.localdomain (ovpn-125-99.rdu2.redhat.com
 [10.10.125.99])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69EB81001DC0;
 Tue, 10 Dec 2019 00:53:00 +0000 (UTC)
Date: Mon, 9 Dec 2019 19:52:58 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH v2 2/4] python/qemu: accel: Add list_accel() method
Message-ID: <20191210005258.GC31990@localhost.localdomain>
References: <20191206213433.11305-1-wainersm@redhat.com>
 <20191206213433.11305-3-wainersm@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191206213433.11305-3-wainersm@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: fam@euphon.net, ehabkost@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, philmd@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--nmemrqcdn5VTmUEE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2019 at 04:34:31PM -0500, Wainer dos Santos Moschetta wrote=
:
> Since commit cbe6d6365a48 the command `qemu -accel help` returns
> the list of accelerators enabled in the QEMU binary. This adds
> the list_accel() method which return that same list.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> ---
>  python/qemu/accel.py | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>=20
> diff --git a/python/qemu/accel.py b/python/qemu/accel.py
> index cbeac10dd1..746b7e68f5 100644
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
> +        out =3D subprocess.check_output("%s -accel help" % qemu_bin, she=
ll=3DTrue)

There's no need to use a shell here.  This could become:

   out =3D subprocess.check_output([qemu_bin, '-accel' 'help'])

> +    except:
> +        LOG.debug("Failed to get the list of accelerators in %s" % qemu_=
bin)
> +        raise
> +    lines =3D out.decode().splitlines()

And maybe discard the first line earlier with:

   lines =3D out.decode().splitlines()[1:]

Also, you could avoid the manual decode() with the `universal_newlines`
option to subprocess.check_output(), ie:

   accels =3D subprocess.check_output([qemu-bin, '-accel', 'help'],
                                    universal_newlines=3DTrue).splitlines()=
[1:]

> +    # Skip the first line which is the header.
> +    return [l.strip() for l in lines[1:] if l]
> +

I think that the `if l` check can actually hide undesirable behavior
(bugs) in the `qemu -accel ?` output.  I don't remember seeing
`-$(option) ?` returning empty strings but doesn't mean it couldn't
and shouldn't).

I do remember `-machine ?` returning random non-printable characters
that turned out to be a bug, though.

>  def kvm_available(target_arch=3DNone):
>      host_arch =3D os.uname()[4]
>      if target_arch and target_arch !=3D host_arch:
> --=20
> 2.21.0
>=20

- Cleber.

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl3u7GgACgkQZX6NM6Xy
CfMVoBAAy8OCdQaB+eV+GDEwHn/LcsE3f58rz+YiVr0iWq+UTg2gz8cWeN+jQWuv
2FwQwKC0ICvGfAiilSAQ02tW7i6iMttxC9n2kRiuisjzIL9MlFsFcThEvsELWK3c
fVb91oLCVwjtWA1bZHVsZzRjg74kdqyvJc1OrmgxcH4CZLqZoLKMa6tzV8LdhDpZ
uy4tGw7J8fLbq6xgAnYFrF/3zI/ffGyPR9etUNSxxTzst5aaHUYxtknakGWBCzd2
HTI1HcO+wge9sqovi0o4VyRjew1eH2cW+myWpQHCZOK2IunKyFktdgSOO/AWBFJg
VC0icNQ+4lvYZEGdBdMEJgGbFwrXMl6fvds2Gj6ldMyW1gHYUvRIYVg4zY9xcqOL
QiW42uY2CJ3fNVGxLnfaZgeDIVHxxXOkneCqVdH/Kai9R1oanqQpYCTsoKeFhKpi
ORHra1EsW/HsWfBE3vaVrUfeKUWKkUlHLVv6JgpR3/w/N6DEPdXvCEaIs9sN3/E3
MQMXa4AXZBLQarS5k3wyNUVlL5kgkS9yHfegR+0CZY8WTUtzKu1uVO+CHSTtjl4U
LT5pnHPa7/ZFF0CSsT2pG7a4JUk56zogJWQ2Nw6uPl9RQaP/tFqfAmt4FAuMfyRV
wZfUn2ntR4OARiQSvBPB29hutIm388j0B1LYpAQ50s1Gs1tkkWM=
=2POn
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--


