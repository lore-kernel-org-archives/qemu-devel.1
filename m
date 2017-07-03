Received: from eggs.gnu.org ([2001:4830:134:3::10]:55014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7XG-0006HF-WB
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7XD-0007p8-5q
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:01:31 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:35066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS7XD-0007oe-1R
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:01:27 -0400
Received: by mail-qk0-x242.google.com with SMTP id 16so25264475qkg.2
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 13:01:26 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-9-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <06154f33-7645-dae5-1bb0-3392632c68c9@twiddle.net>
Date: Mon, 3 Jul 2017 13:01:21 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-9-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/22] tcg: make tcg_allowed global
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
> Change the tcg_enabled() and make sure user build still enable tcg
> even x86 softmmu disable tcg.
> 
> Signed-off-by: Yang Zhong<yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   accel/tcg/cpu-exec-common.c | 2 ++
>   accel/tcg/tcg-all.c         | 1 -
>   accel/tcg/translate-all.c   | 6 +-----
>   include/qemu-common.h       | 7 ++++++-
>   4 files changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
