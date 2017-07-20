Received: from eggs.gnu.org ([2001:4830:134:3::10]:59433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYHJI-0005PB-Ts
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:40:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dYHJF-0001Na-Mz
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 15:40:32 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
	<20170720150426.12393-15-alex.bennee@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <eb3454ed-4a7c-180b-a005-00557031cf60@twiddle.net>
Date: Thu, 20 Jul 2017 09:40:21 -1000
MIME-Version: 1.0
In-Reply-To: <20170720150426.12393-15-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for 2.11 14/23]
 target/arm/translate-a64.c: add ARMv8.2 fadd scalar half-precision
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 07/20/2017 05:04 AM, Alex Bennée wrote:
> This brings in the initial decode skeleton and the helpers for a
> scalar half-precision fadd using SoftFloat3c.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   target/arm/advsimd_helper.c | 15 ++++++++++++
>   target/arm/translate-a64.c  | 60 +++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 75 insertions(+)

... and there it is.  Squash this with previous?  Anyway, do something so that 
they're bisectable.


r~
