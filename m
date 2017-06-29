Received: from eggs.gnu.org ([2001:4830:134:3::10]:40562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQcVo-0005mu-Pv
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQcVk-0007Jb-Qj
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:41:48 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dQcVk-0007JN-Kw
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:41:44 -0400
Received: by mail-pf0-x242.google.com with SMTP id e199so13805114pfh.0
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:41:44 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170629075243.26984-1-bobby.prani@gmail.com>
	<20170629075243.26984-4-bobby.prani@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <867e7278-b5af-cc8f-1f72-b0bd4ac46aec@twiddle.net>
Date: Thu, 29 Jun 2017 09:41:41 -0700
MIME-Version: 1.0
In-Reply-To: <20170629075243.26984-4-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] tcg/aarch64: Enable indirect jump
 path using LDR (literal)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>, alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org

On 06/29/2017 12:52 AM, Pranith Kumar wrote:
> This patch enables the indirect jump path using an LDR (literal)
> instruction. It will be interesting to test and see which performs
> better among the two paths.
> 
> CC: Richard Henderson<rth@twiddle.net>
> CC: Alex Bennée<alex.bennee@linaro.org>
> Signed-off-by: Pranith Kumar<bobby.prani@gmail.com>
> ---
>   tcg/aarch64/tcg-target.inc.c | 42 ++++++++++++++++++++++++++++--------------
>   1 file changed, 28 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
