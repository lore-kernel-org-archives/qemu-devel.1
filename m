Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C58AC04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 14:33:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2519C21721
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 14:33:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2519C21721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46704 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVGh5-00067M-95
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 10:33:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hVGg9-0005na-EE
	for qemu-devel@nongnu.org; Mon, 27 May 2019 10:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hVGg7-0002js-V6
	for qemu-devel@nongnu.org; Mon, 27 May 2019 10:32:45 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:37492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hVGg6-0002ei-SE
	for qemu-devel@nongnu.org; Mon, 27 May 2019 10:32:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by hera.aquilenet.fr (Postfix) with ESMTP id 2D5322D49;
	Mon, 27 May 2019 16:32:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
	by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 80kSvgzD4XaH; Mon, 27 May 2019 16:32:33 +0200 (CEST)
Received: from function (dhcp-13-80.lip.ens-lyon.fr [140.77.13.80])
	by hera.aquilenet.fr (Postfix) with ESMTPSA id 554582C35;
	Mon, 27 May 2019 16:32:33 +0200 (CEST)
Received: from samy by function with local (Exim 4.92)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hVGfw-0005II-MI; Mon, 27 May 2019 16:32:32 +0200
Date: Mon, 27 May 2019 16:32:32 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190527143232.or3uubdw3edezba2@function>
References: <20190527142540.23255-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190527142540.23255-1-mreitz@redhat.com>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a0c:e300::1
Subject: Re: [Qemu-devel] [PATCH] ui/curses: Fix build with -m32
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Max Reitz, le lun. 27 mai 2019 16:25:40 +0200, a ecrit:
> wchar_t may resolve to be an unsigned long on 32-bit architectures.
> Using the %x conversion specifier will then give a compiler warning:
>=20
> ui/curses.c: In function =E2=80=98get_ucs=E2=80=99:
> ui/curses.c:492:49: error: format =E2=80=98%x=E2=80=99 expects argument=
 of type =E2=80=98unsigned int=E2=80=99, but argument 3 has type =E2=80=98=
wchar_t=E2=80=99 {aka =E2=80=98long int=E2=80=99} [-Werror=3Dformat=3D]
>   492 |         fprintf(stderr, "Could not convert 0x%04x "
>       |                                              ~~~^
>       |                                                 |
>       |                                                 unsigned int
>       |                                              %04lx
>   493 |                         "from wchar_t to a multibyte character:=
 %s\n",
>   494 |                         wch, strerror(errno));
>       |                         ~~~
>       |                         |
>       |                         wchar_t {aka long int}
> ui/curses.c:504:49: error: format =E2=80=98%x=E2=80=99 expects argument=
 of type =E2=80=98unsigned int=E2=80=99, but argument 3 has type =E2=80=98=
wchar_t=E2=80=99 {aka =E2=80=98long int=E2=80=99} [-Werror=3Dformat=3D]
>   504 |         fprintf(stderr, "Could not convert 0x%04x "
>       |                                              ~~~^
>       |                                                 |
>       |                                                 unsigned int
>       |                                              %04lx
>   505 |                         "from a multibyte character to UCS-2 : =
%s\n",
>   506 |                         wch, strerror(errno));
>       |                         ~~~
>       |                         |
>       |                         wchar_t {aka long int}
>=20
> Fix this by casting the wchar_t value to an unsigned long and using %lx
> as the conversion specifier.
>=20
> Fixes: b7b664a4fe9a955338f2e11a0f7433b29c8cbad0
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

> ---
>  ui/curses.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/ui/curses.c b/ui/curses.c
> index 1f3fcabb00..e9319eb8ae 100644
> --- a/ui/curses.c
> +++ b/ui/curses.c
> @@ -489,9 +489,9 @@ static uint16_t get_ucs(wchar_t wch, iconv_t conv)
>      memset(&ps, 0, sizeof(ps));
>      ret =3D wcrtomb(mbch, wch, &ps);
>      if (ret =3D=3D -1) {
> -        fprintf(stderr, "Could not convert 0x%04x "
> +        fprintf(stderr, "Could not convert 0x%04lx "
>                          "from wchar_t to a multibyte character: %s\n",
> -                        wch, strerror(errno));
> +                        (unsigned long)wch, strerror(errno));
>          return 0xFFFD;
>      }
> =20
> @@ -501,9 +501,9 @@ static uint16_t get_ucs(wchar_t wch, iconv_t conv)
>      such =3D sizeof(uch);
> =20
>      if (iconv(conv, &pmbch, &smbch, &puch, &such) =3D=3D (size_t) -1) =
{
> -        fprintf(stderr, "Could not convert 0x%04x "
> +        fprintf(stderr, "Could not convert 0x%04lx "
>                          "from a multibyte character to UCS-2 : %s\n",
> -                        wch, strerror(errno));
> +                        (unsigned long)wch, strerror(errno));
>          return 0xFFFD;
>      }
> =20
> --=20
> 2.21.0
>=20
>=20

--=20
Samuel
/*
 * [...] Note that 120 sec is defined in the protocol as the maximum
 * possible RTT.  I guess we'll have to use something other than TCP
 * to talk to the University of Mars.
 * PAWS allows us longer timeouts and large windows, so once implemented
 * ftp to mars will work nicely.
 */
(from /usr/src/linux/net/inet/tcp.c, concerning RTT [retransmission timeo=
ut])

