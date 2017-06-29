Received: from eggs.gnu.org ([2001:4830:134:3::10]:60304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQcEl-0004HD-CO
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQcEi-0006Xq-7U
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:24:11 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dQcEi-0006XI-1o
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:24:08 -0400
Received: by mail-pf0-x244.google.com with SMTP id e199so13752480pfh.0
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 09:24:06 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170629075243.26984-1-bobby.prani@gmail.com>
	<20170629075243.26984-2-bobby.prani@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e28d21e4-5cad-20f7-07be-0c60af298ba3@twiddle.net>
Date: Thu, 29 Jun 2017 09:24:02 -0700
MIME-Version: 1.0
In-Reply-To: <20170629075243.26984-2-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] tcg/aarch64: Introduce and use long
 branch to register
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
> We can use a branch to register instruction for exit_tb for offsets
> greater than 128MB.
> 
> CC: Richard Henderson<rth@twiddle.net>
> CC: Alex Bennée<alex.bennee@linaro.org>
> Signed-off-by: Pranith Kumar<bobby.prani@gmail.com>
> ---
>   tcg/aarch64/tcg-target.inc.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
