Received: from eggs.gnu.org ([2001:4830:134:3::10]:54297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emLGa-0004gV-Av
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:16:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emLGW-00029z-Ae
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:16:08 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:41538)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emLGW-00029j-5Q
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:16:04 -0500
Received: by mail-qk0-x243.google.com with SMTP id h129so11333162qke.8
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 07:16:04 -0800 (PST)
Received: from [192.168.1.11] ([138.117.48.219])
	by smtp.gmail.com with ESMTPSA id
	d20sm10565199qtn.61.2018.02.15.07.16.02 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 15 Feb 2018 07:16:03 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-29-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2209ed17-849f-2449-ffe4-262f6e66f4d8@amsat.org>
Date: Thu, 15 Feb 2018 12:16:01 -0300
MIME-Version: 1.0
In-Reply-To: <20180215042900.16078-29-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 28/30] ivshmem: use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 02/15/2018 01:28 AM, Philippe Mathieu-Daudé wrote:
> It ease code review, unit is explicit.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/misc/ivshmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
> index 16f03701b7..9b3ad96471 100644
> --- a/hw/misc/ivshmem.c
> +++ b/hw/misc/ivshmem.c
> @@ -1302,7 +1302,7 @@ static void ivshmem_realize(PCIDevice *dev, Error **errp)
>      }
>  
>      if (s->sizearg == NULL) {
> -        s->legacy_size = 4 << 20; /* 4 MB default */
> +        s->legacy_size = 4 * M_BYTE; /* 4 MB default */
>      } else {
>          int ret;
>          uint64_t size;
> 
