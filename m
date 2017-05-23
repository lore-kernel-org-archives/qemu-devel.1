Received: from eggs.gnu.org ([2001:4830:134:3::10]:49276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dCxbN-0004mx-R0
	for qemu-devel@nongnu.org; Mon, 22 May 2017 20:23:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dCxbN-0004oL-2O
	for qemu-devel@nongnu.org; Mon, 22 May 2017 20:23:05 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dCxbM-0004nk-UK
	for qemu-devel@nongnu.org; Mon, 22 May 2017 20:23:04 -0400
Received: by mail-qt0-x242.google.com with SMTP id l39so20328602qtb.1
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 17:23:04 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170516230159.4195-1-aurelien@aurel32.net>
	<20170516230159.4195-4-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b2ca6ab5-9993-4d7e-2150-7737e7c2b70d@twiddle.net>
Date: Mon, 22 May 2017 17:23:01 -0700
MIME-Version: 1.0
In-Reply-To: <20170516230159.4195-4-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] target/cris: optimize swap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On 05/16/2017 04:01 PM, Aurelien Jarno wrote:
> Use the same mask to avoid having to load two different constants, as
> suggest by Richard Henderson. Also use one less temp.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/cris/translate.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
