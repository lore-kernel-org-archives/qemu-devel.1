Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9879CC43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 21:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5983A24676
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 21:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ep1ryVeW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5983A24676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igbJd-00006G-FR
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 16:20:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1igbIn-0007mt-8H
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 16:19:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1igbIl-0006Ww-C4
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 16:19:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52232
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1igbIj-0006TF-Ou
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 16:19:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576444780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dHL8EqOVfmLVq6EqxSRbIZIuHTziBTLE56Qsb/9JvSw=;
 b=Ep1ryVeWWvnRO0r2EeUuwdZZuoL4LYsDhLWZJUOkZHZoH215xzw0uh4MfXlAvmBVLoKLOv
 qHQfQWFMGoq43re5Fhi9aBswlm1FSDSFOBrW4XLTWtRuIiywH2655Lc1MGru3/igIDnhvY
 QpJGF3tqqg2yhcxQGjqzF/Dbpdz1HMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-195-biVEJBraMGaSDkVs5oNPzg-1; Sun, 15 Dec 2019 16:19:38 -0500
X-MC-Unique: biVEJBraMGaSDkVs5oNPzg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2C57B800D48;
 Sun, 15 Dec 2019 21:19:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-5.gru2.redhat.com [10.97.116.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BD4665C28D;
 Sun, 15 Dec 2019 21:19:26 +0000 (UTC)
Date: Sun, 15 Dec 2019 16:19:23 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH v3 5/5] python/qemu: Remove unneeded imports in __init__
Message-ID: <20191215211923.GE22814@localhost.localdomain>
References: <20191212125831.2654-1-wainersm@redhat.com>
 <20191212125831.2654-6-wainersm@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191212125831.2654-6-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="hwvH6HDNit2nSK4j"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

--hwvH6HDNit2nSK4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2019 at 07:58:31AM -0500, Wainer dos Santos Moschetta wrote=
:
> __init_.py import some sub-modules unnecessarily. So let's
> clean it up.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Suggested-by: Cleber Rosa <crosa@redhat.com>
> ---
>  python/qemu/__init__.py | 6 ------
>  1 file changed, 6 deletions(-)
>=20
> diff --git a/python/qemu/__init__.py b/python/qemu/__init__.py
> index eff17a306e..4ca06c34a4 100644
> --- a/python/qemu/__init__.py
> +++ b/python/qemu/__init__.py
> @@ -9,9 +9,3 @@
>  # This work is licensed under the terms of the GNU GPL, version 2.  See
>  # the COPYING file in the top-level directory.
>  #
> -# Based on qmp.py.
> -#
> -
> -from . import qmp
> -from . import machine
> -from . import accel
> --=20
> 2.21.0
>=20

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--hwvH6HDNit2nSK4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl32o1gACgkQZX6NM6Xy
CfMKCBAAz8LOklXCFBWh2wu5H2lviZ44Y5N5dOYqmcMCTj530C+YeNsTC/vTiugx
HDqf6C6DdUXOG9ukfHhA5Q0xp38DQhqQ32wOGXULspqYaNdjzS+Xrp9Zb8+yOe4Y
eBcMPKVS6I/w9bIwwoiadSx2+Zbw/kaMMTJfd0Rw9klq/LX80oZ8uwtZ8dQZeTUf
PxIs7GOx8EUFEHQGpk1jCmtpnq76C+L37aAbsbngju66Y3xZhOZXliMToR7ncBVw
KjerAFAHW+mNadGM0RM7aLXkm/Nv06nPSFLDUHGahNn3y/DJ8W9DiY17TIxxQFZ9
wEObphy/RiECOmkP6XlMIwqwF9NEfcedt8hyH5BjFHOjbsVPqCcv50aalLqvzt3T
DsoT6ILMHaGn9giD5xJo4EBPcQK6O6Pf3VZis7AInOd6ImKwzONVe4OdNS5rTV+k
Bj8GAW7xdudvcUfgL/VsUlu9mf3Wy45QWFs+/hCHZsO/tPKcUws1QyxKsy8zUPlB
7hSHZTkd8XQ3067Or00i0xlQM6wws+5HOvap03JC7nLDmvoi0e8yJaWWSKV6vJcu
r5ScSf8NlNN4HkV5peAoJx2r7zbPormucmA5NnKPr70LyGk4QXWKTycpWMyS6i++
0lWzJp3yBF4H7XnUme2eWBrKha+3qPbT3XDhCvClTWlGbViPUL4=
=Ycfi
-----END PGP SIGNATURE-----

--hwvH6HDNit2nSK4j--


