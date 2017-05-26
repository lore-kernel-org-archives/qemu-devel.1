Received: from eggs.gnu.org ([2001:4830:134:3::10]:58043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEG7Y-0003eS-Ub
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:21:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEG7Y-0004F9-2d
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:21:40 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEG7X-0004E9-TZ
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:21:39 -0400
Received: by mail-qk0-x241.google.com with SMTP id u75so1324479qka.1
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 07:21:39 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-13-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7b3cf48f-71f9-b329-6f07-f6cfafe83992@twiddle.net>
Date: Fri, 26 May 2017 07:21:36 -0700
MIME-Version: 1.0
In-Reply-To: <20170525210508.4910-13-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/26] target/s390x: improve 24-bit and
 31-bit addresses read
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
> Improve fix_address to also handle the 24-bit mode. Rename fix_address
> to wrap_address to better explain what is changed.
> 
> For the same reason, rename get_address into get_address_rel and
> get_address_31fix into get_address_rel.
> 
> Finally replace many calls to get_address_rel with x2 = 0 and b2 = 0 by
> call to wrap_address.
> 
> Note that get_address_relget_address_rel is only used in the EXECUTE
> helper, so we can get rid of it as the same time as the helper.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/s390x/mem_helper.c | 90 +++++++++++++++++++++++++----------------------
>   1 file changed, 47 insertions(+), 43 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
