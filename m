Received: from eggs.gnu.org ([2001:4830:134:3::10]:50031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ea15P-0004mZ-Eq
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 10:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ea15O-0001c3-GY
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 10:17:39 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:39061)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ea15N-0001Zr-TZ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 10:17:38 -0500
Received: by mail-wr0-x243.google.com with SMTP id z48so5590070wrz.6
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 07:17:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515609318-1897-3-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1515609318-1897-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1515609318-1897-3-git-send-email-stefanb@linux.vnet.ibm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 12 Jan 2018 16:17:36 +0100
Message-ID: <CAJ+F1CJwt+txMjY1AtCRF0_FzkgAm_qv8_itHUwnWD9s_Oucqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 2/3] acpi: implement aml_lless_equal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU <qemu-devel@nongnu.org>, kevin@koconnor.net, "Michael S. Tsirkin" <mst@redhat.com>

2018-01-10 19:35 GMT+01:00 Stefan Berger <stefanb@linux.vnet.ibm.com>:
> LLessEqualOp =3D LNotOp LGreaterOp
>
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  hw/acpi/aml-build.c         | 10 ++++++++++
>  include/hw/acpi/aml-build.h |  1 +
>  2 files changed, 11 insertions(+)
>
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 36a6cc4..597a58d 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -568,6 +568,16 @@ Aml *aml_lless(Aml *arg1, Aml *arg2)
>      return var;
>  }
>
> +Aml *aml_lless_equal(Aml *arg1, Aml *arg2)
> +{
> +    /* LLessEqualOp :=3D LNotOp LGreaterOp */
> +    Aml *var =3D aml_opcode(0x92 /* LNotOp */);
> +    build_append_byte(var->buf, 0x94 /* LGreaterOp */);
> +    aml_append(var, arg1);
> +    aml_append(var, arg2);
> +    return var;
> +}
> +
>  /* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefAdd */
>  Aml *aml_add(Aml *arg1, Aml *arg2, Aml *dst)
>  {
> diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
> index 88d0738..c4398cc 100644
> --- a/include/hw/acpi/aml-build.h
> +++ b/include/hw/acpi/aml-build.h
> @@ -267,6 +267,7 @@ Aml *aml_lor(Aml *arg1, Aml *arg2);
>  Aml *aml_shiftleft(Aml *arg1, Aml *count);
>  Aml *aml_shiftright(Aml *arg1, Aml *count, Aml *dst);
>  Aml *aml_lless(Aml *arg1, Aml *arg2);
> +Aml *aml_lless_equal(Aml *arg1, Aml *arg2);
>  Aml *aml_add(Aml *arg1, Aml *arg2, Aml *dst);
>  Aml *aml_subtract(Aml *arg1, Aml *arg2, Aml *dst);
>  Aml *aml_increment(Aml *arg);
> --
> 2.5.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
