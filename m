Received: from eggs.gnu.org ([2001:4830:134:3::10]:36875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gRbuH-0005Y4-NQ
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:51:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gRbuC-0008Gl-N8
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:51:56 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gRbuC-0008GX-JH
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:51:52 -0500
Received: by mail-qt1-f194.google.com with SMTP id l11so21355036qtp.0
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 03:51:52 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181127111114eucas1p21c991b4dd272c8afa803f90c178030a6@eucas1p2.samsung.com>
	<20181127111050.18453-1-i.maximets@samsung.com>
	<20181127111050.18453-3-i.maximets@samsung.com>
In-Reply-To: <20181127111050.18453-3-i.maximets@samsung.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 15:51:40 +0400
Message-ID: <CAMxuvaxWmb-M0uNKARbEA2=Mj-7M9pc4-qpQTEM1ioieTzjfBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] memfd: always check for MFD_CLOEXEC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Maximets, Ilya" <i.maximets@samsung.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Tue, Nov 27, 2018 at 3:11 PM Ilya Maximets <i.maximets@samsung.com> wrot=
e:
>
> QEMU always sets this flag unconditionally. We need to
> check if it's supported.
>
> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>

I don't think that flag is optional, but it doesn't hurt to check it as wel=
l
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  util/memfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/util/memfd.c b/util/memfd.c
> index 8debd0d037..d74ce4d793 100644
> --- a/util/memfd.c
> +++ b/util/memfd.c
> @@ -188,7 +188,7 @@ bool qemu_memfd_alloc_check(void)
>  bool qemu_memfd_check(unsigned int flags)
>  {
>  #ifdef CONFIG_LINUX
> -    int mfd =3D memfd_create("test", flags);
> +    int mfd =3D memfd_create("test", flags | MFD_CLOEXEC);
>
>      if (mfd >=3D 0) {
>          close(mfd);
> --
> 2.17.1
>
