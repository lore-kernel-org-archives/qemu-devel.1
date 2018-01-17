Received: from eggs.gnu.org ([2001:4830:134:3::10]:38115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebqKF-00043p-Mv
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:12:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebqKE-0002e4-Ry
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:12:31 -0500
Received: from mail-ot0-x22c.google.com ([2607:f8b0:4003:c0f::22c]:40457)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebqKE-0002dk-Mq
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:12:30 -0500
Received: by mail-ot0-x22c.google.com with SMTP id x4so1626129otg.7
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 08:12:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 Jan 2018 16:12:09 +0000
Message-ID: <CAFEAcA-8dwLpfrbV8+--L4Z9Um9xVsyUOfKjcz9-T1aTPkgrEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/24] generalize parsing of cpu_model
 (part 4)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 17 January 2018 at 15:43, Igor Mammedov <imammedo@redhat.com> wrote:
> Series is finishing work on generalizing cpu_model parsing
> and limiting parts that deal with inconsistent cpu_model
> naming to "-cpu" CLI option processing in vl.c/*-user.main.c
> and FOO_cpu_class_by_name() callbacks.
>
> It introduces TARGET_DEFAULT_CPU_TYPE which must be defined
> by each target and is used setting default cpu type for
> linux/bsd-user targets and as anchor point to pick cpu class
> that provides target specific FOO_cpu_class_by_name()
> callback for cpu_parse_cpu_model() in null-machine.c
> which is compiled for all targets that have system
> mode emulation.

I like moving this from being an ifdef ladder into per-cpu
code, but I don't think the definition belongs in target/$ARCH.
It's part of the choice usermode makes about how to handle
binaries it's loading, so it should go in linux-user/$ARCH/target_cpu.h.
target/$ARCH should really be for things that are properties
of the architecture.

thanks
-- PMM
