Received: from eggs.gnu.org ([2001:4830:134:3::10]:44334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1frzSa-0000ub-Fq
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:44:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1frzSV-0003cM-DX
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:44:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53628 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1frzSV-0003c8-8u
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:44:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1A3D804BAAD
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 05:44:02 +0000 (UTC)
Date: Tue, 21 Aug 2018 07:43:59 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180821054359.el6y3muvivz7kiur@sirius.home.kraxel.org>
References: <20180720063109.4631-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180720063109.4631-1-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [RFC/RFT PATCH 0/2] spice-display locking fixes
 (cursors)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Fri, Jul 20, 2018 at 08:31:07AM +0200, Paolo Bonzini wrote:
> The first issue was found by Coverity and should be trivial.  The second
> however made me wonder how to test the code and whether it has ever
> worked, because in theory it should be an instant deadlock whenever
> qemu_spice_cursor_refresh_bh is called.

Added to ui queue.

thanks,
  Gerd
