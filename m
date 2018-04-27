Received: from eggs.gnu.org ([2001:4830:134:3::10]:52746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fBzD2-00053n-Mt
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 04:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fBzCm-0007XO-0u
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 04:58:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54108 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fBzCl-0007X2-NB
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 04:58:11 -0400
Date: Fri, 27 Apr 2018 10:58:09 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180427085809.ibyqvmq5fiugupc3@sirius.home.kraxel.org>
References: <3c36db1dc0702763ebb7966cc27428ed67d43804.1522751624.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c36db1dc0702763ebb7966cc27428ed67d43804.1522751624.git.mprivozn@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] ccid-card: include libcacard.h only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com

On Tue, Apr 03, 2018 at 12:34:37PM +0200, Michal Privoznik wrote:
> When trying to build with latest libcacard-2.5.1, I hit the
> following error:
> 
> In file included from hw/usb/ccid-card-passthru.c:12:0:
> /usr/include/cacard/vscard_common.h:26:2: error: #warning "Only <libcacard.h> can be included directly" [-Werror=cpp]
>  #warning "Only <libcacard.h> can be included directly"
> 
> While it was fixed in libcacard upstream (so that individual
> files can be included directly), it doesn't make much sense.
> Let's switch to including the main libcacard.h and also require
> at least libcacard-2.5.1 which introduced it. It's available
> since late 2015.

Added to usb queue.

thanks,
  Gerd
