Received: from eggs.gnu.org ([2001:4830:134:3::10]:47096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEIt2-0004CU-LD
	for qemu-devel@nongnu.org; Fri, 26 May 2017 13:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEIt1-0003Pq-Qc
	for qemu-devel@nongnu.org; Fri, 26 May 2017 13:18:52 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:32808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEIt1-0003Pg-MJ
	for qemu-devel@nongnu.org; Fri, 26 May 2017 13:18:51 -0400
Received: by mail-qk0-x241.google.com with SMTP id o85so1941914qkh.0
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 10:18:51 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170526003207.3101-1-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <8cbd8d9d-3db6-e2b3-c863-310175765550@twiddle.net>
Date: Fri, 26 May 2017 10:18:48 -0700
MIME-Version: 1.0
In-Reply-To: <20170526003207.3101-1-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 27/26] target/s390x: fix adj_len_to_page
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

On 05/25/2017 05:32 PM, Aurelien Jarno wrote:
> adj_len_to_page doesn't return the correct result when the address
> is already page aligned and the length is bigger than a page. Fix that.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/s390x/mem_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
