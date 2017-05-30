Received: from eggs.gnu.org ([2001:4830:134:3::10]:44395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnY1-0008Sg-0C
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:15:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dFnXx-0000Xw-OG
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:15:20 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dFnXx-0000Xq-IX
	for qemu-devel@nongnu.org; Tue, 30 May 2017 16:15:17 -0400
Received: by mail-qk0-x243.google.com with SMTP id c206so3537708qkb.0
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 13:15:17 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170529192440.5990-1-aurelien@aurel32.net>
	<20170529192440.5990-22-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c9586de4-9511-367a-acdb-aa703c28f5d0@twiddle.net>
Date: Tue, 30 May 2017 13:15:13 -0700
MIME-Version: 1.0
In-Reply-To: <20170529192440.5990-22-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 21/29] target/s390x: implement COMPARE
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

On 05/29/2017 12:24 PM, Aurelien Jarno wrote:
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
>   target/s390x/translate.c   | 22 ++++++++++++++
>   5 files changed, 90 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
