Received: from eggs.gnu.org ([2001:4830:134:3::10]:40340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gABRo-0000XB-GR
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 06:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gABRj-0001aO-DY
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 06:10:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gABRj-0001Yz-3q
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 06:10:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 220CB8666D
	for <qemu-devel@nongnu.org>; Wed, 10 Oct 2018 10:10:26 +0000 (UTC)
Date: Wed, 10 Oct 2018 12:10:25 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181010101025.kck5epmrqurpbeg6@sirius.home.kraxel.org>
References: <20181008185013.19371-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008185013.19371-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] sdl2: Support all virtio-gpu formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Oct 08, 2018 at 08:50:13PM +0200, Max Reitz wrote:
> There are some 2D resource formats that can be used through virtio-gpu,

Ahem, not really.  XRGB is the only one which works in practice, and
virtio-gpu kms driver will stop advertising anything else soon (patches
should land upstream with the next merge window).

> Add these formats in the switch converting pixman to SDL format
> constants so a guest cannot crash the VM by triggering the
> g_assert_not_reached() with an unsupported format.

Do you have a reproducer for that?

There is sdl2_2d_check_format() which reports the supported formats.
If we hit sdl2_2d_switch() with a format not whitelisted by
sdl2_2d_check_format() we have a bug somewhere in qemu ...

cheers,
  Gerd
