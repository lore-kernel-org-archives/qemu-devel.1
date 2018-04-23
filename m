Received: from eggs.gnu.org ([2001:4830:134:3::10]:50296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAaVn-0006Nm-L1
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fAaVm-0002dq-Pe
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:24:03 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:33291)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fAaVm-0002dd-Kt
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:24:02 -0400
Received: by mail-oi0-x241.google.com with SMTP id 126-v6so14032667oig.0
	for <qemu-devel@nongnu.org>; Mon, 23 Apr 2018 05:24:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180423075215.4572-2-christophe.lyon@st.com>
References: <20180423075215.4572-1-christophe.lyon@st.com>
	<20180423075215.4572-2-christophe.lyon@st.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Apr 2018 13:23:41 +0100
Message-ID: <CAFEAcA8D8pN0zDMe8t=jns7ZWbLQH3Tp6dW=fVFwmhpdx+ue-A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [ARM/FDPIC v2 1/4] Remove CONFIG_USE_FDPIC.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe Lyon <christophe.lyon@st.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Christophe Lyon <christophe.lyon@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 23 April 2018 at 08:51, Christophe Lyon <christophe.lyon@st.com> wrote:
> We want to avoid code disabled by default, because it ends up less
> tested. This patch removes all instances of #ifdef CONFIG_USE_FDPIC,
> most of which can be safely kept. For the ones that should be
> conditionally executed, we define elf_is_fdpic(). Without this patch,
> defining CONFIG_USE_FDPIC would prevent QEMU from building precisely
> because elf_is_fdpic is not defined.
>
> Signed-off-by: Christophe Lyon <christophe.lyon@st.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
