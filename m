Received: from eggs.gnu.org ([2001:4830:134:3::10]:34103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f70GO-0006dZ-F7
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:05:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f70GK-0006yU-8j
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:05:20 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:33558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f70GK-0006xZ-4d
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 11:05:16 -0400
Received: by mail-oi0-x242.google.com with SMTP id 126-v6so8637431oig.0
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 08:05:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180406151752.10854-2-christophe.lyon@st.com>
References: <20180406151752.10854-1-christophe.lyon@st.com>
	<20180406151752.10854-2-christophe.lyon@st.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Apr 2018 16:04:55 +0100
Message-ID: <CAFEAcA9b7coeoZUX9JhkMZbLsEaM265g5Y844JScaO0k-1dsxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [ARM/FDPIC 1/4] linux-user: ARM-FDPIC: Add
 configure option to support loading of FDPIC binaries
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
> Adds --enable-fdpic and --disable-fdpic configure options.  This
> feature is disabled by default, that's why it is not described in the
> "Optional features" help section (which are enabled by default if
> possible).
>
> FDPIC ELF objects are identified with e_ident[EI_OSABI] ==
> ELFOSABI_ARM_FDPIC.

If we can identify these ELF objects by looking in the ELF header,
why would we want to make this all a configure option that's
disabled by default?

I think we should just have support for these binaries enabled
always. Otherwise it will bitrot because nobody compiles it.

thanks
-- PMM
