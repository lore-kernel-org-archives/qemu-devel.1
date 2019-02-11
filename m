Received: from eggs.gnu.org ([209.51.188.92]:45458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtEVz-0002WD-JV
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:33:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gtEVx-0003YB-Hs
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:33:03 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gtEVx-0003Ia-Aj
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:33:01 -0500
Received: by mail-ot1-x344.google.com with SMTP id n71so3915364ota.10
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 08:32:23 -0800 (PST)
MIME-Version: 1.0
References: <1548985244-24523-1-git-send-email-catherine.hecx@gmail.com>
	<eeb0f275-b262-25db-337a-b6c78b29c124@linaro.org>
In-Reply-To: <eeb0f275-b262-25db-337a-b6c78b29c124@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Feb 2019 16:19:20 +0000
Message-ID: <CAFEAcA9u_FYk40QyC=_R-VMVN74A5kTWYKCSgH-Kzya1_Pqzdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RFC PATCH] target/arm: Fix int128_make128 lo,
 hi order in paired_cmpxchg64_be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Catherine Ho <catherine.hecx@gmail.com>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On Mon, 11 Feb 2019 at 16:11, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 1/31/19 5:40 PM, Catherine Ho wrote:
> > The lo,hi order is different from the comments. And in commit
> > 1ec182c33379 ("target/arm: Convert to HAVE_CMPXCHG128"), it changes
> > the original code logic. So just restore the old code logic before this
> > commit:
> > do_paired_cmpxchg64_be():
> >     cmpv = int128_make128(env->exclusive_high, env->exclusive_val);
> >     newv = int128_make128(new_hi, new_lo);
> >
> > Fixes: 1ec182c33379 ("target/arm: Convert to HAVE_CMPXCHG128")
> >
> > Signed-off-by: Catherine Ho <catherine.hecx@gmail.com>
> > ---
>
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks. Richard: is this effectively a bugfix for big-endian guest code ?

-- PMM
