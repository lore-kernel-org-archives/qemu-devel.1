Received: from eggs.gnu.org ([2001:4830:134:3::10]:37660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8Y6G-00006z-EP
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d8Y6F-0003Kt-MH
	for qemu-devel@nongnu.org; Wed, 10 May 2017 16:20:44 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170510200535.13268-1-f4bug@amsat.org>
	<20170510200535.13268-3-f4bug@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b258b01d-74f9-e412-5367-d8e1d72eb159@twiddle.net>
Date: Wed, 10 May 2017 13:20:38 -0700
MIME-Version: 1.0
In-Reply-To: <20170510200535.13268-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/8] target/arm: optimize smul_dual() and
 neon_trn_u8() using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org

On 05/10/2017 01:05 PM, Philippe Mathieu-Daudé wrote:
> -    tcg_gen_shri_i32(t1, t1, 8);
> -    tcg_gen_andi_i32(t1, t1, 0x00ff00ff);
> +    tcg_gen_extract_i32(t1, t1, 8, 0x00ff00ff);

This is very wrong.  See my previous comment.


r~
