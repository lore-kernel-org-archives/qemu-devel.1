Received: from eggs.gnu.org ([209.51.188.92]:59917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hBC9S-0001v1-Rz
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 01:40:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hBC9Q-00085X-MC
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 01:40:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51738)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hBC9Q-00084H-CL
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 01:40:00 -0400
Date: Tue, 2 Apr 2019 07:39:55 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190402053955.yysbzpcxvj46f5ja@sirius.home.kraxel.org>
References: <20190401211712.19012-1-bsd@redhat.com>
	<20190401211712.19012-3-bsd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190401211712.19012-3-bsd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/3] usb-mtp: remove
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

On Mon, Apr 01, 2019 at 05:17:11PM -0400, Bandan Das wrote:
> This function is used in the delete path only and can
> be replaced by a call to usb_mtp_object_free.

Queued patch 1+2, leaving 3 for later.

cheers,
  Gerd
