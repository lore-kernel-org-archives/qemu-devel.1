Received: from eggs.gnu.org ([2001:4830:134:3::10]:59559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSSaX-0005Ai-Fu
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dSSaU-0005P9-7G
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:30:17 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:35441)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dSSaU-0005Or-0b
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 14:30:14 -0400
Received: by mail-pf0-x22a.google.com with SMTP id c73so118413579pfk.2
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 11:30:13 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499166735-39360-1-git-send-email-pbonzini@redhat.com>
	<1499166735-39360-17-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <482b65c0-094e-dc5d-6ab9-d947612ce019@twiddle.net>
Date: Tue, 4 Jul 2017 08:30:08 -1000
MIME-Version: 1.0
In-Reply-To: <1499166735-39360-17-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/22] target/i386: move
 cpu_sync_bndcs_hflags() function
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
> Move cpu_sync_bndcs_hflags() function from mpx_helper.c
> to helper.c because mpx_helper.c need be disabled when
> tcg is disabled.
> 
> Signed-off-by: Yang Zhong<yang.zhong@intel.com>
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
> 	v2: moved cpu_report_tpr_access hunk later [Richard]
> 
>   target/i386/helper.c     | 30 ++++++++++++++++++++++++++++++
>   target/i386/mpx_helper.c | 30 ------------------------------
>   2 files changed, 30 insertions(+), 30 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
