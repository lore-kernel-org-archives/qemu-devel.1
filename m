Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B617C4727D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 23:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7149723A65
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 23:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="emrcPolG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7149723A65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKVRL-00020v-BQ
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 19:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kKVPi-0001MQ-9a
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 19:40:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23296)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kKVPd-0003Bs-Ew
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 19:40:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600731599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=V7uD9pFvQiYa8D4k6MWYCP7sKoGF6WMWYhyrGFjF4vw=;
 b=emrcPolGdLKkv9r3ccakiB9adgGV5/SWaLlse93K/nNZk4XXCRypOPdCffaZYEQMzU21XV
 6XRSos+Jd2KDBGvZCesAcpjyf7abc0A8su3PytThuVC3dm9UJqgYsOjZ7fSPLKeqLfscrW
 XTj0b98yZeWNPePkmnQhyiVVzW9RWaM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-5qhzg20BOYSCXa6GJ5kKFg-1; Mon, 21 Sep 2020 19:39:55 -0400
X-MC-Unique: 5qhzg20BOYSCXa6GJ5kKFg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60B861005E5B;
 Mon, 21 Sep 2020 23:39:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F16E78808;
 Mon, 21 Sep 2020 23:39:53 +0000 (UTC)
Date: Mon, 21 Sep 2020 19:39:51 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 5/6] travis.yml: Update Travis to use Bionic and Focal
 instead of Xenial
Message-ID: <20200921233951.GC15763@localhost.localdomain>
References: <20200918103430.297167-1-thuth@redhat.com>
 <20200918103430.297167-6-thuth@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918103430.297167-6-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zCKi3GIZzVBPywwA"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--zCKi3GIZzVBPywwA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2020 at 12:34:29PM +0200, Thomas Huth wrote:
> According to our support policy, we do not support Xenial anymore.
> Time to switch the bigger parts of the builds to Focal instead.
> Some few jobs have to be updated to Bionic instead, since they are
> currently still failing on Focal otherwise. Also "--disable-pie" is
> causing linker problems with newer versions of Ubuntu ... so remove
> that switch from the jobs now (we still test it in a gitlab CI job,
> so we don't lose much test coverage here).
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  .travis.yml | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 1fc49b0746..80da4ebc8e 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -2,7 +2,7 @@
>  # Additional builds with specific requirements for a full VM need to
>  # be added as additional matrix: entries later on
>  os: linux
> -dist: xenial
> +dist: focal
>  language: c
>  compiler:
>    - gcc
> @@ -10,7 +10,7 @@ cache:
>    # There is one cache per branch and compiler version.
>    # characteristics of each job are used to identify the cache:
>    # - OS name (currently only linux)
> -  # - OS distribution (for Linux, xenial, trusty, or precise)
> +  # - OS distribution (for Linux, bionic or focal)
>    # - Names and values of visible environment variables set in .travis.y=
ml or Settings panel
>    timeout: 1200
>    ccache: true
> @@ -27,7 +27,7 @@ addons:
>        - libattr1-dev
>        - libbrlapi-dev
>        - libcap-ng-dev
> -      - libgcc-4.8-dev
> +      - libgcc-7-dev
>        - libgnutls28-dev
>        - libgtk-3-dev
>        - libiscsi-dev
> @@ -211,8 +211,10 @@ jobs:
> =20
>      # gprof/gcov are GCC features
>      - name: "GCC gprof/gcov"
> +      dist: bionic
>        env:
> -        - CONFIG=3D"--enable-gprof --enable-gcov --disable-pie --target-=
list=3D${MAIN_SOFTMMU_TARGETS}"
> +        - CONFIG=3D"--enable-gprof --enable-gcov --disable-libssh
> +                  --target-list=3D${MAIN_SOFTMMU_TARGETS}"

While the commit message describes the reason for dropping
'--disable-pie', it doesn't talk about why it adds '--disable-libssh'.
Other than that, it's working fine, according to:

  https://travis-ci.org/github/clebergnu/qemu/builds/729121964

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--zCKi3GIZzVBPywwA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9pOcUACgkQZX6NM6Xy
CfMrABAAzRzSB+XKMfmTlN3LR6dVN4Z1MybR8SFnXLODZ+Q5S2qjFHnsJzH6zYI5
1l3tMDar9nF3tiM8IgaiYn8EwSK8liL8iSWnj0QgMk3qUjhpr/kNlEhuMEt+N5dN
IPwkD03CSN+582Z8Wq5g6z8xg4D6YnQKno74zO0qHTNru6YGv97kiL/Q+YEXdU0g
2uzJ0J2KEuBFQypy3nTYYXsttc5IGlKow8OPo26d4H86ileAqy0zDrFQgSXr4gwd
ZODINK/h6DQq1GxwtH+0InDi5/7e32O/lEMtYt1Zt2X9kDrTkLDoqHDnALPKLv7i
a2Z/ktLA9Q4tT+hReMVRPzLN/6a1qPh1HDjXgFgcXm4EzrU+YNqafa93q82k1YpA
AocDEKP7vr/igR+dOQxuV70RI5VGV3tEW5BinEQ+XmqZw/m5hbGFfOURbJ34v0kS
IiESatCcM1ONAkQDEfqXhMdVcGcCuwt+sEpYELIsqJ15gApQYy8uWLVOu2sKMEeD
SvznZ38vAyPxj0qids/mCLqbVLZQj8Gz6EKtuUnGq55VmoXFkQRSmiNRWsYVC/Mw
0OV8c4pDyJdxeTNvbQ9j9IAKnUkv1H1kCyPPrEPnVGJdDFOVEHAlQ9YV1LohAeij
ZwgC6nhcf88mUP5QyMQbEEXjsCbMgiE6zH8A64CuPRdMutROSmY=
=lbu8
-----END PGP SIGNATURE-----

--zCKi3GIZzVBPywwA--


