Received: from eggs.gnu.org ([2001:4830:134:3::10]:54132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFeHP-0000f0-Kd
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:21:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dFeHO-0004Su-Ia
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:21:35 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dFeHO-0004Sm-BP
	for qemu-devel@nongnu.org; Tue, 30 May 2017 06:21:34 -0400
Received: by mail-wm0-x231.google.com with SMTP id e127so93745479wmg.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 03:21:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87vaox2cvi.fsf@linaro.org>
References: <591DC93D.2060707@ispras.ru> <87vaox2cvi.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2017 11:21:12 +0100
Message-ID: <CAFEAcA8H1Kwjnj+A1XdGO=7U-hPhys+W-MRy3yyOTkBoUb0ptg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] EL2\EL3 support for Aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Sergey Smolov <smolov@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>

On 19 May 2017 at 14:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
> Sergey Smolov <smolov@ispras.ru> writes:
>
>> Hello, List!
>>
>> Could you tell me, what is the current state for EL2\EL3 (Aarch64)?
>> Whether they are fully supported, or not?
>> Am I need to use any command line options to enable them for Aarch64
>> assembler programs simulation?
>
> Sure you can use both. To enable EL2 support:
>
>   qemu-system-aarch64 ${QEMU_OPTS} \
>     -machine gic-version=3D3 \
>     -machine virtualization=3Dtrue
>
> To boot in secure mode you'll need to use -bios and boot a secure
> firmware (like OPTEE for example).

You also need -machine secure=3Dtrue to turn on EL3 in the virt board.

NB that EL2 is currently only supported (1) for AArch64 EL2 and
(2) with GICv3, not for AArch32 EL2 or with GICv2.

thanks
-- PMM
