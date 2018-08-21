Received: from eggs.gnu.org ([2001:4830:134:3::10]:46907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1frzhI-0006US-6e
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:59:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1frzTC-0004FV-Hj
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:44:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50414 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1frzTC-0004FH-Cy
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:44:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 161C37D84D
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 05:44:46 +0000 (UTC)
Date: Tue, 21 Aug 2018 07:44:45 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180821054445.fueum54vpqdrnl2i@sirius.home.kraxel.org>
References: <1531161850-6860-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531161850-6860-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ui/sdl2: Fix broken -full-screen CLI option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Jul 09, 2018 at 08:44:10PM +0200, Thomas Huth wrote:
> We've got to set the gui_fullscreen variable before creating the
> SDL2 window, otherwise the initial window will not be created in
> fullscreen mode.

Added to ui queue.

thanks,
  Gerd
