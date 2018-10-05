Received: from eggs.gnu.org ([2001:4830:134:3::10]:47461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8MRW-0001qo-IE
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g8MMA-0000EN-73
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:25:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g8MMA-0000DV-0z
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:25:10 -0400
Date: Fri, 5 Oct 2018 11:25:07 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181005092507.kwhmkp3cf6sq2jwb@sirius.home.kraxel.org>
References: <20181002121935.23706-1-remy.noel@blade-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181002121935.23706-1-remy.noel@blade-group.com>
Subject: Re: [Qemu-devel] [PATCH v2] secondary-vga: delete mmio subregions
 upon exit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: remy.noel@blade-group.com
Cc: qemu-devel@nongnu.org

On Tue, Oct 02, 2018 at 02:19:35PM +0200, remy.noel@blade-group.com wrote:
> From: "remy.noel" <remy.noel@blade-group.com>
> 
> 93abfc88bd649de1933588bfc7175605331b3ea9 introduced a reference cycle in
> the vga-pci devices, preventing cleanup of the object upon hotblug.
> 
> This patch allows to break the cycle.

Added to vga queue.

thanks,
  Gerd
