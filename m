Received: from eggs.gnu.org ([2001:4830:134:3::10]:41928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9Dm9-00064b-TF
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:50:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9Dm8-0004iw-VT
	for qemu-devel@nongnu.org; Fri, 12 May 2017 12:50:45 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170512033543.6789-1-f4bug@amsat.org>
	<20170512033543.6789-3-f4bug@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <f447c23f-f63c-f3bb-a1b9-f63e5aff4063@twiddle.net>
Date: Fri, 12 May 2017 09:50:37 -0700
MIME-Version: 1.0
In-Reply-To: <20170512033543.6789-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/5] target/arm: optimize rev16() using
 extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org

On 05/11/2017 08:35 PM, Philippe Mathieu-Daudé wrote:
> -    tcg_gen_shri_i64(tcg_tmp, tcg_rn, 16);
> -    tcg_gen_andi_i64(tcg_tmp, tcg_tmp, 0xffff);
> +    tcg_gen_extract_i64(tcg_tmp, tcg_rn, 16, 0xffff);

So your new script didn't work then?  This should be "..., 16, 16);".


r~
