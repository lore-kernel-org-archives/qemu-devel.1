Received: from eggs.gnu.org ([2001:4830:134:3::10]:43709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnVH-0006gX-1u
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:12:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnVD-0007iF-Mn
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:12:30 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36530)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dFnVD-0007i3-IC
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:12:27 -0400
Received: by mail-qt0-x242.google.com with SMTP id j13so13721251qta.3
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 13:12:27 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170529192440.5990-1-aurelien@aurel32.net>
	<20170529192440.5990-20-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0f2b6c94-d85f-1369-0869-54896c773324@twiddle.net>
Date: Tue, 30 May 2017 13:12:23 -0700
MIME-Version: 1.0
In-Reply-To: <20170529192440.5990-20-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 19/29] target/s390x: fix adj_len_to_page
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

On 05/29/2017 12:24 PM, Aurelien Jarno wrote:
> adj_len_to_page doesn't return the correct result when the address
> is already page aligned and the length is bigger than a page. Fix that.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/s390x/mem_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
