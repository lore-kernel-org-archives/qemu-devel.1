Received: from eggs.gnu.org ([2001:4830:134:3::10]:51968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0BO8-0006Jv-5b
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e0BO7-0000GF-Cr
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:00:52 -0400
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:43767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e0BO7-0000Fl-8T
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 15:00:51 -0400
Received: by mail-qt0-x22d.google.com with SMTP id a43so21380899qta.0
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 12:00:51 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-20-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0cc6a4e4-184b-6452-f9f2-d52c92b21350@linaro.org>
Date: Thu, 5 Oct 2017 15:00:47 -0400
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-20-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 19/20] target/arm: Implement secure
 function return
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

On 09/22/2017 11:00 AM, Peter Maydell wrote:
> Secure function return happens when a non-secure function has been
> called using BLXNS and so has a particular magic LR value (either
> 0xfefffffe or 0xfeffffff). The function return via BX behaves
> specially when the new PC value is this magic value, in the same
> way that exception returns are handled.
> 
> Adjust our BX excret guards so that they recognize the function
> return magic number as well, and perform the function-return
> unstacking in do_v7m_exception_exit().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/internals.h |   7 +++
>  target/arm/helper.c    | 115 +++++++++++++++++++++++++++++++++++++++++++++----
>  target/arm/translate.c |  14 +++++-
>  3 files changed, 126 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
