Received: from eggs.gnu.org ([2001:4830:134:3::10]:36227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1C7V-00057a-72
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d1C7U-0001Eb-9n
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:27:37 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:38867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d1C7U-0001Dq-3u
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 09:27:36 -0400
Received: by mail-wm0-x235.google.com with SMTP id r190so48314622wme.1
	for <qemu-devel@nongnu.org>; Thu, 20 Apr 2017 06:27:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170410150350.3267-2-ard.biesheuvel@linaro.org>
References: <20170410150350.3267-1-ard.biesheuvel@linaro.org>
	<20170410150350.3267-2-ard.biesheuvel@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 14:27:14 +0100
Message-ID: <CAFEAcA8oM9iHibB71_WFKAnHEQe9NOxk13EkH1-ocsw078qFBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 2/2] hw/arm/virt: generate 64-bit
 addressable ACPI objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, phil@philjordan.eu, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Andrew Jones <drjones@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>

On 10 April 2017 at 16:03, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Our current ACPI table generation code limits the placement of ACPI
> tables to 32-bit addressable memory, in order to be able to emit the
> root pointer (RSDP) and root table (RSDT) using table types from the
> ACPI 1.0 days.
>
> Since ARM was not supported by ACPI before version 5.0, it makes sense
> to lift this restriction. This is not crucial for mach-virt, which is
> guaranteed to have some memory available below the 4 GB mark, but it
> is a nice to have for QEMU machines that do not have any 32-bit
> addressable memory, which is not uncommon for real world 64-bit ARM
> systems.
>
> Since we already emit a version of the RSDP root pointer that has a
> secondary 64-bit wide address field for the 64-bit root table (XSDT),
> all we need to do is replace the RSDT generation with the generation
> of an XSDT table, and use a different slot in the FADT table to refer
> to the DSDT.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
> Acked-by: Laszlo Ersek <lersek@redhat.com>

Michael -- I'm assuming you're planning to take these 2 patches
via the ACPI tree; let me know if you'd rather I take them via
the ARM tree.

Acked-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
