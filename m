Received: from eggs.gnu.org ([209.51.188.92]:54075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzIgg-0005uN-HQ
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:13:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gzIge-0002yD-Rh
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:13:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gzIge-0002vu-Dp
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 05:13:08 -0500
Date: Thu, 28 Feb 2019 11:13:02 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190228101302.ap6fhzkixzu72ogd@sirius.home.kraxel.org>
References: <20190222224934.5822-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222224934.5822-1-bsd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] usb-mtp coverity fixes
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

On Fri, Feb 22, 2019 at 05:49:32PM -0500, Bandan Das wrote:
> Fix some coverity issues and a few others pointed out by Peter
> 
> Bandan Das (2):
>   usb-mtp: return incomplete transfer on a lstat failure
>   usb-mtp: fix some usb_mtp_write_data return paths

Series needs a rebase (conflicts with Daniel's inotify patches).

cheers,
  Gerd
