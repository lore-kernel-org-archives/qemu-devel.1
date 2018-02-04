Received: from eggs.gnu.org ([2001:4830:134:3::10]:48712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eiFIL-0000Qg-0L
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 03:05:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eiFIH-0004YF-T6
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 03:05:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42344)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1eiFIH-0004Wd-NP
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 03:04:57 -0500
References: <20180204064911.9828-1-richard.henderson@linaro.org>
	<20180204064911.9828-2-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6eb74470-e1e9-b51a-edd4-f7158dfa88d8@redhat.com>
Date: Sun, 4 Feb 2018 09:04:54 +0100
MIME-Version: 1.0
In-Reply-To: <20180204064911.9828-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] tests: Enable boot-serial-test for hppa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 04.02.2018 07:49, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/boot-serial-test.c | 1 +
>  tests/Makefile.include   | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index 418c5b92dc..ea87a80be7 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -87,6 +87,7 @@ static testdef_t tests[] = {
>        sizeof(kernel_plml605), kernel_plml605 },
>      { "moxie", "moxiesim", "", "TT", sizeof(bios_moxiesim), 0, bios_moxiesim },
>      { "arm", "raspi2", "", "TT", sizeof(bios_raspi2), 0, bios_raspi2 },
> +    { "hppa", "hppa", "", "SeaBIOS wants SYSTEM HALT" },

Fine for me, too.

Reviewed-by: Thomas Huth <thuth@redhat.com>
