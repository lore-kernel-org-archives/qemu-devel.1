Received: from eggs.gnu.org ([2001:4830:134:3::10]:35125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e96oi-00069K-3Q
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 05:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e96oh-0002HQ-8N
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 05:57:12 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:55466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e96oh-0002H0-1O
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 05:57:11 -0400
Received: by mail-wr0-x244.google.com with SMTP id l8so11877500wre.12
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 02:57:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171030032521.2441-1-f4bug@amsat.org>
References: <08178b4217d1692297b8c9620b6d13a80bfb6822.1509175660.git.alistair.francis@xilinx.com>
	<20171030032521.2441-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Oct 2017 09:56:49 +0000
Message-ID: <CAFEAcA-bwavBtd0Xe2gYtY3pWjHjrccAtUNfiSD2w4xt7PbrCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] xlnx-zcu102: Specify the number of max
 CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair23@gmail.com>

On 30 October 2017 at 03:25, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
> From: Alistair Francis <alistair.francis@xilinx.com>
>
> Specify the number of CPUs that can run on ZynqMP.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> V3:
>  - Fix my ASCII noncompliant last name in Reviewed-by tag :(
>  - added Tested-by for what it's worth
>
> V2:
>  - Use macros
>
>  hw/arm/xlnx-zcu102.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> index 519a16ed98..e2d15a1c9d 100644
> --- a/hw/arm/xlnx-zcu102.c
> +++ b/hw/arm/xlnx-zcu102.c
> @@ -240,6 +240,7 @@ static void xlnx_zcu102_machine_class_init(ObjectClas=
s *oc, void *data)
>      mc->block_default_type =3D IF_IDE;
>      mc->units_per_default_bus =3D 1;
>      mc->ignore_memory_transaction_failures =3D true;
> +    mc->max_cpus =3D XLNX_ZYNQMP_NUM_APU_CPUS + XLNX_ZYNQMP_NUM_RPU_CPUS=
;
>  }
>
>  static const TypeInfo xlnx_zcu102_machine_init_typeinfo =3D {


Applied to target-arm.next, thanks.

-- PMM
