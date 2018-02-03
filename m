Received: from eggs.gnu.org ([2001:4830:134:3::10]:49182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei4m9-0002ym-TL
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:51:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei4m6-0008Tr-Rn
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:51:05 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:32870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ei4m6-0008T8-LP
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:51:02 -0500
Received: by mail-pf0-x243.google.com with SMTP id u15so3089189pfa.0
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 12:51:02 -0800 (PST)
References: <20180203153935.8056-1-pbonzini@redhat.com>
	<20180203153935.8056-4-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <94fcb3a4-8ec5-97a9-84be-f91a849372a9@linaro.org>
Date: Sat, 3 Feb 2018 12:50:58 -0800
MIME-Version: 1.0
In-Reply-To: <20180203153935.8056-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] coroutine-lock: convert CoQueue to use
 QemuLockable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-block@nongnu.org, stefanha@redhat.com

On 02/03/2018 07:39 AM, Paolo Bonzini wrote:
> There are cases in which a queued coroutine must be restarted from
> non-coroutine context (with qemu_co_enter_next).  In this cases,
> qemu_co_enter_next also needs to be thread-safe, but it cannot use
> a CoMutex and so cannot qemu_co_queue_wait.  Use QemuLockable so
> that the CoQueue can interchangeably use CoMutex or QemuMutex.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qemu/coroutine.h   |  6 +++++-
>  util/qemu-coroutine-lock.c | 12 +++++++-----
>  2 files changed, 12 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
