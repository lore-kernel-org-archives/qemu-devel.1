Received: from eggs.gnu.org ([2001:4830:134:3::10]:42316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cKpyC-0006UM-CG
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 12:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1cKpy9-00017m-7b
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 12:18:56 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:32966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mar.krzeminski@gmail.com>)
	id 1cKpy9-00017g-05
	for qemu-devel@nongnu.org; Sat, 24 Dec 2016 12:18:53 -0500
Received: by mail-lf0-x244.google.com with SMTP id y21so22282820lfa.0
	for <qemu-devel@nongnu.org>; Sat, 24 Dec 2016 09:18:52 -0800 (PST)
References: <20161224151113.23955-1-jcd@tribudubois.net>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <606aedd3-2f56-fb89-b547-763baf833ed5@gmail.com>
Date: Sat, 24 Dec 2016 18:18:48 +0100
MIME-Version: 1.0
In-Reply-To: <20161224151113.23955-1-jcd@tribudubois.net>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] [M25P80] Make sure not to overrun the
 internal data buffer.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-devel@nongnu.org, peter.maydell@linaro.org

Hello,

W dniu 24.12.2016 o 16:11, Jean-Christophe Dubois pisze:
> It did happen that the internal data buffer was overrun leading to a Qemu
> crash (in particular while emulating the i.MX6 sabrelite board).
>
> This patch makes sure the data array would not be overrun and allow the
> sabrelite emulation to run without crash.
>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> ---
>   hw/block/m25p80.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index d29ff4c..a1c4e5d 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -1117,7 +1117,7 @@ static uint32_t m25p80_transfer8(SSISlave *ss, uint32_t tx)
>           s->data[s->len] = (uint8_t)tx;
>           s->len++;
>   
> -        if (s->len == s->needed_bytes) {
> +        if ((s->len >= s->needed_bytes) || (s->len >= sizeof(s->data))) {
>               complete_collecting_data(s);
>           }
>           break;
Do you have exact scenario that caused the problem?
Generally it should not happen.

Thanks,
Marcin
