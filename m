Received: from eggs.gnu.org ([209.51.188.92]:52845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gxEvd-0001Bg-Re
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:48:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gxEvd-00084I-0m
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:48:05 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:36136)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1gxEvc-0007tw-NV
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 12:48:04 -0500
Date: Fri, 22 Feb 2019 20:47:54 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
Message-ID: <20190222174754.udxdxsezr5nfme6r@SPB-NB-133.local>
References: <20190214102816.3393-1-peter.maydell@linaro.org>
	<20190214102816.3393-4-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190214102816.3393-4-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 3/7] ui/cocoa: Factor out initial menu
 creation
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

On Thu, Feb 14, 2019 at 10:28:12AM +0000, Peter Maydell wrote:
> Factor out the long code sequence in main() which creates
> the initial set of menus. This will make later patches
> which move initialization code around a bit clearer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  ui/cocoa.m | 78 ++++++++++++++++++++++++++++--------------------------
>  1 file changed, 41 insertions(+), 37 deletions(-)
> 

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>

--
Roman
