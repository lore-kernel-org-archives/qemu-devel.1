Received: from eggs.gnu.org ([209.51.188.92]:41458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h1tic-0007r2-JQ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:10:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h1tib-0001Lb-TP
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:09:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h1tib-0001IT-Ku
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:09:53 -0500
References: <1551723614-1823-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-nGLVySjjK65Bfedr5H-6XP1_t1rpnupjL89KB-HN8wQ@mail.gmail.com>
	<646bf94e-66da-5083-d2b7-b96633bb5acf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6e6cb20b-b903-fda5-1b7f-4379ae62b20a@redhat.com>
Date: Thu, 7 Mar 2019 15:09:39 +0100
MIME-Version: 1.0
In-Reply-To: <646bf94e-66da-5083-d2b7-b96633bb5acf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/54] Kconfig conversion,
 excluding ARM and MIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Yang Zhong <yang.zhong@intel.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 07/03/19 14:47, Philippe Mathieu-Daud=C3=A9 wrote:
> Paolo, we might need:
>=20
> -- >8 --
> diff --git a/Makefile b/Makefile
> --- a/Makefile
> +++ b/Makefile
> @@ -336,6 +336,7 @@ MINIKCONF_ARGS =3D \
>      CONFIG_SPICE=3D$(CONFIG_SPICE) \
>      CONFIG_IVSHMEM=3D$(CONFIG_IVSHMEM) \
>      CONFIG_TPM=3D$(CONFIG_TPM) \
> +    CONFIG_TPM_EMULATOR=3D$(CONFIG_TPM_EMULATOR) \
>      CONFIG_XEN=3D$(CONFIG_XEN) \
>      CONFIG_OPENGL=3D$(CONFIG_OPENGL) \
>      CONFIG_X11=3D$(CONFIG_X11) \
> ---
>=20
> I'm not sure about CONFIG_TPM_PASSTHROUGH.

Instead of that I'm disabling tpm completely in configure for mingw:

tpm=3D""
...
if test "$tpm" =3D ""; then
  if test "$mingw32" =3D "yes"; then
    tpm=3Dno
  else
    tpm=3Dyes
  fi
elif test "$tpm" =3D "yes"; then
  if test "$mingw32" =3D "yes" ; then
    error_exit "TPM emulation only available on POSIX systems"
  fi
fi

Paolo
