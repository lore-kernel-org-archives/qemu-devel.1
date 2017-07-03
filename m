Received: from eggs.gnu.org ([2001:4830:134:3::10]:53525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7Vm-0004nr-CU
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7Vi-0006ZU-Jq
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:59:58 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS7Vi-0006Z3-GP
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:59:54 -0400
Received: by mail-qk0-x241.google.com with SMTP id 16so25259640qkg.2
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 12:59:54 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-8-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <31162eeb-15ed-e958-150b-53138c3189b0@twiddle.net>
Date: Mon, 3 Jul 2017 12:59:49 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-8-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/22] tcg: tcg_handle_interrupt() function
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
> From: Yang Zhong<yang.zhong@intel.com>
> 
> Move tcg_handle_interrupt() from translate-common.c to
> accel/tcg/tcg-all.c.
> 
> Signed-off-by: Yang Zhong<yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   accel/tcg/Makefile.objs      |  2 +-
>   accel/tcg/tcg-all.c          | 32 +++++++++++++++++++++++++
>   accel/tcg/translate-common.c | 56 --------------------------------------------
>   qom/cpu.c                    |  2 ++
>   4 files changed, 35 insertions(+), 57 deletions(-)
>   delete mode 100644 accel/tcg/translate-common.c

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
