Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE9FC433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F442224E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Caui0QiB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F442224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSnk1-0002PH-Dz
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 16:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kSnil-0001Yf-N9
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:50:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kSnij-0004GF-Ax
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602708597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hiHLSh0wALJlg1vFSwcwDzYHnL6eQ/uuv2O6+1qPve8=;
 b=Caui0QiBVQIbNCaF/hF5qrO4dDbvxmfYyewcGVP1GMcMtq1ziFceNskZe47W3P+AxSq/4a
 jvF5YD3FNk4YjuWtMNavi0knTf9IQLSJ2V+TjDqWRrEaZyYIySsg0Rf6mU22Ww/7tbCBXv
 N2nx9u9pTccz4+Jxo6BHnUprC7fCDn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-OuWtbUNoM1eK2iDw2ek5xA-1; Wed, 14 Oct 2020 16:49:53 -0400
X-MC-Unique: OuWtbUNoM1eK2iDw2ek5xA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7438E18A0764;
 Wed, 14 Oct 2020 20:49:52 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B7A4173665;
 Wed, 14 Oct 2020 20:49:51 +0000 (UTC)
Date: Wed, 14 Oct 2020 16:49:50 -0400
From: Cleber Rosa <crosa@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5/7] dockerfiles: enable Centos 8 PowerTools
Message-ID: <20201014204950.GA1203215@localhost.localdomain>
References: <20201014135416.1290679-1-pbonzini@redhat.com>
 <20201014135416.1290679-6-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201014135416.1290679-6-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: alex.bennee@linaro.org, berrange@redhat.com, qemu-devel@nongnu.org,
 peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2020 at 09:54:14AM -0400, Paolo Bonzini wrote:
> ninja is included in the CentOS PowerTools repository.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/docker/dockerfiles/centos8.docker | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/docke=
rfiles/centos8.docker
> index 0fc2697491..e31d366fc1 100644
> --- a/tests/docker/dockerfiles/centos8.docker
> +++ b/tests/docker/dockerfiles/centos8.docker
> @@ -1,6 +1,9 @@
>  FROM centos:8.1.1911
> =20
> +RUN dnf -y install dnf-plugins-core
> +RUN dnf config-manager --set-enabled PowerTools

Since config-manager won't be used besides here, I think it's safe and
cheaper to simply do:

   RUN sed -i /etc/yum.repos.d/CentOS-PowerTools.repo -e 's/^enabled=3D0/en=
abled=3D1/'

It's also a single command, reducing the number of layers.

- Cleber.

>  RUN dnf -y update
> +
>  ENV PACKAGES \
>      SDL-devel \
>      bzip2 \
> --=20
> 2.26.2
>=20
>=20
>=20

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl+HZFoACgkQZX6NM6Xy
CfOmlxAApp/XGN9yKZy6xdpGLIvECdqPTnK6s4/7s0ZhXpwfpOPgZM2P+Gpc6a1+
kYBW0Mc0A8T6Gla4dnj1vshUnAf2KnayGs94GbrATpPVqVnL0Be6Fjyb2kHWskHr
x9nI+4K0/ZaWKTUaBMz64lySiyJJB/HhMF2rgxvwty7L3wKKGiOVYY8U7BA6RROo
YNC281MnApVpYJHqcy1dgrN+5m8b681PG40Iz8pvQwDhIpKQ4rUWslKkTusJXsG5
w8E2zNezA7f3X9KNvKua6aK0yF3fz1ppixp7kItNCDHXnghAuSaojzFbFVzOitUo
RiI5o9mgWANzTgEXhx6kNcZjZrnDU69d3ONN3I5nG/78RD8IMaYRIsc335Bz3Q73
lFLtQBh9msx2yYnEflc0UVTp89d9gngZaRlAcqu3Uc0FQBBwF3Vcy1Ly/mMCaXvx
/h/Bw5excCwgHpcO4cbWOU7ebvBb4XD96tYvUqxPUsH4NRSv2jaTwhhW3/eFumeI
fohjTjJnyh/mkNfb4zbhjUo1svgwFSGFPTtaHHPktyBpzemvfUnVYW7DWPdOBj8V
z9i0UEEOi5+IMlT7SmajekbFb+FeEk3R3VFZekOCD2MetVOmIOrHap0rCIIYIYWQ
Kesh9RO0wRMdrUfHLIrh6ppNjpyw7/fdrkux7/OMLC2gtAM514M=
=MX2m
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--


