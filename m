Received: from eggs.gnu.org ([2001:4830:134:3::10]:43652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnV5-0006XL-T4
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:12:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnV1-0007eN-J5
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:12:19 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dFnV1-0007eJ-F7
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:12:15 -0400
Received: by mail-qk0-x242.google.com with SMTP id c206so3527734qkb.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 13:12:15 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170529192440.5990-1-aurelien@aurel32.net>
	<20170529192440.5990-19-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <7bf1d6fe-4dd9-2040-135d-c2a7a9653bff@twiddle.net>
Date: Tue, 30 May 2017 13:12:11 -0700
MIME-Version: 1.0
In-Reply-To: <20170529192440.5990-19-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 18/29] target/s390x: implement COMPARE
 LOGICAL LONG
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
> As CLCL and CLCLE mostly differ by their operands, use a common do_clcl
> helper. Another difference is that CLCL is not interruptible.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/s390x/helper.h      |  1 +
>   target/s390x/insn-data.def |  2 ++
>   target/s390x/mem_helper.c  | 84 +++++++++++++++++++++++++++++++++-------------
>   target/s390x/translate.c   | 21 ++++++++++++
>   4 files changed, 84 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
