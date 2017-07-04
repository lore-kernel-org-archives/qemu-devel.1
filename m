Received: from eggs.gnu.org ([2001:4830:134:3::10]:59378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSSa3-0004qM-Ff
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSSa0-00053O-9i
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:29:47 -0400
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:33735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dSSa0-00051Y-1T
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:29:44 -0400
Received: by mail-pg0-x235.google.com with SMTP id k14so37488808pgr.0
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 11:29:42 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
	<1499166735-39360-15-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <b7fde464-fd01-f7c0-b9c5-edb3afef3f14@twiddle.net>
Date: Tue, 4 Jul 2017 08:29:35 -1000
MIME-Version: 1.0
In-Reply-To: <1499166735-39360-15-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/22] tcg: add CONFIG_TCG guards in headers
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

On 07/04/2017 01:12 AM, Paolo Bonzini wrote:
> From: Yang Zhong<yang.zhong@intel.com>
> 
> Add the CONFIG_TCG for exec-all.h. Since function tlb_set_page_with_attrs()
> is defined in ./accel/tcg/cputlb.c, which will be disabled if tcg is disabled.
> This function need be implemented in accel/stubs/tcg-stub.c for disable-tcg.
> 
> Signed-off-by: Yang Zhong<yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
> 	v2: do not touch include/exec/helper-proto.h [Richard]
> 
>   include/exec/cpu-defs.h |  4 +++-
>   include/exec/cputlb.h   |  2 +-
>   include/exec/exec-all.h | 53 ++++++++++++++++++++++++++-----------------------
>   3 files changed, 32 insertions(+), 27 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
