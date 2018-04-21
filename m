Received: from eggs.gnu.org ([2001:4830:134:3::10]:58079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f9h9J-0006pH-9H
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 21:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f9h9I-0008Lu-BQ
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 21:17:09 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:40971)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f9h9I-0008LB-3z
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 21:17:08 -0400
Received: by mail-wr0-x244.google.com with SMTP id v24-v6so27059405wra.8
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 18:17:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5570aff71297a26c09ba9b6cb3f88f583ff31057.1524247958.git.tgolembi@redhat.com>
References: <5570aff71297a26c09ba9b6cb3f88f583ff31057.1524247958.git.tgolembi@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 21 Apr 2018 03:17:04 +0200
Message-ID: <CAJ+F1C+SHFGFVuk=-3+vOQ6z4mh8KG8qKY+O42PEgrS74Jk4Rg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qga/schema: fix documentation for
 GuestOSInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU <qemu-devel@nongnu.org>

On Fri, Apr 20, 2018 at 8:12 PM, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolemb=
i@redhat.com> wrote:
> The documentation for kernel-version and kernel-release on Windows was
> swapped.
>
> Signed-off-by: Tom=C3=A1=C5=A1 Golembiovsk=C3=BD <tgolembi@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qga/qapi-schema.json | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 17884c7c70..d3a686ba12 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1168,10 +1168,10 @@
>  #
>  # @kernel-release:
>  #     * POSIX: release field returned by uname(2)
> -#     * Windows: version number of the OS
> +#     * Windows: build number of the OS
>  # @kernel-version:
>  #     * POSIX: version field returned by uname(2)
> -#     * Windows: build number of the OS
> +#     * Windows: version number of the OS
>  # @machine:
>  #     * POSIX: machine field returned by uname(2)
>  #     * Windows: one of x86, x86_64, arm, ia64
> --
> 2.17.0
>
>



--=20
Marc-Andr=C3=A9 Lureau
