Received: from eggs.gnu.org ([2001:4830:134:3::10]:58666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7hu-0000Fj-Um
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:12:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7hr-0007tm-Nw
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:12:30 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS7hr-0007tS-Ix
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:12:27 -0400
Received: by mail-qk0-x241.google.com with SMTP id 91so25282813qkq.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 13:12:27 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-18-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <50d435bf-5aa9-00d5-2c0a-d1f9f2439b44@twiddle.net>
Date: Mon, 3 Jul 2017 13:12:22 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-18-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 17/22] target/i386: make
 cpu_get_fp80()/cpu_set_fp80() static
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
> Move cpu_get_fp80()/cpu_set_fp80() from fpu_helper.c to
> machine.c because fpu_helper.c will be disabled if tcg is
> disabled in the build.
> 
> Signed-off-by: Yang Zhong<yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/cpu.h        |  2 --
>   target/i386/fpu_helper.c | 18 ------------------
>   target/i386/machine.c    | 18 ++++++++++++++++++
>   3 files changed, 18 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
