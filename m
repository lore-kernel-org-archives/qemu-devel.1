Received: from eggs.gnu.org ([2001:4830:134:3::10]:53024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHQPF-0000Pq-OL
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:33:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHQPD-0003PO-Iu
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:33:49 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHQP7-0003JU-HF
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 05:33:43 -0400
Received: by mail-ot1-x341.google.com with SMTP id q25so10403014otn.12
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 02:33:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c097d8c.a587.166c2c22a77.Coremail.wj193102@163.com>
References: <c097d8c.a587.166c2c22a77.Coremail.wj193102@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 09:33:15 +0000
Message-ID: <CAFEAcA-r=71qgPByUWuKsSAwiRA2S7qidtrrWyRuHvrckAvxSQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qemu3.0.0: Linux on non x86 CPUs run Wine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wj193102 <wj193102@163.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 30 October 2018 at 02:16, wj193102 <wj193102@163.com> wrote:
> Hi, everyone.
>     When I have installed the QEMU3.0.0 in the Linux on non X86 CPUS, I want to use user space emulator to run Wine. I can get the source code for Wine and the RPM file for Wine from the WineHQ web page.
> I used to compile Wine in the X86-based Linux system and used it to run most Win32 programs. Now I want to  use it on the non X86 CPUS by QEMU. But I can't get the function to install and use the Wine. Please give me some advice
> or some functions to finish it. Thanks a lot.

I'm afraid you will need to provide more detail for us to
help here. What exactly are you doing? Which commands are you
running? What is the exact error message or failure you see?

>    Meanwhile, I use the command "qemu-i386/qemu-x86_64 *.sh" to
> run the application from the X86 CPUS on non X86 CPUS, I get the
> error information:"Invalid ELF image for this architecture". Why
> the error is comming? What can I do to resolve this problem?

This is probably because you are trying to run a shell script.
(I'm guessing this from the '.sh' extension). This won't work.
QEMU only runs actual executables (ELF files).

Usually the setup is that the host Linux system is set up
with binfmt-misc, so that if it encounters a guest-architecture
binary it will automatically run it under QEMU. Usually
this is done to allow running guest binaries inside a chroot.

thanks
-- PMM
