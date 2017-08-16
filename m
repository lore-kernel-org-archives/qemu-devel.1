Received: from eggs.gnu.org ([2001:4830:134:3::10]:39773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1di5rJ-0003lm-7z
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 17:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1di5rG-0005Tx-5H
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 17:28:13 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1di5rF-0005TR-VE
	for qemu-devel@nongnu.org; Wed, 16 Aug 2017 17:28:10 -0400
Received: by mail-pg0-x244.google.com with SMTP id y129so6463775pgy.3
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 14:28:08 -0700 (PDT)
Date: Thu, 17 Aug 2017 06:28:04 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170816212804.GF3031@lianli.shorne-pla.net>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-27-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1500040339-119465-27-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 26/28] openrisc: replace
 cpu_openrisc_init() with cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Jia Liu <proljc@gmail.com>

On Fri, Jul 14, 2017 at 03:52:17PM +0200, Igor Mammedov wrote:
> it's just a wrapper, drop it and use cpu_generic_init() directly
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: Jia Liu <proljc@gmail.com>
> CC: Stafford Horne <shorne@gmail.com>
> ---
>  target/openrisc/cpu.h      | 4 +---
>  hw/openrisc/openrisc_sim.c | 2 +-
>  target/openrisc/cpu.c      | 5 -----
>  3 files changed, 2 insertions(+), 9 deletions(-)

Sorry, I thought I had acked this earlier.

Acked-by: Stafford Horne <shorne@gmail.com>
