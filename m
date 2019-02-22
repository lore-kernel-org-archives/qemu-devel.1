Received: from eggs.gnu.org ([209.51.188.92]:33659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gxFHP-0006Fz-4V
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 13:10:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1gxFHO-0008T0-Cl
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 13:10:35 -0500
Received: from mta-01.yadro.com ([89.207.88.251]:36470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1gxFHO-0008Ms-1k
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 13:10:34 -0500
Date: Fri, 22 Feb 2019 21:10:28 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
Message-ID: <20190222181028.iur2fxsifdstn4ob@SPB-NB-133.local>
References: <20190214102816.3393-1-peter.maydell@linaro.org>
	<20190214102816.3393-5-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190214102816.3393-5-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2 4/7] ui/cocoa: Move console/device menu
 creation code up in file
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

On Thu, Feb 14, 2019 at 10:28:13AM +0000, Peter Maydell wrote:
> Move the console/device menu creation code functions
> further up in the source file, next to the code which
> creates the initial menus. We're going to want to
> change the location we call these functions from in
> the next patch.
> 
> This commit is a pure code move with no other changes.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  ui/cocoa.m | 184 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 92 insertions(+), 92 deletions(-)
> 

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>

Thanks,
Roman
