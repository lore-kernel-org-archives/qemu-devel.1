Received: from eggs.gnu.org ([2001:4830:134:3::10]:36265)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpGJr-0008N5-BO
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:03:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dpGJm-00026q-Im
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:03:19 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:37967)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dpGJm-00025v-C6
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:03:14 -0400
Received: by mail-pg0-x232.google.com with SMTP id v66so10118754pgb.5
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 09:03:14 -0700 (PDT)
References: <1504626814-23124-1-git-send-email-peter.maydell@linaro.org>
	<1504626814-23124-2-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a0cce589-b6e1-d17e-34df-f8232c64e5fa@linaro.org>
Date: Tue, 5 Sep 2017 09:03:10 -0700
MIME-Version: 1.0
In-Reply-To: <1504626814-23124-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/3] boards.h: Define new flag
 ignore_memory_transaction_failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 09/05/2017 08:53 AM, Peter Maydell wrote:
> Define a new MachineClass field ignore_memory_transaction_failures.
> If this is flag is true then the CPU will ignore memory transaction
> failures which should cause the CPU to take an exception due to an
> access to an unassigned physical address; the transaction will
> instead return zero (for a read) or be ignored (for a write).  This
> should be set only by legacy board models which rely on the old
> RAZ/WI behaviour for handling devices that QEMU does not yet model.
> New board models should instead use "unimplemented-device" for all
> memory ranges where the guest will attempt to probe for a device that
> QEMU doesn't implement and a stub device is required.
> 
> We need this for ARM boards, where we're about to implement support for
> generating external aborts on memory transaction failures. Too many
> of our legacy board models rely on the RAZ/WI behaviour and we
> would break currently working guests when their "probe for device"
> code provoked an external abort rather than a RAZ.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/boards.h | 11 +++++++++++
>  include/qom/cpu.h   |  7 ++++++-
>  qom/cpu.c           | 16 ++++++++++++++++
>  3 files changed, 33 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
