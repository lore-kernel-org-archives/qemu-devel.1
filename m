Received: from eggs.gnu.org ([209.51.188.92]:34923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmc86-0002dD-Py
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:21:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmc1S-0004bU-6W
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:14:10 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41950)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmc1S-0004aa-1Z
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:14:10 -0500
Received: by mail-oi1-x241.google.com with SMTP id j21so4375637oii.8
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 02:14:09 -0800 (PST)
MIME-Version: 1.0
References: <20190124040457.2546-1-doug16k@gmail.com>
In-Reply-To: <20190124040457.2546-1-doug16k@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Jan 2019 10:13:57 +0000
Message-ID: <CAFEAcA9fVkGEMPUaSapn6YOV0DR_rS17pWKZHTxQz0aCM+et3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] gdbstub: Fix i386/x86_64 machine
 description and add control registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Gale <doug16k@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, 24 Jan 2019 at 04:08, Doug Gale <doug16k@gmail.com> wrote:
>
> Signed-off-by: Doug Gale <doug16k@gmail.com>
> ---
>  configure                   |   4 +-
>  gdb-xml/i386-32bit-core.xml |  65 -----------
>  gdb-xml/i386-32bit-sse.xml  |  52 ---------
>  gdb-xml/i386-32bit.xml      | 184 ++++++++++++++++++++++++++++++-
>  gdb-xml/i386-64bit-core.xml |  73 -------------
>  gdb-xml/i386-64bit-sse.xml  |  60 -----------
>  gdb-xml/i386-64bit.xml      | 210 +++++++++++++++++++++++++++++++++++-
>  target/i386/cpu.c           |   4 +-
>  target/i386/gdbstub.c       | 186 +++++++++++++++++++++++++++++++-
>  9 files changed, 573 insertions(+), 265 deletions(-)
>  delete mode 100644 gdb-xml/i386-32bit-core.xml
>  delete mode 100644 gdb-xml/i386-32bit-sse.xml
>  delete mode 100644 gdb-xml/i386-64bit-core.xml
>  delete mode 100644 gdb-xml/i386-64bit-sse.xml

Could you provide a commit message that explains what's
wrong with the machine description we have (ie what bug
or bugs this change is fixing) and why deleting half
the xml files is the right way to fix it, please?

Does the "add control registers" part need to be in
the same patch, or is it a separate feature which
could be in its own patch ?

thanks
-- PMM
