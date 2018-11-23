Received: from eggs.gnu.org ([2001:4830:134:3::10]:60186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQEb4-0005nu-E4
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:46:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gQEaz-00081k-HX
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:46:26 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gQEaz-0007zg-Ba
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:46:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id u13-v6so12587383wmc.4
	for <qemu-devel@nongnu.org>; Fri, 23 Nov 2018 08:46:21 -0800 (PST)
References: <20181123135450.24829-1-edgar.iglesias@gmail.com>
	<20181123135450.24829-2-edgar.iglesias@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <75bcddbc-da2d-aeb3-71d3-52b635520d2a@redhat.com>
Date: Fri, 23 Nov 2018 17:46:17 +0100
MIME-Version: 1.0
In-Reply-To: <20181123135450.24829-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 1/1] net: cadence_gem: Remove incorrect
 assert()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, muhammad_bilal@mentor.com, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

Hi Edgar,

On 23/11/18 14:54, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> 
> Don't assert on RX descriptor settings when the receiver is
> disabled. This fixes an issue with incoming packets on an
> unused GEM.
> 
> Reported-by: mbilal <muhammad_bilal@mentor.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> ---
>  hw/net/cadence_gem.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
> index d95cc27f58..7f63411430 100644
> --- a/hw/net/cadence_gem.c
> +++ b/hw/net/cadence_gem.c
> @@ -979,7 +979,6 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>  
>          /* Do nothing if receive is not enabled. */
>          if (!gem_can_receive(nc)) {
> -            assert(!first_desc);

Maybe worth:

               trace_gem_receive_packet_drop(size);

>              return -1;

Shouldn't this be 'return 0'?

The "net/net.h" doc is scarce...

Regards,

Phil.

>          }
>  
> 
