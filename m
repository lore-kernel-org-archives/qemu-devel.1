Received: from eggs.gnu.org ([2001:4830:134:3::10]:59503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7ko-0002tG-7w
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:15:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7kk-0001MP-Vz
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:15:30 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:35814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS7kk-0001Lz-Rv
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:15:26 -0400
Received: by mail-qt0-x242.google.com with SMTP id w12so24758144qta.2
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 13:15:26 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-20-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <dc2e1f42-4aeb-e539-6ea2-2b3a0dadb0ce@twiddle.net>
Date: Mon, 3 Jul 2017 13:15:21 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-20-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/22] target/i386: move TLB refill
 function out of helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, anthony.xu@intel.com, berrange@redhat.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

On 07/03/2017 09:34 AM, Paolo Bonzini wrote:
> This function calls tlb_set_page_with_attrs, which is not available
> when TCG is disabled.  Move it to excp_helper.c.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/excp_helper.c | 343 +++++++++++++++++++++++++++++++++++++++++++++
>   target/i386/helper.c      | 344 +---------------------------------------------
>   2 files changed, 344 insertions(+), 343 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
