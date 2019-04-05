Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D79C282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 21:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D3F72173C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 21:26:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3F72173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47094 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCWM0-0006Zp-Jn
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 17:26:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hCWLC-0005mX-Ub
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 17:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hCWL7-0001s6-V7
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 17:25:36 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:35316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hCWL3-0001ZG-FD
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 17:25:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by hera.aquilenet.fr (Postfix) with ESMTP id 9F9BA87AA;
	Fri,  5 Apr 2019 23:25:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
	by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Eljn5EFYaEb3; Fri,  5 Apr 2019 23:25:03 +0200 (CEST)
Received: from function (105.251.129.77.rev.sfr.net [77.129.251.105])
	by hera.aquilenet.fr (Postfix) with ESMTPSA id E998786FF;
	Fri,  5 Apr 2019 23:25:02 +0200 (CEST)
Received: from samy by function with local (Exim 4.92)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hCWKb-0006vp-Tj; Fri, 05 Apr 2019 23:25:01 +0200
Date: Fri, 5 Apr 2019 23:25:01 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Message-ID: <20190405212501.cdg4u3m7ihldcop4@function>
References: <20190405184648.17029-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190405184648.17029-1-dgilbert@redhat.com>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 185.233.100.1
Subject: Re: [Qemu-devel] [PATCH] slirp: Gcc 9 -O3 fix
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jan.kiszka@siemens.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405212501.ZqEzJgHqfROwzSxXe0DSVYp9F5Guq4GySbS1itu9RWc@z>

Hello,

Dr. David Alan Gilbert (git), le ven. 05 avril 2019 19:46:48 +0100, a ecr=
it:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> Gcc 9 needs some convincing that sopreprbuf really is going to fill
> in iov in the call from soreadbuf, even though the failure case
> shouldn't happen; so swing the check around initialising the fields.

While I can understand that setting iov[0].iov_len may help a compiler,
I don't see why moving if (len <=3D 0) return 0; down?

> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  slirp/src/socket.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/slirp/src/socket.c b/slirp/src/socket.c
> index 4a3c935e25..4a2222a95f 100644
> --- a/slirp/src/socket.c
> +++ b/slirp/src/socket.c
> @@ -113,12 +113,14 @@ size_t sopreprbuf(struct socket *so, struct iovec=
 *iov, int *np)
>  	DEBUG_CALL("sopreprbuf");
>  	DEBUG_ARG("so =3D %p", so);
> =20
> -	if (len <=3D 0)
> -		return 0;
> -
>  	iov[0].iov_base =3D sb->sb_wptr;
> +        iov[0].iov_len =3D 0;
>          iov[1].iov_base =3D NULL;
>          iov[1].iov_len =3D 0;
> +
> +	if (len <=3D 0)
> +		return 0;
> +
>  	if (sb->sb_wptr < sb->sb_rptr) {
>  		iov[0].iov_len =3D sb->sb_rptr - sb->sb_wptr;
>  		/* Should never succeed, but... */
> --=20
> 2.21.0
>=20

--=20
Samuel
 FYLG> Tiens, vl=C3=A0 une URL qui va bien :
 FYLG> ftp://127.0.0.1/WaReZ/NiouZeS/WinDoZe/NeWSMoNGeR/SuPeR
 c'est gentil sauf que l'adresse ne fonctionne pas sa me fais une erreur
 -+- Furtif in Guide du Neuneu Usenet : <MODE CERVEAU OFF> -+-

