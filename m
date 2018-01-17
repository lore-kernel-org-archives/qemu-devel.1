Received: from eggs.gnu.org ([2001:4830:134:3::10]:41651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebuM0-0000Pz-F0
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 15:30:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebuLz-0002ze-OD
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 15:30:36 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:43829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebuLz-0002yt-IX
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 15:30:35 -0500
Received: by mail-oi0-x22c.google.com with SMTP id t16so14040620oif.10
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 12:30:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180117201515.1a49fcbf@redhat.com>
References: <1516203816-19374-1-git-send-email-imammedo@redhat.com>
	<CAFEAcA-8dwLpfrbV8+--L4Z9Um9xVsyUOfKjcz9-T1aTPkgrEg@mail.gmail.com>
	<20180117201515.1a49fcbf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 17 Jan 2018 20:30:14 +0000
Message-ID: <CAFEAcA9gXOOkv+-rTXcNyzgY9P8CR66Rrx-0GM2G0m0x+HbAmA@mail.gmail.com>
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

On 17 January 2018 at 19:15, Igor Mammedov <imammedo@redhat.com> wrote:
> On Wed, 17 Jan 2018 16:12:09 +0000
> Peter Maydell <peter.maydell@linaro.org> wrote:
>> I like moving this from being an ifdef ladder into per-cpu
>> code, but I don't think the definition belongs in target/$ARCH.
>> It's part of the choice usermode makes about how to handle
>> binaries it's loading, so it should go in linux-user/$ARCH/target_cpu.h.
>> target/$ARCH should really be for things that are properties
>> of the architecture.
> That's used not only by linux-user but also reused by null-machine.c
> to get access to a target specific cpu_class_by_name() callback.

That usage must want a different name, though, surely?
For Arm the default CPU for linux-user is 'any' but that
is usermode only and won't work for system emulation so
null-machine.c will need to pick something else.

thanks
-- PMM
