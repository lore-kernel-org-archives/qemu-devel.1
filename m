Received: from eggs.gnu.org ([209.51.188.92]:60921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLr31-0002GL-8p
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:21:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLr2x-0007IF-Os
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:21:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLr2x-0007HU-JQ
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:21:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id e9so400062wrc.1
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 08:21:23 -0700 (PDT)
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<ff51c73e3095fa503d14aafece54f8565fe99900.1556666645.git.alistair.francis@wdc.com>
	<0d585793-20a8-8dc8-98fa-13789113f672@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9abcc3db-0749-e092-ab59-8144de027ba6@redhat.com>
Date: Wed, 1 May 2019 17:21:21 +0200
MIME-Version: 1.0
In-Reply-To: <0d585793-20a8-8dc8-98fa-13789113f672@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, "alistair23@gmail.com" <alistair23@gmail.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>, "kraxel@redhat.com" <kraxel@redhat.com>

On 5/1/19 4:12 PM, Richard Henderson wrote:
> On 4/30/19 4:28 PM, Alistair Francis wrote:
>>      for (i = 0; i < usbports; i++) {
>> +        g_assert(i < MAX(MAXPORTS_2, MAXPORTS_3));
> 
> I would hope that it works to move this out of the loop:
> 
>   g_assert(usbports <= MAX(MAXPORTS_2, MAXPORTS_3));

With Richard suggestion:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
