Received: from eggs.gnu.org ([2001:4830:134:3::10]:51161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1euIM9-0008GT-Tv
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1euIM6-0004Pc-TJ
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:46:45 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:45139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1euIM6-0004On-Lk
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:46:42 -0500
Received: by mail-wr0-x241.google.com with SMTP id h2so1788820wre.12
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 05:46:42 -0800 (PST)
References: <20180308130626.12393-1-peter.maydell@linaro.org>
	<20180308130626.12393-6-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180308130626.12393-6-peter.maydell@linaro.org>
Date: Fri, 09 Mar 2018 13:46:40 +0000
Message-ID: <873719l5tr.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/6] hw/arm/virt: Add "max" to the list
 of CPU types "virt" supports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org, Igor Mammedov <imammedo@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Allow the virt board to support '-cpu max' in the same way
> it already handles '-cpu host'.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  hw/arm/virt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index dbb3c8036a..cda4b83586 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -169,6 +169,7 @@ static const char *valid_cpus[] =3D {
>      ARM_CPU_TYPE_NAME("cortex-a53"),
>      ARM_CPU_TYPE_NAME("cortex-a57"),
>      ARM_CPU_TYPE_NAME("host"),
> +    ARM_CPU_TYPE_NAME("max"),
>  };
>
>  static bool cpu_type_valid(const char *cpu)


--
Alex Benn=C3=A9e
