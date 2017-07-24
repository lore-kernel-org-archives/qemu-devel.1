Received: from eggs.gnu.org ([2001:4830:134:3::10]:53881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZmQJ-000835-F8
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 19:06:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dZmQG-0000TE-4J
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 19:05:59 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1500906792-18010-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4b60c814-d631-f768-9c6b-a3cdb85d076e@twiddle.net>
Date: Mon, 24 Jul 2017 16:05:51 -0700
MIME-Version: 1.0
In-Reply-To: <1500906792-18010-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.10] target/arm: Correct MPU trace
 handling of write vs execute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, patches@linaro.org

On 07/24/2017 07:33 AM, Peter Maydell wrote:
> Correct off-by-one bug in the PSMAv7 MPU tracing where it would print
> a write access as "reading", an insn fetch as "writing", and a read
> access as "execute".
> 
> Since we have an MMUAccessType enum now, we can make the code clearer
> in the process by using that rather than the raw 0/1/2 values.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
