Received: from eggs.gnu.org ([2001:4830:134:3::10]:48485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei4hb-0000XQ-No
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:46:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ei4hZ-0005FE-Rq
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:46:23 -0500
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:42504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ei4hZ-0005Ep-MG
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 15:46:21 -0500
Received: by mail-pl0-x242.google.com with SMTP id 11so8939133plc.9
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 12:46:21 -0800 (PST)
References: <20180203153935.8056-1-pbonzini@redhat.com>
	<20180203153935.8056-2-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e18e02d7-4b38-a5b3-5498-d70f7a1bce70@linaro.org>
Date: Sat, 3 Feb 2018 12:46:18 -0800
MIME-Version: 1.0
In-Reply-To: <20180203153935.8056-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] test-coroutine: add simple CoMutex test
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
> In preparation for adding a similar test using QemuLockable, add a very
> simple testcase that has two interleaved calls to lock and unlock.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/test-coroutine.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 48 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
