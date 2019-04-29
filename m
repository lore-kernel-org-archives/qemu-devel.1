Received: from eggs.gnu.org ([209.51.188.92]:48371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hL3RK-0006W5-IW
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hL3Fv-0003A9-KE
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:11:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hL3Fv-000398-E5
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 06:11:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id s15so15106412wra.12
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 03:11:24 -0700 (PDT)
Date: Mon, 29 Apr 2019 12:11:20 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190429101120.bu5djv7pbwippq46@steredhat>
References: <20190414132008.uxoia6avdpp4jov6@steredhat.homenet.telecomitalia.it>
	<CA+aFP1D8VYcnwWpB=4PzAdBKr+YK-r8bSwzKKUCkH7jT3kVvoQ@mail.gmail.com>
	<20190415080452.GA6031@localhost.localdomain>
	<20190417073438.r57lemi6emu4x3ld@steredhat>
	<20190417080443.GA8330@localhost.localdomain>
	<20190419122356.7dmwwdbtnzgimydw@steredhat>
	<20190423075619.GB9041@localhost.localdomain>
	<20190423082657.mzulhihpv6rhgiww@steredhat>
	<20190423083805.GC9041@localhost.localdomain>
	<20190429095855.GC8492@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429095855.GC8492@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC 1/1] block/rbd: increase
 dynamically the image size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Josh Durgin <jdurgin@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

On Mon, Apr 29, 2019 at 11:58:55AM +0200, Kevin Wolf wrote:
> 
> Hm, this is an RFC patch, which suggests that it wasn't originally meant
> to be merged as it is. Are you going to send a new version, or did it
> turn out to be exactly what we want and the "RFC" tag was a mistake?

I put the "RFC" tag because I was not sure about this patch, but after
your comments and some tests on the rbd_resize() impact, I think that
it turns out exactly what we want.

If you agree, you can queue it as is.

Thanks,
Stefano
