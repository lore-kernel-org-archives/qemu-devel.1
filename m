Received: from eggs.gnu.org ([2001:4830:134:3::10]:42589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhj40-0007a4-MO
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 18:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fhj3z-0003wP-Sr
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 18:12:20 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:46717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fhj3z-0003wJ-M1
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 18:12:19 -0400
Received: by mail-oi0-x242.google.com with SMTP id y207-v6so3975758oie.13
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 15:12:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180723220047.31594-1-richard.henderson@linaro.org>
References: <20180723220047.31594-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Jul 2018 23:11:58 +0100
Message-ID: <CAFEAcA9um80RvdkaULo6z8n_sZ3=Vr+_2qROv5ABHObz6tJyng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.0?] target/arm: Add sve-max-vq cpu
 property to -cpu max
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 23 July 2018 at 23:00, Richard Henderson
<richard.henderson@linaro.org> wrote:
> This allows the default (and maximum) vector length to be set
> from the command-line.  Which is extraordinarily helpful in
> debuging problems depending on vector length without having to
> bake knowledge of PR_SET_SVE_VL into every guest binary.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>
> The argument for inclding this in 3.0 is that there appear to be
> several groups experimenting with SVE and using fixed vector lengths.
> While this is oddly against the design of SVE, it's probably going
> to keep happening.  Plus, the wildly useful debugging aspect.

...on the other hand, it's a new feature and we're about to
cut rc2 tomorrow. I'd prefer to leave this til after 3.0 releases.

thanks
-- PMM
