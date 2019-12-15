Return-Path: <SRS0=VgCP=2F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05ECC43603
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 20:25:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A8924676
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2019 20:25:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DNCsL/qZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A8924676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igaSf-0000u6-G5
	for qemu-devel@archiver.kernel.org; Sun, 15 Dec 2019 15:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1igaRn-0000ND-NE
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 15:25:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1igaRj-0003dO-Ly
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 15:24:56 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:32562
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1igaRj-0003Zf-6Y
 for qemu-devel@nongnu.org; Sun, 15 Dec 2019 15:24:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576441494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=454+n0pfDG1aIcSrabigM9lO+gn8zKj5LoY21vyTmKk=;
 b=DNCsL/qZT3QWOJIGxtZnvyIscBNNMJDHDUxMAUMrChxP+uvsAixTbQqjhAd8hFXyMJLw7s
 ct9vZMLoSKRucngyhLme9hpASADhTKNrbRMvw8xg0gMYgqhjbHK7aRfESFJQuBaPsS9tk7
 39+Ms+jHhUr2JNcISBbaEbGkXdr38vA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-_j6O3ZQoNV6HTHzXI_nlxA-1; Sun, 15 Dec 2019 15:24:50 -0500
X-MC-Unique: _j6O3ZQoNV6HTHzXI_nlxA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F3218017DF;
 Sun, 15 Dec 2019 20:24:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-5.gru2.redhat.com [10.97.116.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EA9160BF4;
 Sun, 15 Dec 2019 20:24:40 +0000 (UTC)
Date: Sun, 15 Dec 2019 15:24:37 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH v3 1/5] python/qemu: Move kvm_available() to its own module
Message-ID: <20191215202437.GC22814@localhost.localdomain>
References: <20191212125831.2654-1-wainersm@redhat.com>
 <20191212125831.2654-2-wainersm@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191212125831.2654-2-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TiqCXmo5T1hvSQQg"
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

--TiqCXmo5T1hvSQQg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2019 at 07:58:27AM -0500, Wainer dos Santos Moschetta wrote=
:
> This creates the 'accel' Python module to be the home for
> utilities that deal with accelerators. Also moved kvm_available()
> from __init__.py to this new module.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--TiqCXmo5T1hvSQQg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl32loIACgkQZX6NM6Xy
CfMkdxAAjuY7K9UjSjPJd7J9RIsgFZJLR9WtSTMGHRfxl3b65P6zXu0hP2XvuXAQ
nt1kYIpyTfEf5FD4BTSV7Lb/GqjawUIZcGxGfgD/ms/81j+zbma2QfSkBd4LwQgM
SMdVG9bpRsrA84+RRma7MqzdCbFnetQGW4GRhz8reW/G+e9XAJhuUmHeVNidBTGw
cEYy1EMIXGchDBADzLkkwVOJAwQ4JaHQbxvDzPXOjtAPsEWgD3YkQgkvBECpK2+R
zE3y6YkslNNtGkk36RW9rjZL/aifXAKpbIO3hhNp7Qc5M3gC6bOYIHdVQKkmpyG1
GJQNCt9zOjcpQNQKjFM+ossKpE9Dnmy2J08A850pVuO6akMbJ7u1sUhi9X/Sofqz
JAESrFD0lkJI+wxZqahMt6swG7oME3toIFP8uQ+/yiSSTFSZeeYh3mjkdHRTI9ID
kuGdqjyl0USy82Bwhf4paNCZkGHUjjT2x0WMJKIRr1mdtUmtorE8Zg4/t0qfxXnQ
U6VkrZwEEeapuHNA/zlCB2xIrdoube+bnm7x89lqSFLvs0iO0qEMSLjQuna/G8Uc
Wu4KZHucmpI4kMKOmxcQehu446LaH8rALmqgSU9Hx/er2EhF7bNrD/KvQv9cRNJX
+z7piFz3ygdyPEEjOFnyI8p0MAhsqPERSzhw0j+AdEnQoBfeKXk=
=GrH/
-----END PGP SIGNATURE-----

--TiqCXmo5T1hvSQQg--


