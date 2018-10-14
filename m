Received: from eggs.gnu.org ([2001:4830:134:3::10]:48555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBjLI-0005oZ-R2
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 12:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gBjLF-0001X7-Ii
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 12:34:12 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gBjLF-0001We-2w
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 12:34:09 -0400
Received: by mail-pg1-x541.google.com with SMTP id a5-v6so7993628pgv.13
	for <qemu-devel@nongnu.org>; Sun, 14 Oct 2018 09:34:08 -0700 (PDT)
References: <20181012144235.19646-1-peter.maydell@linaro.org>
	<20181012144235.19646-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <83ef9f62-ccd5-f142-ea8d-ac5ca9904a60@linaro.org>
Date: Sun, 14 Oct 2018 09:34:05 -0700
MIME-Version: 1.0
In-Reply-To: <20181012144235.19646-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 05/10] target/arm: ISR_EL1 bits track
 virtual interrupts if IMO/FMO set
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

On 10/12/18 7:42 AM, Peter Maydell wrote:
> The A/I/F bits in ISR_EL1 should track the virtual interrupt
> status, not the physical interrupt status, if the associated
> HCR_EL2.AMO/IMO/FMO bit is set. Implement this, rather than
> always showing the physical interrupt status.
> 
> We don't currently implement anything to do with external
> aborts, so this applies only to the I and F bits (though it
> ought to be possible for the outer guest to present a virtual
> external abort to the inner guest, even if QEMU doesn't
> emulate physical external aborts, so there is missing
> functionality in this area).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
