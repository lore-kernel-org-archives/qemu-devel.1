Received: from eggs.gnu.org ([2001:4830:134:3::10]:59647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejqHm-0000Pw-GZ
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ejqHj-0004y7-F5
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:47:02 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50580 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ejqHj-0004x1-AU
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 12:46:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42F124084FF2
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 17:46:58 +0000 (UTC)
References: <20180208162343.30809-1-marcandre.lureau@redhat.com>
	<20180208162343.30809-3-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8be47d97-4a09-eb4f-0ee2-624404b43100@redhat.com>
Date: Thu, 8 Feb 2018 18:46:56 +0100
MIME-Version: 1.0
In-Reply-To: <20180208162343.30809-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] build-sys: enable sanitizers by
 default with --enable-debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

On 08/02/2018 17:23, Marc-Andr=C3=A9 Lureau wrote:
> The original commit 247724cb302af5d70c8853154b640dfabf2bbb56 was meant
> to enable sanitizers by default when --enable-debug, but failed
> because of a gcc static linking bug. Try to enable it back now that
> there is a stronger check.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

I'm more afraid that there are quite a few reports from sanitizers.  I
wonder if that makes --enable-debug unusable; as a non-user of
--enable-debug I'm a bit wary of pushing this patch.

I've queued 1 and 2 though.

Paolo

> ---
>  configure | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/configure b/configure
> index beb0de6a77..700ff35383 100755
> --- a/configure
> +++ b/configure
> @@ -355,7 +355,7 @@ rdma=3D""
>  gprof=3D"no"
>  debug_tcg=3D"no"
>  debug=3D"no"
> -sanitizers=3D"no"
> +sanitizers=3D""
>  fortify_source=3D""
>  strip_opt=3D"yes"
>  tcg_interpreter=3D"no"
> @@ -5262,6 +5262,11 @@ have_ubsan=3Dno
>  have_asan_iface_h=3Dno
>  have_asan_iface_fiber=3Dno
> =20
> +# enable sanitizers by default if --enable-debug
> +if test "$sanitizers" =3D "" -a "$debug" =3D "yes"; then
> +  sanitizers=3Dyes
> +fi
> +
>  if test "$sanitizers" =3D "yes" ; then
>    if compile_prog "$CPU_CFLAGS -Werror -fsanitize=3Daddress" ""; then
>        have_asan=3Dyes
>=20
