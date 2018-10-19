Received: from eggs.gnu.org ([2001:4830:134:3::10]:40167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDXnI-0008EH-QQ
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDXnG-00049X-KY
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:38:36 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:32851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDXnE-00047E-Ko
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 12:38:34 -0400
Received: by mail-ot1-x344.google.com with SMTP id q50so33827955otd.0
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 09:38:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <6ea8c64f-272f-6645-8a2f-b94117a24027@redhat.com>
References: <1539954845-26716-1-git-send-email-thuth@redhat.com>
	<1539954845-26716-6-git-send-email-thuth@redhat.com>
	<CAFEAcA_NkdZtbM9n4633_hSr38eb9FJsi92=+Eeuky+U=eDtZA@mail.gmail.com>
	<6ea8c64f-272f-6645-8a2f-b94117a24027@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 17:38:10 +0100
Message-ID: <CAFEAcA9DM0sEpyH=GGoJLt-p8ZYxYEs2u8KDm+AjH23nqjo3WQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/5] configs: Add a CONFIG_SMC37C669 switch
 for the "smc37c669-superio" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 19 October 2018 at 17:35, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> On 19/10/2018 16:46, Peter Maydell wrote:
>> Should isa-superio.o also go in its own config flag?
>
> It could be, but pc87312/smc37c669/vt82c686 inherit of TYPE_ISA_SUPERIO
> so would require something like:
>
> common-obj-$(call land,$(CONFIG_ISA_SUPERIO),$(CONFIG_PC87312)) \
>             +=3D pc87312.o
> common-obj-$(call land,$(CONFIG_ISA_SUPERIO),$(CONFIG_VT82C686)) \
>             +=3D vt82c686.o
> common-obj-$(call land,$(CONFIG_ISA_SUPERIO),$(CONFIG_SMC37C669)) \
>             +=3D smc37c669-superio.o

This is where it would be nice to be able to say
"CONFIG_FOO requires CONFIG_BAR", indeed.

thanks
-- PMM
