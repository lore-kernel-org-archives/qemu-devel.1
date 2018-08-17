Received: from eggs.gnu.org ([2001:4830:134:3::10]:38916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fqiZp-0006bd-Sn
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fqiZf-0003RH-Sb
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:30:18 -0400
Received: from chuckie.co.uk ([82.165.15.123]:37538
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fqiZT-0003GR-DN
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:30:01 -0400
References: <20180817161404.9420-1-peter.maydell@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <18149229-d8e4-b469-b0f5-f074a97e0806@ilande.co.uk>
Date: Fri, 17 Aug 2018 18:29:44 +0100
MIME-Version: 1.0
In-Reply-To: <20180817161404.9420-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests/boot-serial-test: Bump timeout to 6
 minutes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, patches@linaro.org

On 17/08/18 17:14, Peter Maydell wrote:

> On a SPARC host that I'm using as a build test machine, the
> boot-serial-test for the SPARC guest machines takes about 65
> seconds to execute. This means that it hits the current
> 60 second timer on these tests. Push the timeout up so
> that it doesn't trigger spuriously on slow hosts like this one.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/boot-serial-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index 1355df924dd..fca5f2f5da9 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -116,8 +116,8 @@ static bool check_guest_output(const testdef_t *test, int fd)
>      int i, nbr = 0, pos = 0, ccnt;
>      char ch;
>  
> -    /* Poll serial output... Wait at most 60 seconds */
> -    for (i = 0; i < 6000; ++i) {
> +    /* Poll serial output... Wait at most 360 seconds */
> +    for (i = 0; i < 36000; ++i) {
>          ccnt = 0;
>          while (ccnt++ < 512 && (nbr = read(fd, &ch, 1)) == 1) {
>              if (ch == test->expect[pos]) {

Wow that is amazingly slow... however I guess it's not completely
unreasonable to increase the timeout accordingly.

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
