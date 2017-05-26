Received: from eggs.gnu.org ([2001:4830:134:3::10]:55952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEHdi-0004A0-ND
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEHdi-0006Om-0M
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:58:58 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33220)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEHdh-0006Of-Rf
	for qemu-devel@nongnu.org; Fri, 26 May 2017 11:58:57 -0400
Received: by mail-qk0-x241.google.com with SMTP id o85so1688611qkh.0
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 08:58:57 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-19-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <e110e3fa-3173-fb18-152a-df1ec14a0b9c@twiddle.net>
Date: Fri, 26 May 2017 08:58:53 -0700
MIME-Version: 1.0
In-Reply-To: <20170525210508.4910-19-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/26] target/s390x: implement COMPARE
 LOGICAL LONG UNICODE
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

On 05/25/2017 02:05 PM, Aurelien Jarno wrote:
> For that we need to make program_interrupt available to qemu-user.
> Fortunately there is almost nothing to change as both kvm_enabled and
> CONFIG_KVM evaluate to false in that case.
> 
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/s390x/helper.h      |  1 +
>   target/s390x/insn-data.def |  2 ++
>   target/s390x/mem_helper.c  | 76 ++++++++++++++++++++++++++++++++++++++--------
>   target/s390x/misc_helper.c |  4 +--
>   target/s390x/translate.c   | 12 ++++++++
>   5 files changed, 80 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
