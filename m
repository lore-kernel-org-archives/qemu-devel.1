Received: from eggs.gnu.org ([2001:4830:134:3::10]:50179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei4u0-0007PD-7i
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:59:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei4tz-0005qe-Es
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:59:12 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:44026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ei4tz-0005qK-7h
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:59:11 -0500
Received: by mail-pf0-x243.google.com with SMTP id y26so19181852pfi.10
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 12:59:11 -0800 (PST)
References: <20180203153935.8056-1-pbonzini@redhat.com>
	<20180203153935.8056-6-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1dbfc2ac-98f7-85d4-8559-72dd95312357@linaro.org>
Date: Sat, 3 Feb 2018 12:59:07 -0800
MIME-Version: 1.0
In-Reply-To: <20180203153935.8056-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5] curl: convert to CoQueue
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
> Now that CoQueues can use a QemuMutex for thread-safety, there is no
> need for curl to roll its own coroutine queue.  Coroutines can be
> placed directly on the queue instead of using a list of CURLAIOCBs.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/curl.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
