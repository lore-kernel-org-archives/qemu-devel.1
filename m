Received: from eggs.gnu.org ([2001:4830:134:3::10]:52096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVs2k-0005XN-2W
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dVs2j-0001Mt-1Z
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 00:17:30 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
	<20170713163219.9024-6-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <41cf79c5-2042-a011-4162-b85dfcdd5af3@amsat.org>
Date: Fri, 14 Jul 2017 01:17:20 -0300
MIME-Version: 1.0
In-Reply-To: <20170713163219.9024-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v2 05/29] i8254: use
 QEMU_ALIGN_DOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 07/13/2017 01:31 PM, Marc-André Lureau wrote:
> I used the clang-tidy qemu-round check to generate the fix:
> https://github.com/elmarco/clang-tools-extra
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/timer/i8254_common.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
> index 976d5200f1..ee064aa819 100644
> --- a/hw/timer/i8254_common.c
> +++ b/hw/timer/i8254_common.c
> @@ -93,7 +93,7 @@ int64_t pit_get_next_transition_time(PITChannelState *s, int64_t current_time)
>           }
>           break;
>       case 2:
> -        base = (d / s->count) * s->count;
> +        base = QEMU_ALIGN_DOWN(d, s->count);
>           if ((d - base) == 0 && d != 0) {
>               next_time = base + s->count;
>           } else {
> @@ -101,7 +101,7 @@ int64_t pit_get_next_transition_time(PITChannelState *s, int64_t current_time)
>           }
>           break;
>       case 3:
> -        base = (d / s->count) * s->count;
> +        base = QEMU_ALIGN_DOWN(d, s->count);
>           period2 = ((s->count + 1) >> 1);
>           if ((d - base) < period2) {
>               next_time = base + period2;
> 
