Received: from eggs.gnu.org ([2001:4830:134:3::10]:56617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dlChP-0001HE-Ue
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:22:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dlChM-0007rC-PF
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:22:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dlChM-0007qx-IT
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:22:48 -0400
Message-ID: <1503660166.9107.6.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 25 Aug 2017 13:22:46 +0200
In-Reply-To: <cd7ebf5c-6d81-6cdf-f6b2-87af4cb00f85@redhat.com>
References: <20170824091907.17676-1-kraxel@redhat.com>
	<cd7ebf5c-6d81-6cdf-f6b2-87af4cb00f85@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vga: stop passing pointers to
 vga_draw_line* functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: d@vidbuchanan.co.uk, P J P <ppandit@redhat.com>

  Hi,

> s/simliar/similar/
> s/priviledged/privileged/

Fixed.

> > a segfault, when hitting the guard page after vga memory
> > allocation, while reading vga memory for display updates.
> > 
> > Fixes: CVE-2017-xxxx
> 
> Do we have the actual number?

Not yet, pjp still busy getting one, but will be filled for the final
version of the patch.

> Are we trying to get this in 2.10-rc4, or
> is it merely 2.11 + qemu-stable (2.10.1) material?

IMO it isn't critical enough to squeeze the non-trivial patch into 2.10
the last minute, so qemu-stable.

cheers,
  Gerd
