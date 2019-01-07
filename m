Received: from eggs.gnu.org ([209.51.188.92]:34541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggSAz-0001Al-7D
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:30:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ggSAy-0000wv-9J
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:30:33 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35298)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ggSAp-0000rF-MT
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 05:30:25 -0500
Received: by mail-ot1-x342.google.com with SMTP id 81so37357133otj.2
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 02:30:18 -0800 (PST)
MIME-Version: 1.0
References: <154681539681.475.7900177304020568757@02a1dbf831e2>
	<45bd563b-881a-5308-dca8-9aaad94b7ebb@gmail.com>
In-Reply-To: <45bd563b-881a-5308-dca8-9aaad94b7ebb@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Jan 2019 10:30:06 +0000
Message-ID: <CAFEAcA_dzEkTFZEsKRjB0pX+rDnhkE=5=qKy9EnFUdu0nH_=yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4] Support u-boot noload images for arm as
 used by, NetBSD/evbarm GENERIC kernel.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nick Hudson <nicholas.a.hudson@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, fam@euphon.net, qemu-arm <qemu-arm@nongnu.org>

On Mon, 7 Jan 2019 at 07:54, Nick Hudson <nicholas.a.hudson@gmail.com> wrote:
> On 06/01/2019 22:56, no-reply@patchew.org wrote:
> > This series seems to have some coding style problems. See output below for
> > more information:
>
> The files being touched have lots of coding style problems already.  I'm
> avoiding i) fixing these in the same diff for clarity and ii) in the
> case of IH_TYPE_KERNEL_NOLOAD, following existing formatting.

Our usual rule of thumb is "keep checkpatch happy", ie don't introduce
new style issues, even if the code being modified is a bit messy.
In this case it's no big deal -- if you've already sent v5 I can
just wrap the long lines when I apply the patch to my tree.

thanks
-- PMM
