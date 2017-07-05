Received: from eggs.gnu.org ([2001:4830:134:3::10]:47825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dSY97-0004mp-7g
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 20:26:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dSY94-00008w-3b
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 20:26:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dSY93-00007o-TT
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 20:26:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5D393B703
	for <qemu-devel@nongnu.org>; Wed,  5 Jul 2017 00:26:16 +0000 (UTC)
References: <20170629132310.18865-1-marcandre.lureau@redhat.com>
	<20170629132310.18865-8-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <646ec17e-4baa-66b9-f54b-0ca840303fe6@redhat.com>
Date: Wed, 5 Jul 2017 02:26:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170629132310.18865-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 7/7] MAINTAINERS: add Dump maintainers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, anderson@redhat.com, imammedo@redhat.com

On 06/29/17 15:23, Marc-Andr=C3=A9 Lureau wrote:
> Proposing myself, since I have some familiarity with the code now.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 839f7ca063..45a0eb4cb0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1272,6 +1272,13 @@ S: Maintained
>  F: device_tree.c
>  F: include/sysemu/device_tree.h
> =20
> +Dump
> +S: Supported
> +M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> +F: dump.c
> +F: include/sysemu/dump.h
> +F: include/sysemu/dump-arch.h
> +
>  Error reporting
>  M: Markus Armbruster <armbru@redhat.com>
>  S: Supported
>=20

That's very kind of you, thanks!

Do you have suggestions for the following files?

scripts/dump-guest-memory.py
stubs/dump.c
target/arm/arch_dump.c
target/i386/arch_dump.c
target/ppc/arch_dump.c
target/s390x/arch_dump.c

(If not, I'm OK with that too.)

Thanks!
Laszlo
