Received: from eggs.gnu.org ([209.51.188.92]:49588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hFjZv-0005GC-QT
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:10:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hFjWa-0008Kj-Pz
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:06:41 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:34961)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hFjWa-0008JZ-9M
	for qemu-devel@nongnu.org; Sun, 14 Apr 2019 14:06:40 -0400
Received: by mail-ot1-x32b.google.com with SMTP id m10so12588890otp.2
	for <qemu-devel@nongnu.org>; Sun, 14 Apr 2019 11:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <CA+7cjLHg8+X0GDGLbk=Dvo=Hjo_LpECa-bPzMO-higpnKoo8LA@mail.gmail.com>
In-Reply-To: <CA+7cjLHg8+X0GDGLbk=Dvo=Hjo_LpECa-bPzMO-higpnKoo8LA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 14 Apr 2019 19:06:27 +0100
Message-ID: <CAFEAcA9dVne1=R+_zSMfrpSVY3JCGFRLCfw0DcmJKefZ2UV71Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] How to use QEMU's "cpu_physical_memory_" functions?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?5a6L5bu25p2w?= <icarus19971031@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Sat, 13 Apr 2019 at 10:47, =E5=AE=8B=E5=BB=B6=E6=9D=B0 <icarus19971031@g=
mail.com> wrote:
> I have started a project which requires the host to continuously write to
> VM's memory. VM reads its memory and performs some operations.
> I've found in this thread
> <https://lists.gnu.org/archive/html/qemu-devel/2014-11/msg03166.html> tha=
t
> I can use QEMU's "cpu_physical_memory_" functions. And I have found their
> definitions in "include/exec/cpu-common.h" in the source code of QEMU.

For QEMU functions which access guest memory, see
docs/devel/loads-stores.rst. cpu_physical_memory_* are
generally not what you want to use in current QEMU,
though some legacy code does.

thanks
-- PMM
