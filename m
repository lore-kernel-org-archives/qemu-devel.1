Received: from eggs.gnu.org ([2001:4830:134:3::10]:33144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cT8mZ-0002Xk-2q
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 10:01:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cT8mY-0003k2-FE
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 10:01:15 -0500
Received: from mail-ua0-x236.google.com ([2607:f8b0:400c:c08::236]:33924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cT8mY-0003ji-BG
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 10:01:14 -0500
Received: by mail-ua0-x236.google.com with SMTP id 35so82933634uak.1
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 07:01:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170105043430.3176-5-alastair@au1.ibm.com>
References: <20170105043430.3176-1-alastair@au1.ibm.com>
	<20170105043430.3176-5-alastair@au1.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jan 2017 15:00:53 +0000
Message-ID: <CAFEAcA-M27cxOkJd8VJubAtjRwjsT0Lnt3Ybh+3Raw8eh2jdpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v5 4/7] qtest: Fix whitespace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alastair D'Silva <alastair@au1.ibm.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, Alastair D'Silva <alastair@d-silva.org>

On 5 January 2017 at 04:34, Alastair D'Silva <alastair@au1.ibm.com> wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
>
> Fix 2 cases of incorrect indentation
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  qtest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/qtest.c b/qtest.c
> index a947892..143077e 100644
> --- a/qtest.c
> +++ b/qtest.c
> @@ -309,7 +309,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>          if (!dev) {
>              qtest_send_prefix(chr);
>              qtest_send(chr, "FAIL Unknown device\n");
> -           return;
> +            return;
>          }
>
>          if (irq_intercept_dev) {
> @@ -319,7 +319,7 @@ static void qtest_process_command(CharBackend *chr, gchar **words)
>              } else {
>                  qtest_send(chr, "OK\n");
>              }
> -           return;
> +            return;
>          }
>
>          QLIST_FOREACH(ngl, &dev->gpios, node) {

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
