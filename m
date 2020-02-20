Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61681C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F30962071E
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 15:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzF4tN7e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F30962071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4nzd-0007Mf-2d
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 10:44:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1j4nz1-0006v1-R6
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:43:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1j4nz0-0002Z4-Ix
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:43:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57255
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1j4nz0-0002YG-Dq
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 10:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582213401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hRy6+GDKEj/DWNPJ8TGV956O3cBbUc6YtWUspyeF56Q=;
 b=BzF4tN7esbalakv/WAEeCRWG3fMhatpVYkjIly3OA6laGKMvBlSWVx05dy5r+h00M8NIUK
 knqCYserxPcguAuJY9xoUrSM9HotHTi29P/YdTVcqx2kv4wssiKDxlSjmB8cSbQ6jj5d35
 xTr+iQ/ow5BsUDjGgHhf5ry62Ui+S6A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-xp6zZo8oNiahh7a09abiDg-1; Thu, 20 Feb 2020 10:43:17 -0500
X-MC-Unique: xp6zZo8oNiahh7a09abiDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 439E01B18BC8;
 Thu, 20 Feb 2020 15:43:16 +0000 (UTC)
Received: from dhcp-17-202.bos.redhat.com (dhcp-17-202.bos.redhat.com
 [10.18.17.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D34419756;
 Thu, 20 Feb 2020 15:43:10 +0000 (UTC)
Date: Thu, 20 Feb 2020 10:43:08 -0500
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v9 0/3] Acceptance test: Add "boot_linux" acceptance test
Message-ID: <20200220154308.GA6678@dhcp-17-202.bos.redhat.com>
References: <20200220020652.16276-1-crosa@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200220020652.16276-1-crosa@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Willian Rampazzo <wrampazz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2020 at 09:06:49PM -0500, Cleber Rosa wrote:
>=20
> Changes from v8:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>

...

> * Bumped pycdlib version to 1.9.0, which contains an endianess bug that
>   was seen on s390x hosts.

I meant, "which contains a bug *fix*". Hopefully not introducing bugs on
purpose! :)

- Cleber.

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl5OqQkACgkQZX6NM6Xy
CfP82hAAjz0KPzUFq+ZlDUyIMrnql9YTN70bwxSbGHtRRjjr2RRPcPEdgo2TDBBr
Ohflg2qQA9TqrL+OTcY7fRdFZe23v15W7S6ERNNiiRoYoB1hE5R8atLblUYOMagE
wWZ/t8Q18bAmzVedWNLzMujQ8YgMuETq0goanwVVyW79PdfW8XNrNQh22JSFxkO+
V556tF8fOhep+Kg39oHQA5g0s8aITaeq0ocfxmZdeOKp2vdiyVS6AKG+SDduYH9l
9mRGaPBZS8gyqEmW8kB12w6fEyfYX2ZOyOaT11bpd7GUHEFaW/OkSlnVDKXLXSxn
PB1pvx9Y/qH2rcOMp8VkPZDPKXpVYzBqHymdd/v0n9ep6SO/Wgzpu3KyCGsZ2TCx
6j02og3vs2hTadIcgAs9jo33dqbGzWMx5u1ScQ2Az+IX19KwiI5WUj7bLAaSn1mS
GaVSEZhCrNX9coxgqNGzFmM0QfIziBjS14zugLtM2aYmLBqesR1IORajHqDVxEve
nuKuAuTlL50IsqfkmXFGkc5QLiWbywECl5UKsASDhOpni767KD3AyPaxwKzK/MD/
iBbPgZKsorHWcZZQgMSXpqTbDaT4u1XA9zL0pM9XHKd7NCR4WudzxCRTwZUkemsp
N7ce9FxDD2f/TNwbt8PaPgh56BFCIbuWSI9IdSGj1glUUXL/sUw=
=GOzx
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--


