Received: from eggs.gnu.org ([2001:4830:134:3::10]:50558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dTAMH-0002TY-0Q
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:14:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dTAMD-0008O4-QO
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:14:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dTAMD-0008NT-KC
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 13:14:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7FD561D10
	for <qemu-devel@nongnu.org>; Thu,  6 Jul 2017 17:14:24 +0000 (UTC)
References: <20170706101611.27031-1-marcandre.lureau@redhat.com>
	<20170706101611.27031-8-marcandre.lureau@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <d493e444-84a4-20e8-d016-55615910da97@redhat.com>
Date: Thu, 6 Jul 2017 19:14:20 +0200
MIME-Version: 1.0
In-Reply-To: <20170706101611.27031-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 7/7] MAINTAINERS: add Dump maintainers
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

On 07/06/17 12:16, Marc-Andr=C3=A9 Lureau wrote:
> Proposing myself, since I have some familiarity with the code now.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 839f7ca063..ba17ce5b85 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1272,6 +1272,15 @@ S: Maintained
>  F: device_tree.c
>  F: include/sysemu/device_tree.h
> =20
> +Dump
> +S: Supported
> +M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> +F: dump.c
> +F: stubs/dump.c
> +F: include/sysemu/dump.h
> +F: include/sysemu/dump-arch.h
> +F: scripts/dump-guest-memory.py
> +
>  Error reporting
>  M: Markus Armbruster <armbru@redhat.com>
>  S: Supported
>=20

Acked-by: Laszlo Ersek <lersek@redhat.com>
