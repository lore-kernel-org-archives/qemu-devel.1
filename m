Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD13BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 12:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6CA206B5
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 12:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="WYiTa5ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6CA206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k80mE-0006Rq-HG
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 08:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k80hd-0003ZR-1a; Tue, 18 Aug 2020 08:26:57 -0400
Received: from mout.web.de ([212.227.15.4]:33621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1k80ha-0002cF-CT; Tue, 18 Aug 2020 08:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1597753606;
 bh=Zgk2YWIiOH1Htm1ShKzM/kUPW/y3JY6T6OqiPDDGPAw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=WYiTa5badKNcWOZWnStncmgPcBgULl9+NbEhuUem18MJ6QOGRnmRoq/vDqFMNGbaZ
 tiS9RWHeencjIMnsQxFXDyIGGQTopefF5YPKlkU+UfGxFDtclOEjJdju9J5sOsUdMV
 8p8yv9EKiBJ7nky7+j1OXiEOW5zXHn+nyVf7KaaE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.107]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MD8RQ-1jtl6I2RK8-00GYWE; Tue, 18
 Aug 2020 14:26:46 +0200
Date: Tue, 18 Aug 2020 14:26:31 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: Re: [PATCH v7 0/8] Introduce 'yank' oob qmp command to recover from
 hanging qemu
Message-ID: <20200818142631.3e1c1481@luklap>
In-Reply-To: <cover.1596528468.git.lukasstraub2@web.de>
References: <cover.1596528468.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tOCVbpn=6/.JuG8VrsS0WRD";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:dcvDlUAfAUifmKrFBhaI30rODK9Il9RRPk7QCWjoGUZ5gSCx+jG
 0QsYJp3UGOW1vcjwvqc5HuegAJcfDxubZVkEFxRl8xHp1C+UY7iAQWHvycu3UJ42uQf6W6d
 Phx4ztSsJAaI2H36gKiTOCTlAxyh0IJ0DUiMevPqh3c0OshxYSXEnst4k8U9dJjvUwkCg4y
 DOx1SZ0ovOSEcbhQ0zlIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BN71A9kadec=:qLSncwTm6duZJZ+G2fZ6fg
 FikWIArpbme1Os8cLQneL9/6K0C4KpKXU9X5Op3cRmrAntROVyLznydGh0CCxjb0EpVJpfDNg
 NrWnwFYwKaRE+WRXrxOJSnlRJUe9CI27FRtzuui5UYW3jHexWOjPIQQLDzGl0Qnv8RBrlXujq
 AfP641g9nmT9BtB56DFUZTirLSsVfcl0baXw2T8WJK1NgGtksTf/Hpr8buT5jFXZX84iyzd0r
 +FQK3ijlsHf39wW8sbH54UUAy6UPxcWIpCtE7rAlw5aBK/APdrP86VcBz/5pPUMYV/wc0Fq32
 gRpCYFd8Wq7l64iGEvsJMx/emlVD4FIM9n6RSeywCxyNIKpb24pBXbkKRqHRSlBdicIUJA2/W
 K4opGWnSUQriOKPtdUrydfGhBfsK+ze3DmffsaIsmPBlVUX3A2EhRBAFPVS/1tTr1bN6dqZ6j
 ktuCjmwAj1zw8diEnVbb/Bhj5VYJdCu5JvFc7zBaswWjLbouxoqWg59Sj1ElDpGyVm7aqSDU3
 RB7bdIvax9FvXl1vkoaOpCSK+Ti6FCjmcyn8xCczlA895X3D1FhPLBHmRjfkGz9gyo8vq8w81
 jYRkYKzW7fnbwVh2JWT78Lg+DiwA6PaDEhbQuafCE5zXkRqcpS+p77zekT7cv7YedGSlL5vjq
 dHEYtH6qwb4ahXulYk0rCkggZBKnKUxBPZLnkY17Dcx4sqBiJAn181F2dUU5p9tFG9RR5ASYo
 dCsX7pboO9R2pSetAdCXhQLtenyEGnzUJSVrD5RFQANFrbf0UVnD7QyJqH0mCMUm/qpmTFLSN
 ri6sCga85CP1KWq7dkdQYZ/d0vf6avKDZmgpKpA7SpUsy5+9C1AwyACtcNQ+fWqdqcKsOKU5J
 MHqWoo3bS+oEMg+atOq32qU9o7MKhdOcrc488w0uu1HZ8vKprN1O3C0mfMGBmU2dHbU8vkpe0
 IVAkRCIQ1kt+J7ghGbNbTc0hOG3L8r2tyMTb+8kQW7a/sdC0AX83TgWvd8oRl54GaEk2dOg12
 Tjz3urjqMDM9qtQcMgGw07Xdnfot8cyEc99HuiofNI5cLuZ5Sg7utNvaa9gC49vXU1y1T9lUS
 qEhPKFNZeawvlyY2Xl05dfmQez/RisR7HSwPU0lX+5fVcHAIQgXsXGJX02xDIkO1IsK1iKsEk
 oyz2yxiD71z9eePuEg/ciaOjjE/VC6azSr+vZQk+D00s72c2pAe4PrqCfJHYwEBBumcIjKdDG
 p6yjaeUqKCV9paawRXaYYPOm/bXY7KgJiuGIOsg==
Received-SPF: pass client-ip=212.227.15.4; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 08:26:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan
 Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRy?= =?UTF-8?B?w6k=?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/tOCVbpn=6/.JuG8VrsS0WRD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Aug 2020 10:11:22 +0200
Lukas Straub <lukasstraub2@web.de> wrote:

> Hello Everyone,
> In many cases, if qemu has a network connection (qmp, migration, chardev,=
 etc.)
> to some other server and that server dies or hangs, qemu hangs too.
> These patches introduce the new 'yank' out-of-band qmp command to recover=
 from
> these kinds of hangs. The different subsystems register callbacks which g=
et
> executed with the yank command. For example the callback can shutdown() a
> socket. This is intended for the colo use-case, but it can be used for ot=
her
> things too of course.
>=20
> Regards,
> Lukas Straub
>=20
> v7:
>  -yank_register_instance now returns error via Error **errp instead of ab=
orting
>  -dropped "chardev/char.c: Check for duplicate id before  creating charde=
v"
>=20
> v6:
>  -add Reviewed-by and Acked-by tags
>  -rebase on master
>  -lots of changes in nbd due to rebase
>  -only take maintainership of util/yank.c and include/qemu/yank.h (Daniel=
 P. Berrang=C3=A9)
>  -fix a crash discovered by the newly added chardev test
>  -fix the test itself
>=20
> v5:
>  -move yank.c to util/
>  -move yank.h to include/qemu/
>  -add license to yank.h
>  -use const char*
>  -nbd: use atomic_store_release and atomic_load_aqcuire
>  -io-channel: ensure thread-safety and document it
>  -add myself as maintainer for yank
>=20
> v4:
>  -fix build errors...
>=20
> v3:
>  -don't touch softmmu/vl.c, use __contructor__ attribute instead (Paolo B=
onzini)
>  -fix build errors
>  -rewrite migration patch so it actually passes all tests
>=20
> v2:
>  -don't touch io/ code anymore
>  -always register yank functions
>  -'yank' now takes a list of instances to yank
>  -'query-yank' returns a list of yankable instances
>=20
> Lukas Straub (8):
>   Introduce yank feature
>   block/nbd.c: Add yank feature
>   chardev/char-socket.c: Add yank feature
>   migration: Add yank feature
>   io/channel-tls.c: make qio_channel_tls_shutdown thread-safe
>   io: Document thread-safety of qio_channel_shutdown
>   MAINTAINERS: Add myself as maintainer for yank feature
>   tests/test-char.c: Wait for the chardev to connect in
>     char_socket_client_dupid_test
>=20
>  MAINTAINERS                   |   6 ++
>  block/nbd.c                   | 129 +++++++++++++++---------
>  chardev/char-socket.c         |  31 ++++++
>  include/io/channel.h          |   2 +
>  include/qemu/yank.h           |  80 +++++++++++++++
>  io/channel-tls.c              |   6 +-
>  migration/channel.c           |  12 +++
>  migration/migration.c         |  25 ++++-
>  migration/multifd.c           |  10 ++
>  migration/qemu-file-channel.c |   6 ++
>  migration/savevm.c            |   6 ++
>  qapi/misc.json                |  45 +++++++++
>  tests/Makefile.include        |   2 +-
>  tests/test-char.c             |   1 +
>  util/Makefile.objs            |   1 +
>  util/yank.c                   | 184 ++++++++++++++++++++++++++++++++++
>  16 files changed, 493 insertions(+), 53 deletions(-)
>  create mode 100644 include/qemu/yank.h
>  create mode 100644 util/yank.c
>=20
> --
> 2.20.1

Ping...

--Sig_/tOCVbpn=6/.JuG8VrsS0WRD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl87yPcACgkQNasLKJxd
sliB+g//Y8O2uZdLWQVRS/knkAKB62Oh9jzyc3rymUH8mZMfdiRQEwLyxtiXU8rt
/n7nTcQckVmW9SoAD9/vzO6oWhwR7U/ZqLrrhG1pO8isCYrFhJTKWUPxakSZ+xNQ
ky66w1Rm+p19HecH7FrxY6JplKVmsFesAWG9nOHYDZh1bA+Ks8f2XGpo1HRxe+jI
SAI/3UQ6vRAeFG4auAm+i7MuSPRA1xvsJfzCDHG5MW79cl52XvJg1tUi5cA45QrC
4WX7AIUsSXiOc3J+D2nYwnloP0Dwhwz7HXx+12u22ZMYACJ1Tdn+V6lZYKijJLpW
kToRDiVy+z681/sd3L0s0ncmyANZlHoM6EmVHLNtxpk2tHWGBFV552JdT4wN68jE
PHP9JfB3c+xdaPSugtpLafooqLwwty65Lu/nBUDd7xkWPSgwR3pveCSWHUkD4lS8
m3jDq5VZ8Yh8oqOTNijAIEPBoCbrDkW0ncXL/BARkfbyNrT5R5m1zt+PKefTN8Oh
Lkr0MUKBZFF4nBljM4PV6EeHDc6J+XQgIyrPzG6NomMhbUBENASXqiDyfemDeevM
hBMnSA7XU55hfIELz3m5oPDUtAxfJSuG99nm2ablqnRJa/NQwKglIr7cJ+FSc0eK
+7YHKlcIKHL/mmuN9+LgL28piKbvzUZRnVyCOzKcHMBMCmh5Hq4=
=PKNE
-----END PGP SIGNATURE-----

--Sig_/tOCVbpn=6/.JuG8VrsS0WRD--

