Received: from eggs.gnu.org ([2001:4830:134:3::10]:53677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvOo-0004Qe-5e
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:50:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ehvOk-0007vM-Tx
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:50:22 -0500
Received: from chuckie.co.uk ([82.165.15.123]:36300
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ehvOk-0007ro-F9
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 05:50:18 -0500
References: <1517479750-16770-1-git-send-email-thuth@redhat.com>
	<1517479750-16770-3-git-send-email-thuth@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <7062c07a-80c3-b1b9-ea9f-97e3bd677ce0@ilande.co.uk>
Date: Sat, 3 Feb 2018 10:50:10 +0000
MIME-Version: 1.0
In-Reply-To: <1517479750-16770-3-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] tests/boot-serial: Add tests for
 PowerPC Mac machines
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
> OpenBIOS prints out the CPU type on these machine types, so we can use
> this string to test whether the CPU detection is working correctly.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/boot-serial-test.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index abc7f2d..12bf6ec 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -69,8 +69,11 @@ static testdef_t tests[] = {
>       { "alpha", "clipper", "", "PCI:" },
>       { "ppc", "ppce500", "", "U-Boot" },
>       { "ppc", "prep", "", "Open Hack'Ware BIOS" },
> +    { "ppc", "g3beige", "", "PowerPC,750" },
> +    { "ppc", "mac99", "", "PowerPC,G4" },
>       { "ppc64", "ppce500", "", "U-Boot" },
>       { "ppc64", "prep", "", "Open Hack'Ware BIOS" },
> +    { "ppc64", "mac99", "", "PowerPC,970FX" },
>       { "ppc64", "pseries", "", "Open Firmware" },
>       { "ppc64", "powernv", "-cpu POWER8", "OPAL" },
>       { "i386", "isapc", "-cpu qemu32 -device sga", "SGABIOS" },
> 

Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
