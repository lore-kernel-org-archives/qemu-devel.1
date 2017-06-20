Received: from eggs.gnu.org ([2001:4830:134:3::10]:44806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNNa7-0000wX-Sa
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNNa4-0005P8-Ps
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:08:51 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:36329)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNNa4-0005Oq-JN
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 14:08:48 -0400
Received: by mail-pf0-x242.google.com with SMTP id y7so24980865pfd.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 11:08:48 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1497937927-19738-1-git-send-email-thuth@redhat.com>
	<1497937927-19738-6-git-send-email-thuth@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4333eca5-e3dc-8c03-19c9-1babbeac0a4c@twiddle.net>
Date: Tue, 20 Jun 2017 11:08:45 -0700
MIME-Version: 1.0
In-Reply-To: <1497937927-19738-6-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/8] cpu: Introduce a wrapper for
 tlb_flush() that can be used in common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 06/19/2017 10:52 PM, Thomas Huth wrote:
> Commit 1f5c00cfdb8114c ("qom/cpu: move tlb_flush to cpu_common_reset")
> moved the call to tlb_flush() from the target-specific reset handlers
> into the common code qom/cpu.c file, and protected the call with
> "#ifdef CONFIG_SOFTMMU" to avoid that it is called for linux-user
> only targets. But since qom/cpu.c is common code, CONFIG_SOFTMMU is
> *never*  defined here, so the tlb_flush() was simply never executed
> anymore. Fix it by introducing a wrapper for tlb_flush() in a file
> that is re-compiled for each target, i.e. in translate-all.c.
> 
> Fixes: 1f5c00cfdb8114c1e3a13426588ceb64f82c9ddb
> Signed-off-by: Thomas Huth<thuth@redhat.com>
> ---
>   include/exec/cpu-common.h | 2 ++
>   qom/cpu.c                 | 5 ++---
>   translate-all.c           | 8 ++++++++
>   3 files changed, 12 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
