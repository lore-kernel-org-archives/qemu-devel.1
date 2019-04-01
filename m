Received: from eggs.gnu.org ([209.51.188.92]:43847)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hAqyp-0001Z3-45
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 03:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hAqyo-0007Yv-78
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 03:03:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49602)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hAqyn-0007W9-Vs
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 03:03:38 -0400
Date: Mon, 1 Apr 2019 08:56:20 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190401065620.qca6h5qxxapdoyq5@sirius.home.kraxel.org>
References: <20190328173722.26465-1-bsd@redhat.com>
	<20190328173722.26465-2-bsd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328173722.26465-2-bsd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2 v3] usb-mtp: remove
 usb_mtp_object_free_one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On Thu, Mar 28, 2019 at 01:37:21PM -0400, Bandan Das wrote:
> This function is used in the delete path only and can
> be replaced by a call to usb_mtp_object_free.
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Bandan Das <bsd@redhat.com>

Tried to cherry-pick this one for 4.0 (I think we should leave 2/2 to
4.1 at this point).  Doesn't apply to master, seems to depend on a
not-yet merged patch.  Can you re-post this one and the depending patch
please?

thanks,
  Gerd
