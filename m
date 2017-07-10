Received: from eggs.gnu.org ([2001:4830:134:3::10]:50109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUbh4-0006Ze-6Z
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:37:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dUbh3-000631-Cc
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:37:54 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170710154749.13624-1-alex.bennee@linaro.org>
	<20170710154749.13624-5-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1e6a695b-92b1-578d-5467-569ec28b6a30@twiddle.net>
Date: Mon, 10 Jul 2017 06:37:11 -1000
MIME-Version: 1.0
In-Reply-To: <20170710154749.13624-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 4/6] target/arm/translate-a64: get rid
 of DISAS_EXIT
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

On 07/10/2017 05:47 AM, Alex Bennée wrote:
> We already have an exit condition that declares we should exit to the
> run-loop because wider CPU state changes have been made. Use
> DISAS_UPDATE and kill the architecture specific DISAS_EXIT.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   target/arm/translate-a64.c | 3 +--
>   target/arm/translate.c     | 6 ++++--
>   target/arm/translate.h     | 4 ----
>   3 files changed, 5 insertions(+), 8 deletions(-)

I really thought it was clearer the other way around.


r~
