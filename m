Received: from eggs.gnu.org ([2001:4830:134:3::10]:34629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXLzB-0008Hr-0J
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:27:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXLz6-0007AB-4s
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:27:57 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:36060)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXLz5-00079j-Ul
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 02:27:52 -0400
Received: by mail-pg0-x230.google.com with SMTP id u5so7013832pgq.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 23:27:51 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170718045540.16322-1-f4bug@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <2634069a-1329-ba8e-165c-ab991b408ffe@twiddle.net>
Date: Mon, 17 Jul 2017 20:27:43 -1000
MIME-Version: 1.0
In-Reply-To: <20170718045540.16322-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 00/10] optimize various tcg_gen()
 functions using extract/deposit op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Laurent Vivier <laurent@vivier.eu>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 07/17/2017 06:55 PM, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> Please find here the update series. Maybe you'll need to update the commit sha-1
> 58daf05d07dd in commits 3-8.
> 
> Regards,
> 
> Phil.
> 
> [v5]
> 
> - gitignore entries for cocci generated files
> - cleaned/improved cocci script, updated usage
> - fix output using Mersenne "number" instead of "prime" (Eric Blake)
> - use deposit() on alpha and sparc (Richard Henderson)
> - enable tci bswap16_i64()

Thanks.  Applied to tcg-next.

I'll run the one new target/arm patch past the relevant maintainers before 
flushing the queue.


r~
