Received: from eggs.gnu.org ([2001:4830:134:3::10]:48263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87TH-0005oM-Is
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:27:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87TE-00028p-DA
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:26:59 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:55785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87TE-00028U-9D
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:26:56 -0400
Received: by mail-qk0-x241.google.com with SMTP id x82so8981088qkb.12
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 09:26:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508006342-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508006342-5304-3-git-send-email-mark.cave-ayland@ilande.co.uk>
	<fab45917-6f63-c2d2-8875-cb33b09f9bc8@amsat.org>
	<822b62ef-8446-c8e5-6d1c-731923fb5823@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4c648222-7342-7678-b936-2e3cbbe46802@amsat.org>
Date: Fri, 27 Oct 2017 13:26:53 -0300
MIME-Version: 1.0
In-Reply-To: <822b62ef-8446-c8e5-6d1c-731923fb5823@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv3 02/13] sparc32_dma: split esp and le into
 separate DMA devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 10/20/2017 09:41 AM, Mark Cave-Ayland wrote:
>>> -    dev = qdev_create(NULL, "sparc32-dma-device");
>>> +    dev = qdev_create(NULL, is_ledma ? "sparc32-ledma" : "sparc32-espdma");
>>
>> TYPE_SPARC32_LEDMA_DEVICE and TYPE_SPARC32_ESPDMA_DEVICE?
> 
> Again please note that this patch is an intermediate step and the type
> is switched over to use the macro later in the patchset when the type
> macro is eventually moved over to sparc32_dma.h.

Oops sorry! I missed this mail while reviewing your v4.
