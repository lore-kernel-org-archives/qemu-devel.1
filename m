Received: from eggs.gnu.org ([2001:4830:134:3::10]:53537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNRyO-0004lE-Br
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 18:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNRyL-0000sg-A3
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 18:50:12 -0400
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:32822)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNRyL-0000sa-5p
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 18:50:09 -0400
Received: by mail-qk0-x22a.google.com with SMTP id r62so69804231qkf.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 15:50:09 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170620205121.26515-1-laurent@vivier.eu>
	<20170620205121.26515-4-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5cae3e4b-5f55-f2e1-91d1-9b7f7c1b8ef1@twiddle.net>
Date: Tue, 20 Jun 2017 15:50:05 -0700
MIME-Version: 1.0
In-Reply-To: <20170620205121.26515-4-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 3/6] target-m68k: use floatx80 internally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 06/20/2017 01:51 PM, Laurent Vivier wrote:
> Coldfire uses float64, but 680x0 use floatx80.
> This patch introduces the use of floatx80 internally
> and enables 680x0 80bits FPU.
> 
> Signed-off-by: Laurent Vivier<laurent@vivier.eu>
> ---

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
