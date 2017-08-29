Received: from eggs.gnu.org ([2001:4830:134:3::10]:51379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmieT-0002hK-R9
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmieP-00013C-4E
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:42:05 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:35969)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmieO-00012N-V9
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 11:42:01 -0400
Received: by mail-pf0-x233.google.com with SMTP id z87so11267242pfi.3
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 08:42:00 -0700 (PDT)
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-9-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <243eea50-7167-ba35-9481-9c919e446371@linaro.org>
Date: Tue, 29 Aug 2017 08:41:56 -0700
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-9-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 08/20] target/arm: Make FAULTMASK register
 banked for v8M
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

On 08/22/2017 08:08 AM, Peter Maydell wrote:
> Make the FAULTMASK register banked if v8M security extensions are enabled.
> 
> Note that we do not yet implement the functionality of the new
> AIRCR.PRIS bit (which allows the effect of the NS copy of FAULTMASK to
> be restricted).
> 
> This patch includes the code to determine for v8M which copy
> of FAULTMASK should be updated on exception exit; further
> changes will be required to the exception exit code in general
> to support v8M, so this is just a small piece of that.
> 
> The v8M ARM ARM introduces a notation where individual paragraphs
> are labelled with R (for rule) or I (for information) followed
> by a random group of subscript letters. In comments where we want
> to refer to a particular part of the manual we use this convention,
> which should be more stable across document revisions than using
> section or page numbers.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      | 14 ++++++++++++--
>  hw/intc/armv7m_nvic.c |  9 ++++++++-
>  target/arm/helper.c   | 20 ++++++++++++++++----
>  target/arm/machine.c  |  5 +++--
>  4 files changed, 39 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
