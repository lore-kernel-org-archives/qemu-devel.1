Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A38DC2D0A8
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 03:41:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C630207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 03:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qg3soD1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C630207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN6Vh-0003Jv-C2
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 23:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN6Uh-0002Oo-7N
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 23:39:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31329)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kN6Ud-0002uB-Kp
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 23:39:57 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601350793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zi/nKKQAcWDtXmo7FqYqidOpbLbHHgf52/XLjK9L0es=;
 b=Qg3soD1/x7p+Y/dn4MP1zr4/j7c9BJM1vO+lV2cezTsK7iy9BxT+fZCovKl8vTvtRunGXI
 C6cUmratgoPfKWPQHl4ddqzLBvg5MKUS2X4zWaepFbswiWEQpQbv0KI1cFBNMxjrtiKtwH
 owe/8hSYVcP/LpIN7StUA0WNnkiUlhY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-k0iKCq3-Ndea8inv4bZEnw-1; Mon, 28 Sep 2020 23:39:50 -0400
X-MC-Unique: k0iKCq3-Ndea8inv4bZEnw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3C59802B47
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 03:39:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B05D65D9CA;
 Tue, 29 Sep 2020 03:39:48 +0000 (UTC)
Date: Mon, 28 Sep 2020 23:39:46 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v3 04/47] qapi: modify docstrings to be sphinx-compatible
Message-ID: <20200929033946.GE700868@localhost.localdomain>
References: <20200925002900.465855-1-jsnow@redhat.com>
 <20200925002900.465855-5-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200925002900.465855-5-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="84ND8YJRMFlzkrP4"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 23:30:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--84ND8YJRMFlzkrP4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2020 at 08:28:17PM -0400, John Snow wrote:
> I did not say "sphinx beautiful", just "sphinx compatible". They will
> not throw errors when parsed and interpreted as ReST.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/doc.py    | 10 +++++-----
>  scripts/qapi/gen.py    |  6 ++++--
>  scripts/qapi/parser.py |  9 +++++----
>  3 files changed, 14 insertions(+), 11 deletions(-)
>=20
> diff --git a/scripts/qapi/doc.py b/scripts/qapi/doc.py
> index 92f584edcf..c41e9d29f5 100644
> --- a/scripts/qapi/doc.py
> +++ b/scripts/qapi/doc.py
> @@ -65,11 +65,11 @@ def texi_format(doc):
>      Format documentation
> =20
>      Lines starting with:
> -    - |: generates an @example
> -    - =3D: generates @section
> -    - =3D=3D: generates @subsection
> -    - 1. or 1): generates an @enumerate @item
> -    - */-: generates an @itemize list
> +    - ``|:`` generates an @example
> +    - ``=3D:`` generates @section
> +    - ``=3D=3D:`` generates @subsection
> +    - ``1.`` or ``1):`` generates an @enumerate @item
> +    - ``*/-:`` generates an @itemize list
>      """
>      ret =3D ''
>      doc =3D subst_braces(doc)
> diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
> index bf5552a4e7..3d25a8cff4 100644
> --- a/scripts/qapi/gen.py
> +++ b/scripts/qapi/gen.py
> @@ -154,9 +154,11 @@ def _bottom(self):
> =20
>  @contextmanager
>  def ifcontext(ifcond, *args):
> -    """A 'with' statement context manager to wrap with start_if()/end_if=
()
> +    """
> +    A 'with' statement context manager to wrap with start_if()/end_if()
> =20

If you're making it compatible, why not take the time to give
backticks to start_if and end_if?

Bonus points for setting the "meth" role, but not lost points for not
doing it, as I understand this is beyond what you're attempting at
this time.

> -    *args: any number of QAPIGenCCode
> +    :param ifcond: List of conditionals
> +    :param args: any number of QAPIGenCCode
> =20

I would argue that this is not a strict sphinx compatibility change,
but a fix to a broken docstring.

- Cleber.

--84ND8YJRMFlzkrP4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9yrIAACgkQZX6NM6Xy
CfNodA/+JClgkumUHvUrFLpx+MrS5i2N4KZpkQF1MN2D3nLkp1pA1DFiP6WGo01P
Ekl8k9TJysWY3523kRH9Hqp9VuVy3CNGxT4z7kJA7KSLRe/Nh26jo8VTLf2n2ZRQ
CONGL/JkJ11DrqmWVnjVAuGiBsX6DZwaJZZgmb7nDamLUkoGxKrFvOYVSiPGaxCB
49Otbe/6QLWfp2lyA/Bvt9t0pFL7TC9s/VO8yeb6thA2JGJP26d6pgOdpN/Oxmsw
/9sUH8sZ9bx8nH3vl6lNRMf0LBJWweNzBqNCxiWMDW47ouUta8J6SjUxcnKt6Hu7
FK4kBQjFZdZrHK6EOQLIBEjRlFUW5Fs0r9fY02wYbRlH5r2ZZ2JbH06rV+StzaoJ
AtAlmlRc9wnqpSMJCzZjodZTs/fmqBptTb/iMvdYiZbZvYuWFd8/kgeZG32LC+93
TSjH6ltzGz3EkfGN9DNGbKYB9NC0AZ1s7o24wzZtTyH/X5GkTDhTkjlVSfcuj0Y0
O9epyOKodUJmsw61Vvl1lwc6+i/XYuIaN5FLC/O+mcA8a1geRfIdcXWeHaoZTVwZ
rijUqo/PuD5HiwfTzAOSu26XHVIU8CBccmuXX3vgGv/k7Crqo9GT9K3y9wWEZLwP
eiLKFIG60AYgWnOQFHOs84/kfXRXzUz2YPQL5cSo/3DhN/0At4U=
=cYs1
-----END PGP SIGNATURE-----

--84ND8YJRMFlzkrP4--


