Received: from eggs.gnu.org ([2001:4830:134:3::10]:43708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dv0Xv-0003nJ-G6
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:25:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dv0Xr-00059N-IE
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:25:35 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dv0Xr-00058d-Aq
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 08:25:31 -0400
Received: by mail-wr0-x242.google.com with SMTP id n64so3064044wrb.2
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 05:25:31 -0700 (PDT)
Date: Thu, 21 Sep 2017 13:25:28 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170921122528.GF32364@stefanha-x1.localdomain>
References: <20170921013821.1673-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170921013821.1673-1-jsnow@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] ide: fix enum comparison for gcc 4.7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk

On Wed, Sep 20, 2017 at 09:38:21PM -0400, John Snow wrote:
> Apparently GCC gets bent over comparing enum values against zero.
> Replace the conditional with something less readable.
> 
> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Signed-off-by: John Snow <jsnow@redhat.com>
> 
> ---
> 
> v2: Second verse, same as the first.
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  hw/ide/ahci.c             | 2 +-
>  hw/ide/core.c             | 2 +-
>  include/hw/ide/internal.h | 3 +--
>  3 files changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
