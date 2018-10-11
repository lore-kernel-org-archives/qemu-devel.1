Received: from eggs.gnu.org ([2001:4830:134:3::10]:44280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAaF5-0006qQ-VX
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gAaF2-0003rW-RW
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:39:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gAaF2-0003qr-96
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 08:39:00 -0400
Received: by mail-wr1-f66.google.com with SMTP id a13-v6so9518467wrt.5
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 05:39:00 -0700 (PDT)
References: <20181011112436.9305-1-ppandit@redhat.com>
	<a5508166-efdc-d1d9-0fe1-9acb1f590633@redhat.com>
	<nycvar.YSQ.7.76.1810111749490.9486@xnncv>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0373c040-df0f-0c22-4e85-227e1d51749f@redhat.com>
Date: Thu, 11 Oct 2018 14:38:57 +0200
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1810111749490.9486@xnncv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] ccid-card-passthru: check buffer size
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Arash TC <tohidi.arash@gmail.com>

On 11/10/2018 14:29, P J P wrote:
> +-- On Thu, 11 Oct 2018, Philippe Mathieu-Daudé wrote --+
> | The IOReadHandler does not have documentation.
> | 
> |  typedef void IOReadHandler(void *opaque, const uint8_t *buf, int size);
> | 
> | Why is the 'size' argument signed? Does it makes sens to call it with a
> | negative value?
> 
>   No, it doesn't IMO. I had first changed argument type 'int' to uint32_t'.
> as
> 
>   typedef void IOReadHandler(void *opaque, const uint8_t *buf, uint32_t size);
> 
> But 'IOReadHandler' is registered and called from multiple char devices, 
> which lead to compile time errors. As the function prototype changed.
> 
> I'll update them all, if the above change is okay.

I started this change and already converted 40 files.
