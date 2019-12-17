Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C767C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 10:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49BD320717
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 10:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwEtO0uv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BD320717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihACv-0001EI-F0
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 05:36:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ihACI-0000hx-EK
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 05:35:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ihACG-0007Zr-7Q
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 05:35:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52916
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ihACF-0007YT-Mt
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 05:35:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576578918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+mchDPGKuVz25Sj1QUyFdMAi9DRB/iI2JTClmINdtGA=;
 b=YwEtO0uvw0tgN6TUpyUkwZe+g4w/GIoy0tz1TGcRwg5M4GH6lFRo+ZTuaqSbHXZ9auPPoD
 ZUcXHvfinILUnlTNqKE3WVXOKrfUo0bn1ABW9T3uK4YgNqYdzYC6z3WYIzT77dJu4FHRSK
 fP6e5hIyZ6CwoLSzzoKk4udEr4DGowo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-pT5spJt-MquSCSjOI5N38Q-1; Tue, 17 Dec 2019 05:35:14 -0500
X-MC-Unique: pT5spJt-MquSCSjOI5N38Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F90F102CE15;
 Tue, 17 Dec 2019 10:35:13 +0000 (UTC)
Received: from localhost (ovpn-117-244.ams2.redhat.com [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C174151;
 Tue, 17 Dec 2019 10:35:12 +0000 (UTC)
Date: Tue, 17 Dec 2019 10:35:11 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: qemu-project git server not utf-8 clean?
Message-ID: <20191217103511.GC1267701@stefanha-x1.localdomain>
References: <87k16ww7wl.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87k16ww7wl.fsf@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
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
Cc: jeff@codyprime.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2019 at 04:29:46PM +0000, Alex Benn=E9e wrote:
>=20
> Hi,
>=20
> I was doing some housekeeping of the wiki links into the docs page and I
> discovered my name getting corrupted for:
>=20
>   https://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3Ddocs/devel/tcg-pl=
ugins.rst;hb=3DHEAD
>=20
> Looking at the headers:
>=20
>   HTTP/1.1 200 OK
>   Date: Mon, 16 Dec 2019 16:24:50 GMT
>   Server: Apache/2.4.6 (CentOS) OpenSSL/1.0.2k-fips PHP/5.4.16
>   Content-disposition: inline; filename=3D"docs/devel/tcg-plugins.rst"
>   Keep-Alive: timeout=3D5, max=3D100
>   Connection: Keep-Alive
>   Transfer-Encoding: chunked
>   Content-Type: text/plain; charset=3DISO-8859-1
>=20
> Shouldn't we (Apache/gitweb?) be passing UTF-8 contents?

Strange, apache is configured to use UTF-8 by default and the gitweb
documentation indicates the web server default charset is used.

Anyway, it is fixed now.  I forced gitweb's charset by changing
/etc/gitweb.conf.

Stefan

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl34r18ACgkQnKSrs4Gr
c8jgkAf5AV9PM8l8om7vyIDy6FYQjuYHnxjEhperPToVs7BiElSgdMX3Y4B8NNX5
fuySc8Hrj6ttRdHykiBJmk1fTyO9W/5j20FHaJz3ehRa6gfTTQO0J8TMCz/t8jM3
zdjJNZvghVko8ZNJeJRwZJOtrpa3et9jKiKg4V+z1b1mZFEslHw1EjwGRczF+txv
nlJebCRTHnFkwWNjQP+bWBzn3X9qwKmzGoXWyOKt0sKtucFxcjeRLLMjaLVVRSsh
msgfyTOvA7h72mhHFVon/AguWNN9EYd3Zog2Slnt+N6svRBQHkoyeFXaCwks+1FZ
z4ZmzKfgwPuX18j1Lk+fAQGyPF9Xdg==
=/A10
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--


