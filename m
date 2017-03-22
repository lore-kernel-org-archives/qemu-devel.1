Received: from eggs.gnu.org ([2001:4830:134:3::10]:50744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cqjEt-0006ll-OO
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cqjEs-0008Gz-T9
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 12:35:59 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1490152052-9660-1-git-send-email-jasowang@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c04befb5-7bb6-1594-8118-f338a3c9eea6@amsat.org>
Date: Wed, 22 Mar 2017 13:35:51 -0300
MIME-Version: 1.0
In-Reply-To: <1490152052-9660-1-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] e1000: disable debug by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Cc: Leonid Bloch <leonid.bloch@ravellosystems.com>, Peter Maydell <peter.maydell@linaro.org>, Dmitry Fleytman <dmitry.fleytman@ravellosystems.com>, qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>

On 03/22/2017 12:07 AM, Jason Wang wrote:
> Disable debug output by default, the information were not needed for
> release.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Stefan Hajnoczi <stefanha@gmail.com>
> Cc: Leonid Bloch <leonid.bloch@ravellosystems.com>
> Cc: Dmitry Fleytman <dmitry.fleytman@ravellosystems.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/net/e1000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index 9324949..f2e5072 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -40,7 +40,7 @@
>
>  static const uint8_t bcast[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
>
> -#define E1000_DEBUG
> +/* #define E1000_DEBUG */
>
>  #ifdef E1000_DEBUG
>  enum {
>
