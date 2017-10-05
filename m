Received: from eggs.gnu.org ([2001:4830:134:3::10]:41416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e08my-000889-PB
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:14:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e08mu-0000gJ-6T
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:14:20 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:46915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e08mu-0000fV-2A
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:14:16 -0400
Received: by mail-qt0-x22d.google.com with SMTP id 6so17253349qtw.3
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 09:14:16 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-5-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7b9b49a5-0397-14a4-01b6-c22435096684@linaro.org>
Date: Thu, 5 Oct 2017 12:14:12 -0400
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-5-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/20] target/arm: Restore security state
 on exception return
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

On 09/22/2017 10:59 AM, Peter Maydell wrote:
> Now that we can handle the CONTROL.SPSEL bit not necessarily being
> in sync with the current stack pointer, we can restore the correct
> security state on exception return. This happens before we start
> to read registers off the stack frame, but after we have taken
> possible usage faults for bad exception return magic values and
> updated CONTROL.SPSEL.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
