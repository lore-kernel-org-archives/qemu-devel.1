Received: from eggs.gnu.org ([2001:4830:134:3::10]:36947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gRbuk-0005te-AV
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:52:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gRbug-0008QI-CA
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:52:26 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gRbub-0008OL-9g
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 06:52:20 -0500
Received: by mail-qt1-f196.google.com with SMTP id v11so21308459qtc.2
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 03:52:14 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181127111118eucas1p1b76423fb92768a8501aea2a1dbb512fd@eucas1p1.samsung.com>
	<20181127111050.18453-1-i.maximets@samsung.com>
	<20181127111050.18453-4-i.maximets@samsung.com>
In-Reply-To: <20181127111050.18453-4-i.maximets@samsung.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 27 Nov 2018 15:52:02 +0400
Message-ID: <CAMxuvazv=c4q=QbpLfTiQkPTVCznoW3exRMyGpsJ1_LsnLv+SA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] memfd: set up correct errno if not
 supported
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
> qemu_memfd_create() prints the value of 'errno' which is not
> set in this case.
>
> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  util/memfd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/util/memfd.c b/util/memfd.c
> index d74ce4d793..393d23da96 100644
> --- a/util/memfd.c
> +++ b/util/memfd.c
> @@ -40,6 +40,7 @@ static int memfd_create(const char *name, unsigned int =
flags)
>  #ifdef __NR_memfd_create
>      return syscall(__NR_memfd_create, name, flags);
>  #else
> +    errno =3D ENOSYS;
>      return -1;
>  #endif
>  }
> --
> 2.17.1
>
