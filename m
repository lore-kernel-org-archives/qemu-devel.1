Received: from eggs.gnu.org ([2001:4830:134:3::10]:51024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcYeY-0006Aa-Kj
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcYeX-00064y-LA
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:04:42 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:46995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcYeX-00064o-Fa
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 12:04:41 -0400
Received: by mail-oi0-x244.google.com with SMTP id y207-v6so36838385oie.13
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 09:04:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1530806837-5416-1-git-send-email-cota@braap.org>
References: <1530806837-5416-1-git-send-email-cota@braap.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jul 2018 17:04:20 +0100
Message-ID: <CAFEAcA_1GaxyD7TdcyuCMTraXZEB4dUhwmcW_jCQ2z_tECe7Wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] translate-all: honour CF_NOCACHE in
 tb_gen_code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Richard Henderson <richard.henderson@linaro.org>

On 5 July 2018 at 17:07, Emilio G. Cota <cota@braap.org> wrote:
> This fixes a record-replay regression introduced by 95590e2
> ("translate-all: discard TB when tb_link_page returns an existing
> matching TB", 2018-06-15). The problem is that code using CF_NOCACHE
> assumes that the TB returned from tb_gen_code is always a
> newly-generated one. This assumption, however, was broken in
> the aforementioned commit.
>
> Fix it by honouring CF_NOCACHE, so that tb_gen_code always
> returns a newly-generated TB when CF_NOCACHE is passed to it.
> Do this by avoiding the TB hash table if CF_NOCACHE is set.
>
> Reported-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> Tested-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---

Applied to master ready for our rc0 tag tomorrow.

thanks
-- PMM
