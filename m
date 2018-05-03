Received: from eggs.gnu.org ([2001:4830:134:3::10]:32886)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEFm4-0006Ul-2Y
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:04:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fEFly-000544-G0
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:04:00 -0400
Received: from mail-ot0-x22e.google.com ([2607:f8b0:4003:c0f::22e]:33403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fEFly-00053s-BW
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:03:54 -0400
Received: by mail-ot0-x22e.google.com with SMTP id l22-v6so21003176otj.0
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 08:03:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1525176522-200354-1-git-send-email-imammedo@redhat.com>
References: <1525176522-200354-1-git-send-email-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 May 2018 16:03:33 +0100
Message-ID: <CAFEAcA9nG0_Eq1QWsCJMA6TKbZ_tf6mXWCVTrkxrFO5-UkmEvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 0/5] arm: isolate and clean up dtb
 generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>

On 1 May 2018 at 13:08, Igor Mammedov <imammedo@redhat.com> wrote:
>
> Changelog v2->v3:
>    * drop already merged patches
>        'arm: always start from  first_cpu when registering loader cpu reset callback'
>        'ppc: e500: switch E500 based  machines to full machine definition'
>    * add small not related cleanup
>        'arm: boot: set boot_info starting from first_cpu'
>    * add extra suggested patch
>        'make sure that we aren't overwriting mc->get_hotplug_handler by accident'
>    * make sure that dtb_limit initialized to 0
>    * drop stale comment
>    * drop not needed line movement
>    * drop not needed extra new line
> Changelog v1->v2:
>    * drop "arm: reuse  arm_boot_address_space() in armv7m_load_kernel()"
>    * move "arm: always start from first_cpu  when registering loader cpu reset callback"
>      at the begigning of series and rebase
>    * add "ppc: e500: switch E500 based machines to full  machine definition"
>      and rebase 4/5 on top of it
>    * fixup typo in virt_machine_get_hotpug_handler() name
>    * add doc comment to skip_dtb_autoload field
>    * 1-2/5 are queued in respective arm/ppc trees and are included for series
>      completness so it would be easier to test, I expect series to go through
>      arm tree
>

Applied to target-arm.next, thanks.
-- PMM
