Received: from eggs.gnu.org ([2001:4830:134:3::10]:59306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQyTR-0008I8-84
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dQyTM-0007XH-DN
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:08:49 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dQyTM-0007Wv-69
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 12:08:44 -0400
Received: by mail-qk0-x241.google.com with SMTP id 91so15961214qkq.1
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 09:08:44 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170630143614.31059-1-bobby.prani@gmail.com>
	<20170630143614.31059-2-bobby.prani@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <68261c84-3757-0822-962b-ad1d262d1f4c@twiddle.net>
Date: Fri, 30 Jun 2017 09:08:38 -0700
MIME-Version: 1.0
In-Reply-To: <20170630143614.31059-2-bobby.prani@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 2/3] tcg/aarch64: Use ADRP+ADD to
 compute target address
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

On 06/30/2017 07:36 AM, Pranith Kumar wrote:
> We use ADRP+ADD to compute the target address for goto_tb. This patch
> introduces the NOP instruction which is used to align the above
> instruction pair so that we can use one atomic instruction to patch
> the destination offsets.
> 
> CC: Richard Henderson<rth@twiddle.net>
> CC: Alex Bennée<alex.bennee@linaro.org>
> Signed-off-by: Pranith Kumar<bobby.prani@gmail.com>
> ---
>   accel/tcg/translate-all.c    |  2 +-
>   tcg/aarch64/tcg-target.inc.c | 36 ++++++++++++++++++++++++++++++------
>   2 files changed, 31 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
