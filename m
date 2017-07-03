Received: from eggs.gnu.org ([2001:4830:134:3::10]:56240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7a3-0001Ch-U5
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:04:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS7Zz-0000vA-VO
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:04:23 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS7Zz-0000v2-Q2
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:04:19 -0400
Received: by mail-qt0-x243.google.com with SMTP id w12so24723469qta.2
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 13:04:19 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1499099693-22903-1-git-send-email-pbonzini@redhat.com>
	<1499099693-22903-13-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <26dc4787-f1eb-4371-bb24-b89f0fd506a7@twiddle.net>
Date: Mon, 3 Jul 2017 13:04:14 -0700
MIME-Version: 1.0
In-Reply-To: <1499099693-22903-13-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 12/22] tcg: move tb_lock out of
 translate-all.h
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
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   bsd-user/main.c         | 1 -
>   include/exec/exec-all.h | 4 ++++
>   tcg/tcg.h               | 4 ----
>   3 files changed, 4 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
