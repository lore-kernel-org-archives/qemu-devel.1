Received: from eggs.gnu.org ([2001:4830:134:3::10]:51776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e09BC-0006ji-Tc
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:39:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e09BC-0001PX-3x
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:39:22 -0400
Received: from mail-qt0-x22f.google.com ([2607:f8b0:400d:c0d::22f]:49256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e09BB-0001P8-VN
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:39:22 -0400
Received: by mail-qt0-x22f.google.com with SMTP id o3so26517404qte.6
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 09:39:21 -0700 (PDT)
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-10-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fd1549b3-a381-e75f-3d16-cad584f5ee17@linaro.org>
Date: Thu, 5 Oct 2017 12:39:18 -0400
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-10-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/20] target/arm: Add new-in-v8M SFSR and
 SFAR
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

On 09/22/2017 10:59 AM, Peter Maydell wrote:
> Add the new M profile Secure Fault Status Register
> and Secure Fault Address Register.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/cpu.h      | 12 ++++++++++++
>  hw/intc/armv7m_nvic.c | 34 ++++++++++++++++++++++++++++++++++
>  target/arm/machine.c  |  2 ++
>  3 files changed, 48 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
