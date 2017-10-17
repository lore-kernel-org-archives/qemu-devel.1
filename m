Received: from eggs.gnu.org ([2001:4830:134:3::10]:36440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4Fci-000494-N2
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e4Fch-0000GF-V2
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 20:20:44 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171017001209.32276-1-f4bug@amsat.org>
	<20171017001209.32276-34-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6b73ec2e-8941-d12f-da08-9e7b2e04f80d@amsat.org>
Date: Mon, 16 Oct 2017 21:20:34 -0300
MIME-Version: 1.0
In-Reply-To: <20171017001209.32276-34-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 33/39] hw/net/ne2000: extract ne2k-isa
 code from i386/pc to ne2000-isa.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org

>  hw/net/ne2000.h             |  3 +++
>  include/hw/net/ne2000-isa.h | 33 +++++++++++++++++++++++++++++++++

I used "ne2000-isa.h" to match the source file, but the TYPE name is
"ne2k-isa", I'm not sure we care which one is better.

>  hw/net/ne2000-isa.c         |  6 ++----
>  hw/net/ne2000.c             |  2 --
