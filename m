Received: from eggs.gnu.org ([2001:4830:134:3::10]:33443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUzjn-0005yj-Fx
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUzjm-0007Iq-I4
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 14:18:19 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170711175937.23140-1-alex.bennee@linaro.org>
	<20170711175937.23140-6-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6dfcb308-c3a6-ee54-baae-0686021ee48a@twiddle.net>
Date: Tue, 11 Jul 2017 08:17:09 -1000
MIME-Version: 1.0
In-Reply-To: <20170711175937.23140-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 5/6] target/arm: use gen_goto_tb for ISB
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org
Cc: qemu-devel@nongnu.org, "open list:ARM" <qemu-arm@nongnu.org>

On 07/11/2017 07:59 AM, Alex Bennée wrote:
> While an ISB will ensure any raised IRQs happen on the next
> instruction it doesn't cause any to get raised by itself. We can
> therefor use a simple tb exit for ISB instructions and rely on the
> exit_request check at the top of each TB to deal with exiting if
> needed.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   target/arm/translate-a64.c | 2 +-
>   target/arm/translate.c     | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
