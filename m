Received: from eggs.gnu.org ([2001:4830:134:3::10]:45262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvgmm-0007eB-Lc
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:36:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fvgmj-0000jy-9J
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 06:36:16 -0400
References: <CGME20180831102306eucas1p1ffbf82383f23675fecb5faf8a2fa54d7@eucas1p1.samsung.com>
	<9310418.Wg32kryeWE@amdc3058>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2fa9fc91-5d5d-20ad-78e9-dd9caa922138@redhat.com>
Date: Fri, 31 Aug 2018 12:31:00 +0200
MIME-Version: 1.0
In-Reply-To: <9310418.Wg32kryeWE@amdc3058>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm/exynos4210: fix Exynos4210 UART
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 2018-08-31 12:23, Bartlomiej Zolnierkiewicz wrote:
> commit 97274d0c05d4 ("hw/char/exynos4210_uart.c: Remove unneeded
> handling of NULL chardev") broke Exynos4210 support as it removed
> NULL 'Chardev *chr' handling from exynos4210_uart_create() and
> currently exynos4210_init() always passes NULL as 'Chardev *chr'
> argument to exynos4210_uart_create() calls. Fix it by adding
> missing serial_hd() calls to exynos4210_init().
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  hw/arm/exynos4210.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

PS: If you've got some spare time, maybe you could consider to also
write a regression test (e.g. for tests/boot-serial-test.c) to avoid
that this happens again?
