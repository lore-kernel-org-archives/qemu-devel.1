Received: from eggs.gnu.org ([2001:4830:134:3::10]:44938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBM33-0008Uk-PD
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:09:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBM2z-0006cK-MP
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:09:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42542 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fBM2z-0006cB-Ha
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:09:29 -0400
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-11-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <19b0361f-76f0-6c13-5e4f-2af792b5145d@redhat.com>
Date: Wed, 25 Apr 2018 17:09:21 +0200
MIME-Version: 1.0
In-Reply-To: <20180420145249.32435-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/13] serial-isa: Use MAX_ISA_SERIAL_PORTS
 instead of MAX_SERIAL_PORTS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, patches@linaro.org

On 20.04.2018 16:52, Peter Maydell wrote:
> The ISA serial port handling in serial-isa.c imposes a limit
> of 4 serial ports. This is because we only know of 4 IO port
> and IRQ settings for them, and is unrelated to the generic
> MAX_SERIAL_PORTS limit, though they happen to both be set at
> 4 currently.
> 
> Use a new MAX_ISA_SERIAL_PORTS wherever that is the correct
> limit to be checking against.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/char/serial.h |  3 +++
>  hw/char/serial-isa.c     | 10 +++++-----
>  hw/i386/pc.c             |  2 +-
>  hw/mips/mips_r4k.c       |  2 +-
>  hw/ppc/pnv.c             |  2 +-
>  hw/sparc64/sun4u.c       |  2 +-
>  6 files changed, 12 insertions(+), 9 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
