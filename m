Received: from eggs.gnu.org ([2001:4830:134:3::10]:56672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dWI55-0003IM-85
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 04:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1dWI50-0003IE-Is
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 04:05:39 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1dWI50-0003Ho-CS
	for qemu-devel@nongnu.org; Sat, 15 Jul 2017 04:05:34 -0400
Received: by mail-wr0-f196.google.com with SMTP id 77so13176519wrb.3
	for <qemu-devel@nongnu.org>; Sat, 15 Jul 2017 01:05:32 -0700 (PDT)
Date: Sat, 15 Jul 2017 10:05:22 +0200
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20170715100522.29da4e32@thl530.SpeedportEntry2090126200030>
In-Reply-To: <1500040339-119465-15-git-send-email-imammedo@redhat.com>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-15-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 14/28] m68k: replace cpu_m68k_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>

Am Fri, 14 Jul 2017 15:52:05 +0200
schrieb Igor Mammedov <imammedo@redhat.com>:

> call register_m68k_insns() at realize time which makes
> cpu_m68k_init() typical object creation function.
> As result we can replace it with cpu_generic_init()
> which does the same job, reducing code duplication a bit.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: Thomas Huth <huth@tuxfamily.org>
> CC: Laurent Vivier <laurent@vivier.eu>
> ---
>  target/m68k/cpu.h    |  3 +--
>  hw/m68k/an5206.c     |  2 +-
>  hw/m68k/mcf5208.c    |  2 +-
>  target/m68k/cpu.c    |  2 ++
>  target/m68k/helper.c | 20 --------------------
>  5 files changed, 5 insertions(+), 24 deletions(-)

Patch looks good, and the Coldfire images that I have still boot fine:

Tested-by: Thomas Huth <huth@tuxfamily.org>
