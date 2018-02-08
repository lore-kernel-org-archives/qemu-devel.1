Received: from eggs.gnu.org ([2001:4830:134:3::10]:60149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejqJD-0001RR-Q4
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:48:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ejqJA-0006Fm-NI
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:48:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56120 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ejqJA-0006Eu-IN
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:48:28 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 210019BA98
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 17:48:28 +0000 (UTC)
References: <20180208162343.30809-1-marcandre.lureau@redhat.com>
	<20180208162343.30809-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <97c4fb0d-69a4-0957-e6c0-78a806361355@redhat.com>
Date: Thu, 8 Feb 2018 11:48:24 -0600
MIME-Version: 1.0
In-Reply-To: <20180208162343.30809-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] build-sys: check static linking of
 UBSAN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

On 02/08/2018 10:23 AM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   configure | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index 41d8a2666c..beb0de6a77 100755
> --- a/configure
> +++ b/configure
> @@ -5247,7 +5247,15 @@ fi
>   ##########################################
>   # checks for sanitizers
>  =20
> -write_c_skeleton
> +# we could use a simple skeleton for flags chekcs, but this also

s/chekcs/checks/

> +# detect the static linking issue of ubsan, see also:
> +# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D84285
> +cat > $TMPC << EOF
> +#include <stdint.h>
> +int main(void) {
> +  return INT32_MIN / -1;
> +}
> +EOF
>  =20
>   have_asan=3Dno
>   have_ubsan=3Dno
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
