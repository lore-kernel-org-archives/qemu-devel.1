Received: from eggs.gnu.org ([209.51.188.92]:48120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLpy6-0008Ht-Qm
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:12:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLpy3-0003xs-5T
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:12:18 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:35065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLpy3-0003x9-0C
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:12:15 -0400
Received: by mail-pl1-x62d.google.com with SMTP id w24so8266857plp.2
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:12:14 -0700 (PDT)
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<ff51c73e3095fa503d14aafece54f8565fe99900.1556666645.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0d585793-20a8-8dc8-98fa-13789113f672@linaro.org>
Date: Wed, 1 May 2019 07:12:10 -0700
MIME-Version: 1.0
In-Reply-To: <ff51c73e3095fa503d14aafece54f8565fe99900.1556666645.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] hw/usb/hcd-xhci: Fix GCC 9 build
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>, "kraxel@redhat.com" <kraxel@redhat.com>, "alistair23@gmail.com" <alistair23@gmail.com>

On 4/30/19 4:28 PM, Alistair Francis wrote:
>      for (i = 0; i < usbports; i++) {
> +        g_assert(i < MAX(MAXPORTS_2, MAXPORTS_3));

I would hope that it works to move this out of the loop:

  g_assert(usbports <= MAX(MAXPORTS_2, MAXPORTS_3));


r~
