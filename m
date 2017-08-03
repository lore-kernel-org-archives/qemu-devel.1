Received: from eggs.gnu.org ([2001:4830:134:3::10]:53952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddOT9-00023q-Jd
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 18:19:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ddOT6-0004Ec-J1
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 18:19:51 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-15-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <9ebbff0f-4aef-3032-7691-15ccf34a660d@twiddle.net>
Date: Thu, 3 Aug 2017 15:19:45 -0700
MIME-Version: 1.0
In-Reply-To: <1501692241-23310-15-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/15] armv7m_nvic.h: Move from
 include/hw/arm to include/hw/intc
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

On 08/02/2017 09:44 AM, Peter Maydell wrote:
> The armv7m_nvic.h header file was accidentally placed in
> include/hw/arm; move it to include/hw/intc to match where
> its corresponding .c file lives.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c                  | 2 +-
>  include/hw/arm/armv7m.h                | 2 +-
>  include/hw/{arm => intc}/armv7m_nvic.h | 0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename include/hw/{arm => intc}/armv7m_nvic.h (100%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
