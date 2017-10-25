Received: from eggs.gnu.org ([2001:4830:134:3::10]:43707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1e7Q0H-0007P7-Ij
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 14:02:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mar.krzeminski@gmail.com>) id 1e7Q0C-0000jm-EZ
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 14:02:09 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:54258)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mar.krzeminski@gmail.com>)
	id 1e7Q0C-0000j8-73
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 14:02:04 -0400
Received: by mail-lf0-x243.google.com with SMTP id l23so909152lfk.10
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 11:02:04 -0700 (PDT)
References: <20171024195139.28179-1-frasse.iglesias@gmail.com>
	<20171024195139.28179-5-frasse.iglesias@gmail.com>
From: "mar.krzeminski" <mar.krzeminski@gmail.com>
Message-ID: <db96b998-2cd6-d8ec-2d26-1a031d39f189@gmail.com>
Date: Wed, 25 Oct 2017 20:02:00 +0200
MIME-Version: 1.0
In-Reply-To: <20171024195139.28179-5-frasse.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: pl
Subject: Re: [Qemu-devel] [PATCH v3 04/13] m25p80: Add support for
 n25q512a11 and n25q512a13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Francisco Iglesias <frasse.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: edgari@xilinx.com, alistai@xilinx.com, francisco.iglesias@feimtech.se



W dniu 24.10.2017 o 21:51, Francisco Iglesias pisze:
> Add support for Micron (Numonyx) n25q512a11 and n25q512a13 flashes.
>
> Signed-off-by: Francisco Iglesias <frasse.iglesias@gmail.com>
Acked-by: Marcin Krzemiński <mar.krzeminski@gmail.com>
> ---
>   hw/block/m25p80.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 3d2975c..7f3fcc4 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -240,6 +240,8 @@ static const FlashPartInfo known_devices[] = {
>       { INFO("n25q128a13",  0x20ba18,      0,  64 << 10, 256, ER_4K) },
>       { INFO("n25q256a11",  0x20bb19,      0,  64 << 10, 512, ER_4K) },
>       { INFO("n25q256a13",  0x20ba19,      0,  64 << 10, 512, ER_4K) },
> +    { INFO("n25q512a11",  0x20bb20,      0,  64 << 10, 1024, ER_4K) },
> +    { INFO("n25q512a13",  0x20ba20,      0,  64 << 10, 1024, ER_4K) },
>       { INFO("n25q128",     0x20ba18,      0,  64 << 10, 256, 0) },
>       { INFO("n25q256a",    0x20ba19,      0,  64 << 10, 512, ER_4K) },
>       { INFO("n25q512a",    0x20ba20,      0,  64 << 10, 1024, ER_4K) },
