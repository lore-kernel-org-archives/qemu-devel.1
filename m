Received: from eggs.gnu.org ([2001:4830:134:3::10]:38578)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e244V-00060V-Cq
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 19:36:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e244S-0007ol-3Z
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 19:36:23 -0400
Received: from mail-pg0-x22b.google.com ([2607:f8b0:400e:c05::22b]:49888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e244R-0007mN-Rn
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 19:36:20 -0400
Received: by mail-pg0-x22b.google.com with SMTP id v13so14928pgq.6
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 16:36:18 -0700 (PDT)
References: <1507556919-24992-1-git-send-email-peter.maydell@linaro.org>
	<1507556919-24992-2-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <82dbe23c-9023-ad60-5386-c29dd4022c54@linaro.org>
Date: Tue, 10 Oct 2017 16:36:14 -0700
MIME-Version: 1.0
In-Reply-To: <1507556919-24992-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/9] target/arm: Add M profile secure MMU
 index values to get_a32_user_mem_index()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

On 10/09/2017 06:48 AM, Peter Maydell wrote:
> Add the M profile secure MMU index values to the switch in
> get_a32_user_mem_index() so that LDRT/STRT work correctly
> rather than asserting at translate time.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
