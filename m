Received: from eggs.gnu.org ([2001:4830:134:3::10]:53630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvPeq-0004Qr-T7
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dvPeq-0006o1-1x
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:14:24 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:56078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dvPep-0006nc-Qd
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 11:14:23 -0400
Received: by mail-wr0-x235.google.com with SMTP id l39so1164504wrl.12
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 08:14:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAACKNgWbTjtFqV_Qv5aqWaVDxiu-D1Vf7+NvkBLrMzpQsz-BfA@mail.gmail.com>
References: <CAACKNgWgNbvH_UV-nLUrcrN7F1jh9G2-ZAScm=Xv2OKhc6WyLQ@mail.gmail.com>
	<CAFEAcA_T+w4msJSKi2=zo899+uA5sRGVjiR-aoKXwCg5odp9qw@mail.gmail.com>
	<CAACKNgWbTjtFqV_Qv5aqWaVDxiu-D1Vf7+NvkBLrMzpQsz-BfA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Sep 2017 16:14:02 +0100
Message-ID: <CAFEAcA-dVq+7uZJ-3SCyknGgmnVowWTmLPseuobbzmXfkZ3dQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Support for ARM CP15 registers via GDB interface
 of qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Abhijit Ray Chaudhury <abhijit.ray.chaudhury@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 September 2017 at 16:11, Abhijit Ray Chaudhury
<abhijit.ray.chaudhury@gmail.com> wrote:
> Hi Peter,
>
> Thanks for your prompt response. I have gone through target
> description xml format for gdb
> (https://sourceware.org/gdb//onlinedocs/gdb/ARM-Features.html#ARM-Features)
> . I could not find a feature description matching cp15 registers.So
> even if I implement some subset of it would gdb understand it ? Can I
> randomly name SCTLR TTBR0 etc and gdb understand it ?

Yes, that's the sort of question you'd need to investigate and
answer to implement this feature :-)

thanks
-- PMM
