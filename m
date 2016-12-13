Received: from eggs.gnu.org ([2001:4830:134:3::10]:40953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGrh1-0005Gl-VK
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 13:20:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGrgy-0006Uw-SR
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 13:20:47 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36858)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cGrgy-0006UR-M6
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 13:20:44 -0500
Received: by mail-vk0-f50.google.com with SMTP id p9so74204825vkd.3
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 10:20:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1481285870-3396-6-git-send-email-thuth@redhat.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
	<1481285870-3396-6-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Dec 2016 18:19:22 +0000
Message-ID: <CAFEAcA-BbkYdTkTWQcqyK-jU+dncnrfDyGwQamMTZ4jr1VqL9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 05/20] arm: Move CPU files to target/ folder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, James Hogan <james.hogan@imgtec.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>

On 9 December 2016 at 12:17, Thomas Huth <thuth@redhat.com> wrote:
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index d4160df..60770d4 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -33,7 +33,7 @@
>  #include "qemu/bitmap.h"
>  #include "trace.h"
>  #include "qom/cpu.h"
> -#include "target-arm/cpu.h"
> +#include "cpu.h"
>  #include "hw/acpi/acpi-defs.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/nvram/fw_cfg.h"

Something looks wrong here. We definitely want the ARM
version of cpu.h, not any random cpu.h. The #include
filename should make it clear which file we're getting,
both so it's easier for humans to understand and so that
one day we might be able to build more than one target
CPU into the same QEMU binary.

thanks
-- PMM
