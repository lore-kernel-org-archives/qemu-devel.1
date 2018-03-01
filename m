Received: from eggs.gnu.org ([2001:4830:134:3::10]:49771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erRMM-0007Bh-37
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:47:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erRML-0001wh-Cp
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:47:10 -0500
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:45188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erRML-0001w5-0a
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 11:47:09 -0500
Received: by mail-oi0-x235.google.com with SMTP id j79so4936456oib.12
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 08:47:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519815685-29200-4-git-send-email-abdallah.bouassida@lauterbach.com>
References: <1519815685-29200-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<1519815685-29200-4-git-send-email-abdallah.bouassida@lauterbach.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 16:46:47 +0000
Message-ID: <CAFEAcA8B6TeDUCSmPxG4YJ_1pZSHVf5KA7tOgsO+Jqnme0bnWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 3/4] target/arm: Add the XML dynamic
 generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Khaled Jmal <khaled.jmal@lauterbach.com>

On 28 February 2018 at 11:01, Abdallah Bouassida
<abdallah.bouassida@lauterbach.com> wrote:
> Generate an XML description for the cp-regs.
> Register these regs with the gdb_register_coprocessor().
> Add arm_gdb_get_sysreg() to use it as a callback to read those regs.
>
> Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
> ---

> +void arm_register_gdb_regs_for_features(CPUState *cs)
> +{
> +    int n;
> +
> +    n = arm_gen_dynamic_xml(cs);
> +    gdb_register_coprocessor(cs, arm_gdb_get_sysreg, NULL,
> +                             n, "system-registers.xml", 0);
> +
> +}

Have you tried writing to a sysreg from the debugger without
your patch 4 applied? I suspect you'll find it crashes because
of the NULL pointer you're passing here, and you'll need a
dummy write function.

thanks
-- PMM
