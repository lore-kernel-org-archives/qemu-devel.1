Received: from eggs.gnu.org ([2001:4830:134:3::10]:52241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC56Z-0002p4-Mu
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fC56Y-00034u-NG
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:16:11 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:37578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fC56Y-00034e-Ho
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 11:16:10 -0400
Received: by mail-oi0-x244.google.com with SMTP id f63-v6so1888476oic.4
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 08:16:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180424072828.21699-1-christophe.lyon@st.com>
References: <20180424072828.21699-1-christophe.lyon@st.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Apr 2018 16:15:49 +0100
Message-ID: <CAFEAcA9Pm+LxN3-FU8MS=eriwezOF=pestWJKj0-onDZcX8=yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [ARM/FDPIC v3 4/4] linux-user: ARM-FDPIC: Add
 support for signals for FDPIC targets
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

On 24 April 2018 at 08:28, Christophe Lyon <christophe.lyon@st.com> wrote:
> The FDPIC restorer needs to deal with a function descriptor, hence we
> have to extend 'retcode' such that it can hold the instructions needed
> to perform this.
>
> The restorer sequence uses the same thumbness as the exception
> handler (mainly to support Thumb-only architectures).
>
> Compared to v2: setup_return() now returns an error if the FDPIC
> function description isn't readable. Callers of setup_return() are
> updated to force_sigsegv in such cases.
>
> Co-Authored-By: Micka=C3=ABl Gu=C3=AAn=C3=A9 <mickael.guene@st.com>
> Signed-off-by: Christophe Lyon <christophe.lyon@st.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Can you fix up the minor nits in patch 3, and resend as an
entire series with all the patches and a cover letter, please?

thanks
-- PMM
