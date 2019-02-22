Received: from eggs.gnu.org ([209.51.188.92]:43644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gxEbi-0003Et-AS
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:27:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gxEbg-000171-9R
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:27:30 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:35758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1gxEbe-0000U9-AL
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:27:28 -0500
Date: Fri, 22 Feb 2019 20:27:02 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
Message-ID: <20190222172702.bl7jmvklbmqvdty5@SPB-NB-133.local>
References: <20190214102816.3393-1-peter.maydell@linaro.org>
	<20190214102816.3393-3-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190214102816.3393-3-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/7] ui/cocoa: Use the pixman image
 directly in switchSurface
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

On Thu, Feb 14, 2019 at 10:28:11AM +0000, Peter Maydell wrote:
> Currently the switchSurface method takes a DisplaySurface. We want
> to change our DisplayChangeListener's dpy_gfx_switch callback
> to do this work asynchronously on a different thread. The caller
> of the switch callback will free the old DisplaySurface
> immediately the callback returns, so to ensure that the
> other thread doesn't access freed data we need to switch
> to using the underlying pixman image instead. The pixman
> image is reference counted, so we will be able to take
> a reference to it to avoid it vanishing too early.
> 
> In this commit we only change the switchSurface method
> to take a pixman image, and keep the flow of control
> synchronous for now.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  ui/cocoa.m | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>

Thanks,
Roman
