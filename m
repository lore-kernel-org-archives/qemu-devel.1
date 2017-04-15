Received: from eggs.gnu.org ([2001:4830:134:3::10]:47723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1czMrc-0000Mf-03
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 08:31:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1czMrY-0004xq-0R
	for qemu-devel@nongnu.org; Sat, 15 Apr 2017 08:31:39 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1491844419-12485-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <0f3ee3f1-5d73-79be-2e7d-45c0385c6758@twiddle.net>
Date: Sat, 15 Apr 2017 05:31:30 -0700
MIME-Version: 1.0
In-Reply-To: <1491844419-12485-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/9] arm: Implement M profile exception
 return properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, patches@linaro.org

On 04/10/2017 10:13 AM, Peter Maydell wrote:
> Peter Maydell (9):
>   arm: Don't implement BXJ on M-profile CPUs
>   arm: Thumb shift operations should not permit interworking branches
>   arm: Factor out "generate right kind of step exception"
>   arm: Move gen_set_condexec() and gen_set_pc_im() up in the file
>   arm: Move condition-failed codepath generation out of if()
>   arm: Abstract out "are we singlestepping" test to utility function
>   arm: Track M profile handler mode state in TB flags
>   arm: Implement M profile exception return properly
>   arm: Remove workarounds for old M-profile exception return
>     implementation
>
>  target/arm/cpu.h       |   9 +++
>  target/arm/translate.h |   5 ++
>  target/arm/cpu.c       |  43 +-----------
>  target/arm/translate.c | 181 +++++++++++++++++++++++++++++++++----------------
>  4 files changed, 138 insertions(+), 100 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
