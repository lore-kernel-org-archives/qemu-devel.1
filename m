Received: from eggs.gnu.org ([2001:4830:134:3::10]:53840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpKST-0006T3-Au
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 15:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpKSS-0000wQ-De
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 15:56:13 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:36486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpKSS-0000wI-6D
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 15:56:12 -0400
Received: by mail-wm0-x22c.google.com with SMTP id n11so37534690wma.1
	for <qemu-devel@nongnu.org>; Sat, 18 Mar 2017 12:56:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170317210627.23532-1-marex@denx.de>
References: <20170317210627.23532-1-marex@denx.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Mar 2017 19:55:50 +0000
Message-ID: <CAFEAcA-o4T1_Dwu2wc8wRZaJbDq3ZgN3JRuQ9P5Lqzu6s9QT8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH V3] nios2: iic: Convert CPU prop to qom link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marek Vasut <marex@denx.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jeff Da Silva <jdasilva@altera.com>, Chris Wulff <crwulff@gmail.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Sandra Loosemore <sandra@codesourcery.com>, Ley Foon Tan <lftan@altera.com>, Yves Vandervennet <yvanderv@altera.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>

On 17 March 2017 at 21:06, Marek Vasut <marex@denx.de> wrote:
> Add a const qom link between the CPU and the IIC instead
> of passing the CPU link through a qom property.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Chris Wulff <crwulff@gmail.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Jeff Da Silva <jdasilva@altera.com>
> Cc: Ley Foon Tan <lftan@altera.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Sandra Loosemore <sandra@codesourcery.com>
> Cc: Yves Vandervennet <yvanderv@altera.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> ---
> V2: Retain dc->cannot_instantiate_with_device_add_yet = true
>     in altera_iic_class_init() since the device is still not
>     device_add() creatable.
> V3: Update the comment in altera_iic_class_init()

Applied to master, thanks.

-- PMM
