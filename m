Received: from eggs.gnu.org ([2001:4830:134:3::10]:50218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvHLW-0006ZG-DU
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 02:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvHLS-0006l0-Eu
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 02:21:54 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:37704)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvHLS-0006ks-AA
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 02:21:50 -0400
Received: by mail-qt0-x244.google.com with SMTP id u48so102673qtc.4
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 23:21:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506049617-25716-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <df8f9d2e-9b89-f5b2-3f2e-222cd08ff8df@amsat.org>
Date: Fri, 22 Sep 2017 03:21:45 -0300
MIME-Version: 1.0
In-Reply-To: <1506049617-25716-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests/boot-sector: Increase timeout to 600
 seconds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>, Victor Kaplansky <victork@redhat.com>

Hi Thomas,

On 09/22/2017 12:06 AM, Thomas Huth wrote:
> If QEMU has been compiled with the flags --enable-tcg-interpreter and
> --enable-debug, the guest is running incredibly slow. The pxe boot test

There already is a qtest_get_arch(), it might be convenient to have a 
qtest_get_accel() at some point.

> can take up to 400 seconds when testing the pseries ppc64 machine. While
> we should still look for ways to speed up the test on the pseries machine,
> it's better to increase the timeout in this test to 600 seconds anyway to
> allow the test to pass successfully now with this unusal configuration
> already.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/boot-sector.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/boot-sector.c b/tests/boot-sector.c
> index 9ee8537..be29d5b 100644
> --- a/tests/boot-sector.c
> +++ b/tests/boot-sector.c
> @@ -137,9 +137,9 @@ void boot_sector_test(void)
>       uint16_t signature;
>       int i;
>   
> -    /* Wait at most 90 seconds */
> +    /* Wait at most 600 seconds (test is slow with TCI and --enable-debug) */
>   #define TEST_DELAY (1 * G_USEC_PER_SEC / 10)
> -#define TEST_CYCLES MAX((90 * G_USEC_PER_SEC / TEST_DELAY), 1)
> +#define TEST_CYCLES MAX((600 * G_USEC_PER_SEC / TEST_DELAY), 1)
>   
>       /* Poll until code has run and modified memory.  Once it has we know BIOS
>        * initialization is done.  TODO: check that IP reached the halt
> 
