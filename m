Received: from eggs.gnu.org ([2001:4830:134:3::10]:48625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTQT-0003cr-Jn
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTQQ-00041V-Rj
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:52:13 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:50428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dyTQQ-000412-NV
	for qemu-devel@nongnu.org; Sat, 30 Sep 2017 21:52:10 -0400
Received: by mail-qt0-x244.google.com with SMTP id f15so3724464qtf.7
	for <qemu-devel@nongnu.org>; Sat, 30 Sep 2017 18:52:10 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1506730372.git.alistair.francis@xilinx.com>
	<97f16c1f24f227db9f6a3dfac79aeccae9529caa.1506730372.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a8121136-d27b-ae0c-2849-2d71a1ed85f5@amsat.org>
Date: Sat, 30 Sep 2017 22:52:06 -0300
MIME-Version: 1.0
In-Reply-To: <97f16c1f24f227db9f6a3dfac79aeccae9529caa.1506730372.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 14/47] hw/i2c: Replace fprintf(stderr,
 "*\n" with error_report()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, armbru@redhat.com
List-ID: <qemu-devel.nongnu.org>

On 09/29/2017 09:15 PM, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
> 
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N;N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> find ./* -type f -exec sed -i \
>      'N; {s|fprintf(stderr, "\(.*\)\\n"\(.*\));|error_report("\1"\2);|Ig}' \
>      {} +
> 
> Some lines where then manually tweaked to pass checkpatch.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> V2:
>   - Split hw patch into individual directories
> 
>   hw/i2c/omap_i2c.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/i2c/omap_i2c.c b/hw/i2c/omap_i2c.c
> index 26e3e5ebf6..c89664f342 100644
> --- a/hw/i2c/omap_i2c.c
> +++ b/hw/i2c/omap_i2c.c
> @@ -340,13 +340,13 @@ static void omap_i2c_write(void *opaque, hwaddr addr,
>               break;
>           }
>           if ((value & (1 << 15)) && !(value & (1 << 10))) {	/* MST */
> -            fprintf(stderr, "%s: I^2C slave mode not supported\n",
> -                            __func__);
> +            error_report("%s: I^2C slave mode not supported",
> +                         __func__);

Can you change by "i2c slave ..." instead?

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>               break;
>           }
>           if ((value & (1 << 15)) && value & (1 << 8)) {		/* XA */
> -            fprintf(stderr, "%s: 10-bit addressing mode not supported\n",
> -                            __func__);
> +            error_report("%s: 10-bit addressing mode not supported",
> +                         __func__);
>               break;
>           }
>           if ((value & (1 << 15)) && value & (1 << 0)) {		/* STT */
> @@ -393,7 +393,7 @@ static void omap_i2c_write(void *opaque, hwaddr addr,
>                   omap_i2c_interrupts_update(s);
>               }
>           if (value & (1 << 15))					/* ST_EN */
> -            fprintf(stderr, "%s: System Test not supported\n", __func__);
> +            error_report("%s: System Test not supported", __func__);
>           break;
>   
>       default:
> 
