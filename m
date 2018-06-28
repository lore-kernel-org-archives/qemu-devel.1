Received: from eggs.gnu.org ([2001:4830:134:3::10]:47445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYZff-0004H5-Qb
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fYZff-0007ot-0Z
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:21:23 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:34554)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fYZfe-0007nW-S1
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 12:21:22 -0400
Received: by mail-oi0-x242.google.com with SMTP id c2-v6so5747909oic.1
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 09:21:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529699547-17044-6-git-send-email-alindsay@codeaurora.org>
References: <1529699547-17044-1-git-send-email-alindsay@codeaurora.org>
	<1529699547-17044-6-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Jun 2018 17:21:01 +0100
Message-ID: <CAFEAcA8S8hxQy0O8bqWjRSSaRLKp7QG=MWfw3XG5OupOsxEEDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 05/13] target/arm: Remove redundant DIV
 detection for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Spradling <mspradli@codeaurora.org>, Digant Desai <digantd@codeaurora.org>, Aaron Lindsay <aclindsa@gmail.com>

On 22 June 2018 at 21:32, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> KVM implies V7VE, which implies ARM_DIV and THUMB_DIV. The conditional
> detection here is therefore unnecessary. Because V7VE is already
> unconditionally specified for all KVM hosts, ARM_DIV and THUMB_DIV are
> already indirectly specified and do not need to be included here at all.
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
