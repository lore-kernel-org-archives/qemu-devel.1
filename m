Received: from eggs.gnu.org ([2001:4830:134:3::10]:43022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnRn-0004ZU-UA
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnRj-000710-R2
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:08:55 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34136)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dFnRj-00070w-MQ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:08:51 -0400
Received: by mail-qk0-x241.google.com with SMTP id u75so13358121qka.1
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 13:08:51 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170529192440.5990-1-aurelien@aurel32.net>
	<20170529192440.5990-15-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7f24559a-5f10-ccb8-3388-5aab8a2035b4@twiddle.net>
Date: Tue, 30 May 2017 13:08:48 -0700
MIME-Version: 1.0
In-Reply-To: <20170529192440.5990-15-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 14/29] target/s390x: improve 24-bit and
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

On 05/29/2017 12:24 PM, Aurelien Jarno wrote:
> Improve fix_address to also handle the 24-bit mode. Rename fix_address
> to wrap_address to better explain what is changed.
> 
> Replace the calls to get_address with x2 = 0 and b2 = 0 by
> call to wrap_address, leading to the removal of this function. Rename
> get_address_31fix into get_address.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/s390x/mem_helper.c | 71 +++++++++++++++++++++--------------------------
>   1 file changed, 31 insertions(+), 40 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
