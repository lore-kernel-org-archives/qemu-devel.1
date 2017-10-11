Received: from eggs.gnu.org ([2001:4830:134:3::10]:51413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e24rk-0007jG-Vt
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 20:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e24ri-0004ew-9M
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 20:27:17 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:47404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e24ri-0004eY-2L
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 20:27:14 -0400
Received: by mail-pg0-x231.google.com with SMTP id r25so71288pgn.4
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 17:27:13 -0700 (PDT)
References: <1507556919-24992-1-git-send-email-peter.maydell@linaro.org>
	<1507556919-24992-3-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e9f29609-b3e5-25fa-d9d6-903c16f7c8cf@linaro.org>
Date: Tue, 10 Oct 2017 17:27:10 -0700
MIME-Version: 1.0
In-Reply-To: <1507556919-24992-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/9] target/arm: Implement SG instruction
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
> Implement the SG instruction, which we emulate 'by hand' in the
> exception handling code path.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 132 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 127 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
