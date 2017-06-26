Received: from eggs.gnu.org ([2001:4830:134:3::10]:50460)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPQ7Z-0002sq-A7
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPQ7Y-0002m0-Gj
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:15:49 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dPQ7Y-0002lX-7h
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 05:15:48 -0400
Received: by mail-wr0-x236.google.com with SMTP id k67so140707585wrc.2
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 02:15:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CC588DAB-E108-4D59-867D-B0BCC98CA6A3@icloud.com>
References: <CC588DAB-E108-4D59-867D-B0BCC98CA6A3@icloud.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Jun 2017 10:15:25 +0100
Message-ID: <CAFEAcA8aa-ppWadQL7B1Bsn8aQc=WryxP6NAg_ERYLu7vakeuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] glue(glue(ld, USUFFIX), _p)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Theodore Dubois <tblodt@icloud.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 25 June 2017 at 22:51, Theodore Dubois <tblodt@icloud.com> wrote:
> In include/exec/cpu_ldst_useronly_template.h, there=E2=80=99s
> references to glue(glue(ld, USUFFIX), _p), which would
> expand to a call to a function looking something like
> uint32_t lduw_p(void *) (for example). Where is this
> function defined?

lduw_p is a #define in include/exec/cpu-all.h: it expands
to either lduw_be_p or lduw_le_p depending on whether the
target CPU is big or little endian.

lduw_le_p/lduw_be_p are defined as inline functions in
include/qemu/bswap.h (and are in turn implemented using
other functions and macros also defined in bswap.h).

thanks
-- PMM
