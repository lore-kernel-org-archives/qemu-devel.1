Received: from eggs.gnu.org ([2001:4830:134:3::10]:50133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gGNMn-00014y-T9
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 08:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gGNMn-0006uI-3Q
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 08:06:57 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gGNMm-0006tm-Sb
	for qemu-devel@nongnu.org; Sat, 27 Oct 2018 08:06:57 -0400
Received: by mail-wm1-x341.google.com with SMTP id l26-v6so3832149wmh.3
	for <qemu-devel@nongnu.org>; Sat, 27 Oct 2018 05:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20181018182130.799406-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20181018182130.799406-1-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Sat, 27 Oct 2018 16:06:44 +0400
Message-ID: <CAJ+F1C+Qj3nQ3EdBAe9MJ-th=0Re_9T1H662wphb1_LG3h=nrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] docs: tpm: Mention implemented TPM CRB
 interface emulation and specs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, stefanb@linux.ibm.com

On Thu, Oct 18, 2018 at 10:21 PM Stefan Berger
<stefanb@linux.vnet.ibm.com> wrote:
>
> Add a few sentences about the implemented emulation of the TPM CRB
> interface and its specification.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  docs/specs/tpm.txt | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> index 0e9bbebe1d..1af82bba86 100644
> --- a/docs/specs/tpm.txt
> +++ b/docs/specs/tpm.txt
> @@ -20,6 +20,21 @@ QEMU files related to TPM TIS interface:
>   - hw/tpm/tpm_tis.h
>
>
> +QEMU also implements a TPM CRB interface following the Trusted Computing
> +Group's specification "TCG PC Client Platform TPM Profile (PTP)
> +Specification", Family "2.0", Level 00 Revision 01.03 v22, May 22, 2017.
> +This specification, or a later version of it, can be accessed from the
> +following URL:
> +
> +https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profil=
e-ptp-specification/
> +
> +The CRB interface makes a memory mapped IO region in the area 0xfed40000=
 -
> +0xfed40fff (1 locality) available to the guest operating system.
> +
> +QEMU files related to TPM CRB interface:
> + - hw/tpm/tpm_crb.c
> +
> +
>  =3D ACPI Interface =3D
>
>  The TPM device is defined with ACPI ID "PNP0C31". QEMU builds a SSDT and=
 passes
> --
> 2.17.1
>


--=20
Marc-Andr=C3=A9 Lureau
