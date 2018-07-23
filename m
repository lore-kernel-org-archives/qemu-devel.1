Received: from eggs.gnu.org ([2001:4830:134:3::10]:53798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhe6j-0000dz-5j
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fhe6i-0001Nj-Fs
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:54:49 -0400
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:44443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fhe6i-0001N5-8W
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 12:54:48 -0400
Received: by mail-pl0-x243.google.com with SMTP id m16-v6so467473pls.11
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 09:54:48 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-30-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0bc8fcfb-11b1-a042-d1a8-5e2622d6e7ed@linaro.org>
Date: Mon, 23 Jul 2018 09:54:43 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-30-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 29/40] target/mips: Adjust
 set_hflags_for_handler() for nanoMIPS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/19/2018 05:55 AM, Stefan Markovic wrote:
> From: James Hogan <james.hogan@mips.com>
> 
> We shouldn't clear M16 mode when entering an interrupt on nanoMIPS,
> otherwise we'll start interpreting the code as normal MIPS code.
> 
> Signed-off-by: James Hogan <james.hogan@mips.com>
> Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> ---
>  target/mips/helper.c | 3 +++
>  1 file changed, 3 insertions(+)

See my comments for 28/40.
