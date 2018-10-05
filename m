Received: from eggs.gnu.org ([2001:4830:134:3::10]:47428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8MS2-0001qa-Ur
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g8MDr-00021R-Bh
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:16:36 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:44495)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g8MDq-00020U-NF
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:16:35 -0400
Received: by mail-ot1-x343.google.com with SMTP id p23so386941otf.11
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 02:16:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181005080729.6480-1-jerome.forissier@linaro.org>
References: <20181005080729.6480-1-jerome.forissier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Oct 2018 10:16:12 +0100
Message-ID: <CAFEAcA9h7_vaKk7GuGVWv2_hFeR=xC4ZgJzLuD+iSqCdwa1PSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: add DT property
 /secure-chosen/sdtout-path being secure UART
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Etienne Carriere <etienne.carriere@linaro.org>, tee-dev@lists.linaro.org

On 5 October 2018 at 09:07, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
> Bindings for /secure-chosen and /secure-chosen/stdout-path have been
> proposed 1.5 years ago [1] and implemented in OP-TEE at the same time [2].
>
> This patch creates the property when the machine is secure.
>
> [1] https://patchwork.kernel.org/patch/9602401/
> [2] https://github.com/OP-TEE/optee_os/commit/4dc31c52544a
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

The patch seems OK, but it looks like the DT bindings are
not upstream yet? [*] I wouldn't want QEMU to start creating
bindings until the spec is definitely final.

[*] they're not in
https://www.kernel.org/doc/Documentation/devicetree/bindings/arm/secure.txt
anyway; is that the wrong place to look?

thanks
-- PMM
