Received: from eggs.gnu.org ([209.51.188.92]:52646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gxHHp-00055V-Ft
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 15:19:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gxHHl-0004Jp-Tr
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 15:19:06 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:38048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1gxHHl-00042A-J3
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 15:19:05 -0500
Date: Fri, 22 Feb 2019 23:18:33 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
Message-ID: <20190222201833.tlcmxheml3wbifzc@SPB-NB-133.local>
References: <20190214102816.3393-1-peter.maydell@linaro.org>
	<20190214102816.3393-7-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190214102816.3393-7-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 6/7] ui/cocoa: Subclass NSApplication so
 we can implement sendEvent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, John Arbuckle <programmingkidx@gmail.com>, Berkus Decker <berkus@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Ben Hekster <ben.hekster@foghorn.io>, BALATON Zoltan <balaton@eik.bme.hu>

On Thu, Feb 14, 2019 at 10:28:15AM +0000, Peter Maydell wrote:
> When we switch away from our custom event handling, we still want to
> be able to have first go at any events our application receives,
> because in full-screen mode we want to send key events to the guest,
> even if they would be menu item activation events. There are several
> ways we could do that, but one simple approach is to subclass
> NSApplication so we can implement a custom sendEvent method.
> Do that, but for the moment have our sendEvent just invoke the
> superclass method.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> New patch in v2
> ---
>  ui/cocoa.m | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>

Thanks,
Roman
