Received: from eggs.gnu.org ([2001:4830:134:3::10]:42380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fVDNf-0007iG-GZ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fVDNe-00065Q-RQ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:56:55 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34267)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fVDNe-00065C-KV
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 05:56:54 -0400
Received: by mail-wm0-x242.google.com with SMTP id l15-v6so18192158wmc.1
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 02:56:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180618214604.6777-1-jusual@mail.ru>
References: <20180618214604.6777-1-jusual@mail.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 19 Jun 2018 10:56:52 +0100
Message-ID: <CAJSP0QVOU4y-g47bd-TzHO4m0xEtLa9uqJ=R5wmfjtz-62Q9Vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Minor cleanup for ARMv6-M
 32-bit instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Julia Suvorova <jusual@mail.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <mail@steffen-goertz.de>, Richard Henderson <richard.henderson@linaro.org>

On Mon, Jun 18, 2018 at 10:46 PM, Julia Suvorova <jusual@mail.ru> wrote:
> The arrays were made static, "if" was simplified because V7M and V8M
> define V6 feature.
>
> Signed-off-by: Julia Suvorova <jusual@mail.ru>
> ---
>  target/arm/translate.c | 27 +++++++++++++--------------
>  1 file changed, 13 insertions(+), 14 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
