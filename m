Received: from eggs.gnu.org ([2001:4830:134:3::10]:56458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gPSER-0001xL-37
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:07:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gPSEP-0002Gj-1q
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:07:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gPSEN-0002DW-2W
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 08:07:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70A26C04959F
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 13:07:45 +0000 (UTC)
Date: Wed, 21 Nov 2018 14:07:43 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181121130743.3wz5ggbwslj4fwmd@sirius.home.kraxel.org>
References: <20181030082340.17170-1-kraxel@redhat.com>
	<20181112131835.xccqqvhu63xhh7pk@sirius.home.kraxel.org>
	<nycvar.YSQ.7.76.1811211613440.4176@xnncv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1811211613440.4176@xnncv>
Subject: Re: [Qemu-devel] [PATCH] fmops: fix off-by-one in AR_TABLE and
 DR_TABLE array size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Nov 21, 2018 at 04:19:11PM +0530, P J P wrote:
>  Hello Gerd,
> 
> +-- On Mon, 12 Nov 2018, Gerd Hoffmann wrote --+
> | On Tue, Oct 30, 2018 at 09:23:40AM +0100, Gerd Hoffmann wrote:
> | > Fixes: CVE-2018-???
> | > Cc: P J P <ppandit@redhat.com>
> | 
> | ping, do we have a cve number meanwhile?
> 
> No, the off-by-one does not seem to have an adverse effect. One byte past 
> AR_TABLE[75] array would likely read into DR_TABLE[75] array, which would 
> anyway be accessible to a driver. It does not seem to crash Qemu either. I 
> think it's more of a bug fix, than security fix. Hope that's okay.

Ok, makes sense, I'll drop the cve line then and queue the patch.

cheers,
  Gerd
