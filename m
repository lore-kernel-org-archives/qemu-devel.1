Received: from eggs.gnu.org ([2001:4830:134:3::10]:35537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHTNd-0006KL-BO
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHTNb-0004d9-Ho
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:44:21 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:43357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHTNb-0004cI-Aw
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 08:44:19 -0400
Received: by mail-ot1-x341.google.com with SMTP id k9so10886571otl.10
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 05:44:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1e1a8483.155c9.166c4e17888.Coremail.wj193102@163.com>
References: <c097d8c.a587.166c2c22a77.Coremail.wj193102@163.com>
	<CAFEAcA-r=71qgPByUWuKsSAwiRA2S7qidtrrWyRuHvrckAvxSQ@mail.gmail.com>
	<1e1a8483.155c9.166c4e17888.Coremail.wj193102@163.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 12:43:57 +0000
Message-ID: <CAFEAcA8zLbcUAM5OsjP3TL1eLDR3KbX=fOakx_JkB1RYgq41iQ@mail.gmail.com>
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

On 30 October 2018 at 12:10, wj193102 <wj193102@163.com> wrote:
> That is my fault. I don't run the *.sh file. I copy the file "/bin/ls" from
> the Linux on x86 CPUs to the Linux on non X86 CPUs. I put the file in the
> new created directory, such as "/home/admin/user/test/".
> Then I run the executable file,using "qemu-i386 ./ls", I get the following
> error: "./ls: error while loading shared libraries: libselinux.so.1: cannot
> open shared object file: No such file or directory."
> How can I resolve this  problem?

This is because you need not just the guest executable, but
all the DLLs, data files and other things it requires.
The easiest way to set this up is to use a chroot. There
should be some tutorials on the web that you can look for
to tell you how to set this up.

thanks
-- PMM
