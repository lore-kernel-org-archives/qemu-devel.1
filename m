Received: from eggs.gnu.org ([2001:4830:134:3::10]:60025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fcxSj-0006g4-9v
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:34:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fcxSf-0006os-VF
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 14:34:09 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180710160013.26559-1-peter.maydell@linaro.org>
	<20180710160013.26559-7-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c502f24b-84fa-ecd7-e88a-a15e8d587796@twiddle.net>
Date: Tue, 10 Jul 2018 11:34:02 -0700
MIME-Version: 1.0
In-Reply-To: <20180710160013.26559-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] target/arm: Allow execution from small
 regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, KONRAD Frederic <frederic.konrad@adacore.com>

On 07/10/2018 09:00 AM, Peter Maydell wrote:
> Now that we have full support for small regions, including execution,
> we can remove the workarounds where we marked all small regions as
> non-executable for the M-profile MPU and SAU.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 23 -----------------------
>  1 file changed, 23 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
