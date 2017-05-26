Received: from eggs.gnu.org ([2001:4830:134:3::10]:53656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEHU5-0007jw-0O
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEHU4-0002xx-DA
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:49:01 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35546)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEHU4-0002xp-8h
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:49:00 -0400
Received: by mail-qt0-x242.google.com with SMTP id r58so1769875qtb.2
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 08:49:00 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-18-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <328011c6-ce6e-29c7-68b8-9bae33b95dbd@twiddle.net>
Date: Fri, 26 May 2017 08:48:56 -0700
MIME-Version: 1.0
In-Reply-To: <20170525210508.4910-18-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/26] target/s390x: improve MOVE LONG and
 MOVE LONG EXTENDED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>

On 05/25/2017 02:04 PM, Aurelien Jarno wrote:
> As MVCL and MVCLE only differ by their operands, use a common
> do_mvcl helper. Optimize it calling fast_memmove and fast_memset.
> Correctly write back addresses.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/s390x/mem_helper.c | 90 +++++++++++++++++++++--------------------------
>   1 file changed, 40 insertions(+), 50 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
