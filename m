Received: from eggs.gnu.org ([2001:4830:134:3::10]:52950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1fkXeC-0006Ue-Jl
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 12:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1fkXe8-0005yh-Jm
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 12:37:20 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:40844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rob@landley.net>) id 1fkXe8-0005yU-9n
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 12:37:16 -0400
Received: by mail-oi0-x242.google.com with SMTP id w126-v6so29125815oie.7
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 09:37:15 -0700 (PDT)
References: <20180730130234.30020-1-geert+renesas@glider.be>
	<1115027626.150336.1532963923061@webmail.strato.com>
From: Rob Landley <rob@landley.net>
Message-ID: <97622558-a520-6ab2-b61f-8038ae61b451@landley.net>
Date: Tue, 31 Jul 2018 11:36:46 -0500
MIME-Version: 1.0
In-Reply-To: <1115027626.150336.1532963923061@webmail.strato.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH QEMU] hw/char/sh_serial: Add timeout
 handling to unbreak serial input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ulrich Hecht <uli@fpond.eu>, Geert Uytterhoeven <geert+renesas@glider.be>, Peter Maydell <peter.maydell@linaro.org>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

On 07/30/2018 10:18 AM, Ulrich Hecht wrote:>> On July 30, 2018 at 3:02 PM Geert
Uytterhoeven <geert+renesas@glider.be> wrote:
>> Fix this by adding basic timeout handling.  As the QEMU SCIF emulation
>> ignores any serial speed programming, the timeout value used conforms to
>> a default speed of 9600 bps, which is fine for any interative console.
>>
>> Reported-by: Rob Landley <rob@landley.net>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Works for me, kernel 4.18-rc7 for rts7751r2dplus.

Works for me too.

Tested-by: Rob Landley <rob@landley.net>

Rob
