Received: from eggs.gnu.org ([2001:4830:134:3::10]:50269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC0oZ-0005C8-OG
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:09:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eC0oT-0003iX-ST
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:09:03 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:52992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eC0oT-0003hn-L1
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 05:08:57 -0500
Received: by mail-wm0-x244.google.com with SMTP id t139so2587094wmt.1
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 02:08:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171101154607.1582-1-programmingkidx@gmail.com>
References: <20171101154607.1582-1-programmingkidx@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Nov 2017 10:08:36 +0000
Message-ID: <CAFEAcA9tdfgL1J4ZRudi_R-qgDiiRHJeQiviM+ub0Uj3vzD-3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] Make scrolling work again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1 November 2017 at 15:46, John Arbuckle <programmingkidx@gmail.com> wrote:
> Make scrolling in the monitor work.
>
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  ui/cocoa.m | 96 +++++++++++++++++++++++++++++++++++++++++---------------------
>  1 file changed, 64 insertions(+), 32 deletions(-)

Hi; I've applied this to my cocoa.next branch.
I tweaked the commit message a bit (subject lines
ought to have some kind of prefix like "ui/cocoa"
to indicate what area of QEMU they relate to -- this
commit message didn't have anything saying it was
Cocoa related at all.

> +
> +    // if not a key that needs translating
> +    if (keysym == 0) {
> +        NSString *ks = [event characters];
> +        if ([ks length] > 0)
> +            keysym = [ks characterAtIndex:0];
> +    }
> +
> +    if (keysym)
> +        kbd_put_keysym(keysym);

I did ask you to put braces on these if statements;
I've fixed that up in the version I applied to cocoa.next.

thanks
-- PMM
