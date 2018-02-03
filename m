Received: from eggs.gnu.org ([2001:4830:134:3::10]:53406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvOG-0003sL-S3
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:49:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvOD-0007eA-R3
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:49:48 -0500
Received: from chuckie.co.uk ([82.165.15.123]:36294
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ehvOD-0007dY-H4
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:49:45 -0500
References: <1517479750-16770-1-git-send-email-thuth@redhat.com>
	<1517479750-16770-2-git-send-email-thuth@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <983bf0d2-c94c-23b2-a91d-127ce3fbfec1@ilande.co.uk>
Date: Sat, 3 Feb 2018 10:49:36 +0000
MIME-Version: 1.0
In-Reply-To: <1517479750-16770-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] tests/boot-serial: Enable the
 boot-serial test on SPARC machines, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

On 01/02/18 10:09, Thomas Huth wrote:
> OpenBIOS prints out the name of the detected CPU here, so looking for
> this string is a nice test to verify that the CPU detection is still
> working correctly.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/Makefile.include   | 2 ++
>   tests/boot-serial-test.c | 4 ++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index ca82e0c..0b98dd7 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -350,11 +350,13 @@ check-qtest-sh4eb-y = tests/endianness-test$(EXESUF)
>   check-qtest-sparc-y = tests/prom-env-test$(EXESUF)
>   #check-qtest-sparc-y += tests/m48t59-test$(EXESUF)
>   #gcov-files-sparc-y = hw/timer/m48t59.c
> +check-qtest-sparc-y += tests/boot-serial-test$(EXESUF)
>   
>   check-qtest-sparc64-y = tests/endianness-test$(EXESUF)
>   #check-qtest-sparc64-y += tests/m48t59-test$(EXESUF)
>   #gcov-files-sparc64-y += hw/timer/m48t59.c
>   check-qtest-sparc64-y += tests/prom-env-test$(EXESUF)
> +check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)
>   
>   check-qtest-arm-y = tests/tmp105-test$(EXESUF)
>   check-qtest-arm-y += tests/ds1338-test$(EXESUF)
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index 418c5b9..abc7f2d 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -78,6 +78,10 @@ static testdef_t tests[] = {
>       { "i386", "q35", "-device sga", "SGABIOS" },
>       { "x86_64", "isapc", "-cpu qemu32 -device sga", "SGABIOS" },
>       { "x86_64", "q35", "-device sga", "SGABIOS" },
> +    { "sparc", "LX", "", "TMS390S10" },
> +    { "sparc", "SS-4", "", "MB86904" },
> +    { "sparc", "SS-600MP", "", "TMS390Z55" },
> +    { "sparc64", "sun4u", "", "UltraSPARC" },
>       { "s390x", "s390-ccw-virtio",
>         "-nodefaults -device sclpconsole,chardev=serial0", "virtio device" },
>       { "m68k", "mcf5208evb", "", "TT", sizeof(kernel_mcf5208), kernel_mcf5208 },
> 

Why not?

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
