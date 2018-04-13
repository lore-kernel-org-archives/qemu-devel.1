Received: from eggs.gnu.org ([2001:4830:134:3::10]:43337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f70T9-0005vF-A6
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:18:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f70T8-0008Ce-Ev
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:18:31 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:42076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f70T8-0008CR-9r
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:18:30 -0400
Received: by mail-ot0-x244.google.com with SMTP id h55-v6so10242404ote.9
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 08:18:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180406151752.10854-1-christophe.lyon@st.com>
References: <20180406151752.10854-1-christophe.lyon@st.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 16:18:09 +0100
Message-ID: <CAFEAcA9f7UHZAK51jdZsSsx-wc6Mvee0L2BPnOsKy78+ceWi3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [ARM/FDPIC 0/4] FDPIC ABI for ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Lyon <christophe.lyon@st.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Christophe Lyon <christophe.lyon@linaro.org>

On 6 April 2018 at 16:17, Christophe Lyon <christophe.lyon@st.com> wrote:
> Hello,
>
> This patch series implements the QEMU contribution of the FDPIC
> ABI for ARM targets.

> I am currently working on updating the patches for the other toolchain
> components, and will upstream them soon. This includes gcc, uclibc,
> and gdb.
>
> This series provides support for ARM v7 and later architectures and
> has been used to run the GCC tests on arm-linux-gnueabi without
> regression, as well as arm-linux-uclibceabi.
>
> Are the QEMU patches OK for inclusion in master?

Hi; I've given the patches a quick look over for structural
issues, though I haven't looked too closely at the details.
I think that given that the support is in Linux master I'm
happy with it also going into QEMU.

NB that Laurent has some patchsets outstanding which rework
the linux-user code to split the per-architecture parts of
signal.c and main.c into per-architecture files rather than
having lots of ifdefs. Those will probably land early in the
2.13 cycle. I mention this just as a heads-up that at some point
you'll find yourself with a somewhat painful rebase.

PS: I'd recommend cc'ing the linux-user maintainers (listed in
the MAINTAINERS file) on your next version of this patchset.

thanks
-- PMM
