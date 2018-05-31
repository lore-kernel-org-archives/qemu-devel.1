Received: from eggs.gnu.org ([2001:4830:134:3::10]:45529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOS04-0004Vn-UM
	for qemu-devel@nongnu.org; Thu, 31 May 2018 14:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOS03-0002P3-Vd
	for qemu-devel@nongnu.org; Thu, 31 May 2018 14:08:36 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180531171253.21012-1-pbonzini@redhat.com>
	<20180531171253.21012-31-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <49f69362-c364-4084-233e-2ef6db7e5603@amsat.org>
Date: Thu, 31 May 2018 15:08:27 -0300
MIME-Version: 1.0
In-Reply-To: <20180531171253.21012-31-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 30/53] hw/isa/superio: Fix inconsistent use
 of Chardev->be
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

Hi Paolo, something messed with UTF-8...

On 05/31/2018 02:12 PM, Paolo Bonzini wrote:
> From: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> 4c3119a6e3e and cd9526ab7c0 introduced an incorrect and inconsistent
> use of Chardev->be. Also, this CharBackend member is private and is
> not supposed to be accessible.
> 
> Fix it by removing the inconsistent check.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Marc-AndrÃ© Lureau <marcandre.lureau@redhat.com>

Marc-André Lureau

> Signed-off-by: Philippe Mathieu-DaudÃ© <f4bug@amsat.org>

Philippe Mathieu-Daudé

> Message-Id: <20180515152500.19460-2-f4bug@amsat.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Correct.

> ---
>  hw/isa/isa-superio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
> index 9359be7008..8bc2f69eaa 100644
> --- a/hw/isa/isa-superio.c
> +++ b/hw/isa/isa-superio.c
> @@ -42,7 +42,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
>          if (!k->parallel.is_enabled || k->parallel.is_enabled(sio, i)) {
>              /* FIXME use a qdev chardev prop instead of parallel_hds[] */
>              chr = parallel_hds[i];
> -            if (chr == NULL || chr->be) {
> +            if (chr == NULL) {
>                  name = g_strdup_printf("discarding-parallel%d", i);
>                  chr = qemu_chr_new(name, "null");
>              } else {
> @@ -82,7 +82,7 @@ static void isa_superio_realize(DeviceState *dev, Error **errp)
>          if (!k->serial.is_enabled || k->serial.is_enabled(sio, i)) {
>              /* FIXME use a qdev chardev prop instead of serial_hd() */
>              chr = serial_hd(i);
> -            if (chr == NULL || chr->be) {
> +            if (chr == NULL) {
>                  name = g_strdup_printf("discarding-serial%d", i);
>                  chr = qemu_chr_new(name, "null");
>              } else {
> 
