Received: from eggs.gnu.org ([2001:4830:134:3::10]:32813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqxCj-0002WM-FZ
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 05:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fqxCg-0001my-Bp
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 05:07:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42054 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fqxCg-0001m6-6z
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 05:07:26 -0400
References: <20180817161404.9420-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0e358562-7607-9c27-d452-57e3dc32806e@redhat.com>
Date: Sat, 18 Aug 2018 11:07:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180817161404.9420-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: patches@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 2018-08-17 18:14, Peter Maydell wrote:
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

6 minutes is really a lot already. I guess most users will hit CTRL-C
before waiting so long if there is a realy problem here ... If the
current tests just takes a little bit more than 1 minute on the Sparc
machine, maybe 2 or 3 minutes would sufficient, too?

 Thomas
