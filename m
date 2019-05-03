Received: from eggs.gnu.org ([209.51.188.92]:42659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYr9-0001E4-Py
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMYr8-00052e-OP
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:08:07 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40998)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMYr8-0004yy-Hw
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:08:06 -0400
Received: by mail-ot1-x341.google.com with SMTP id g8so5374554otl.8
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 07:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190503002206.9751-1-driver1998@foxmail.com>
	<39b71c2a-9630-5a56-17c7-d74625f97d55@redhat.com>
In-Reply-To: <39b71c2a-9630-5a56-17c7-d74625f97d55@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 15:07:53 +0100
Message-ID: <CAFEAcA_o1tF6VEiEZCeFeKB67bDtCGTEHvE0cMAWxicTDfRUOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Initial Windows on ARM (AArch64
 64-Bit) host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Cao Jiaxi <driver1998@foxmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 3 May 2019 at 11:20, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> On 5/3/19 2:22 AM, Cao Jiaxi wrote:
> > Initial Windows on ARM (AArch64 64-Bit) host support
> >
> > This series of patches is for initial support of Windows 10 on ARM as a=
 QEMU host.
> > Currently only TCG intepreter is working correctly, it crashes when TCG=
 JIT is enabled.
> >
> > For now we assume it is built using the clang aarch64-w64-mingw32 toolc=
hain,
> > you can get a prebuilt toolchain at https://github.com/mstorsjo/llvm-mi=
ngw.
> >
>
> I'm a bit confused since those patches appear 2 times in my mailbox.
> Assuming this is a git send-email setup mistake, please consider adding
> my Reviewed-by/Tested-by here too.

Thanks -- I've applied these patches to target-arm.next, and have
consolidated the various tags that people have applied to the
two sets of emails (and checked that they actually are the same
patches and not different code :-))

-- PMM
