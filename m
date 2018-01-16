Received: from eggs.gnu.org ([2001:4830:134:3::10]:33118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebTsN-0006ni-Ja
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:14:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebTsH-0007x7-Lg
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:14:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49168)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebTsH-0007w9-FJ
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 11:14:09 -0500
Date: Tue, 16 Jan 2018 18:13:48 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180116181343-mutt-send-email-mst@kernel.org>
References: <1516117900-11382-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<1516117900-11382-4-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1516117900-11382-4-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/4] acpi: implement aml_lless_equal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, kevin@koconnor.net, marcandre.lureau@redhat.com, lersek@redhat.com

On Tue, Jan 16, 2018 at 10:51:39AM -0500, Stefan Berger wrote:
> LLessEqualOp =3D LNotOp LGreaterOp
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
> Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/acpi/aml-build.c         | 11 +++++++++++
>  include/hw/acpi/aml-build.h |  1 +
>  2 files changed, 12 insertions(+)
>=20
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 36a6cc4..c475f56 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -568,6 +568,17 @@ Aml *aml_lless(Aml *arg1, Aml *arg2)
>      return var;
>  }
> =20
> +/* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefLLessEqual */
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
> --=20
> 2.5.5
