Received: from eggs.gnu.org ([2001:4830:134:3::10]:49289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dThU3-0002o4-Ux
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 00:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dThTz-0007WH-4S
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 00:36:44 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dThTy-0007Vq-W5
	for qemu-devel@nongnu.org; Sat, 08 Jul 2017 00:36:39 -0400
Received: by mail-qt0-x242.google.com with SMTP id w12so6606260qta.2
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 21:36:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1499453787.git.alistair.francis@xilinx.com>
	<ba517a52c280fdd1768d2a16deeb5a5745dc99c3.1499453788.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <91c12caa-f94e-6bf4-165f-4bfaea6fa81d@amsat.org>
Date: Sat, 8 Jul 2017 01:36:32 -0300
MIME-Version: 1.0
In-Reply-To: <ba517a52c280fdd1768d2a16deeb5a5745dc99c3.1499453788.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 8/8] error: Add a 'error: ' prefix to
 error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, philippe@mathieu-daude.net, berrange@redhat.com, armbru@redhat.com

On 07/07/2017 08:21 PM, Alistair Francis wrote:
> As we don't regard error messages as a stable API the let's add a
> 'error: ' prefix to the original error_report() messages.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 
>   util/qemu-error.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/util/qemu-error.c b/util/qemu-error.c
> index b555247e24..cf1eb8e8b9 100644
> --- a/util/qemu-error.c
> +++ b/util/qemu-error.c
> @@ -202,6 +202,7 @@ static void vreport(report_type type, const char *fmt, va_list ap)
>   
>       switch (type) {
>       case REPORT_TYPE_ERROR:
> +        error_printf("error: ");
>           break;
>       case REPORT_TYPE_WARNING:
>           error_printf("warning: ");
> 
