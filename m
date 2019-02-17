Received: from eggs.gnu.org ([209.51.188.92]:54283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQsL-0003fe-96
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:09:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gvQsK-0001cM-JO
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:09:13 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:43575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gvQsK-0001c8-Ag
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 13:09:12 -0500
Received: by mail-pf1-x444.google.com with SMTP id q17so7347350pfh.10
	for <qemu-devel@nongnu.org>; Sun, 17 Feb 2019 10:09:12 -0800 (PST)
References: <20190214125107.22178-1-peter.maydell@linaro.org>
	<20190214125107.22178-11-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <42a585ac-5766-7042-13bd-7a50a8253460@linaro.org>
Date: Sun, 17 Feb 2019 10:09:07 -0800
MIME-Version: 1.0
In-Reply-To: <20190214125107.22178-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/14] hw/arm/musca.c: Implement models of
 the Musca-A and -B1 boards
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

On 2/14/19 4:51 AM, Peter Maydell wrote:
> The Musca-A and Musca-B1 development boards are based on the
> SSE-200 subsystem for embedded. Implement an initial skeleton
> model of these boards, which are similar but not identical.
> 
> This commit creates the board model with the SSE and the IRQ
> splitters to wire IRQs up to its two CPUs. As yet there
> are no devices and no memory: these will be added later.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/arm/Makefile.objs            |   1 +
>  hw/arm/musca.c                  | 197 ++++++++++++++++++++++++++++++++
>  MAINTAINERS                     |   6 +
>  default-configs/arm-softmmu.mak |   1 +
>  4 files changed, 205 insertions(+)
>  create mode 100644 hw/arm/musca.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
