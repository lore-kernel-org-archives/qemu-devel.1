Received: from eggs.gnu.org ([2001:4830:134:3::10]:53901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBfFh-0000fb-R0
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:07:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eBfFb-0005iG-V1
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:07:37 -0500
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:47283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eBfFb-0005i2-Np
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:07:31 -0500
Received: by mail-wr0-x233.google.com with SMTP id k61so2360492wrc.4
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 03:07:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171026080041.8280-1-aik@ozlabs.ru>
References: <20171026080041.8280-1-aik@ozlabs.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Nov 2017 11:07:09 +0000
Message-ID: <CAFEAcA8SjKZxLKu3LcWjdbAuFrDduQqY6inwigwZ76T-3XuFHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH qemu] isa-bus: Replace assert() about DMA
 with error report
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 26 October 2017 at 09:00, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> Running "qemu-system-ppc64 -machine prep -device i82374" creates an ISA
> bus with two i82374 DMA controllers - one is implicit from ppc_prep_init(),
> the other one is from "-device i82374". QEMU asserts but it is not
> immediately clear why.
>
> This adds an error message to explain the failure.
>
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Does it ever make sense for the user to try to create this
device on the command line? If not, maybe we should set
it to dc->user_creatable = false; ?

If it can be usefully user-created, then rather than being
a fatal error in this function the error should be passed
back up so that we can fail the 'realize' method of the device.

thanks
-- PMM
