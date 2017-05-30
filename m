Received: from eggs.gnu.org ([2001:4830:134:3::10]:44776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnYx-0000jz-11
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnYt-0000l1-PY
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:16:19 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dFnYt-0000kt-L2
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:16:15 -0400
Received: by mail-qt0-x241.google.com with SMTP id j13so13732716qta.3
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 13:16:15 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170529192440.5990-1-aurelien@aurel32.net>
	<20170529192440.5990-25-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <08f8c1a9-ca2f-b51d-460a-d9e9b46edab6@twiddle.net>
Date: Tue, 30 May 2017 13:16:11 -0700
MIME-Version: 1.0
In-Reply-To: <20170529192440.5990-25-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 24/29] target/s390x: implement PACK
 UNICODE
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
> Use a common helper with PACK ASCII as the differences are limited to
> the stride of the source operand.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/s390x/helper.h      |  1 +
>   target/s390x/insn-data.def |  2 ++
>   target/s390x/mem_helper.c  | 30 +++++++++++++++++++++---------
>   target/s390x/translate.c   | 16 ++++++++++++++++
>   4 files changed, 40 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
