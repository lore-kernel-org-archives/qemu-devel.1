Received: from eggs.gnu.org ([2001:4830:134:3::10]:40885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJZPx-0007od-70
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fJZPu-0000yt-0x
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:03:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42110 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fJZPt-0000yf-Tp
	for qemu-devel@nongnu.org; Fri, 18 May 2018 03:03:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 79547401EF14
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 07:03:05 +0000 (UTC)
Date: Fri, 18 May 2018 09:03:04 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180518070304.ddmstz5cehaltbjs@sirius.home.kraxel.org>
References: <1526560782-18732-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526560782-18732-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ui: add x_keymap.o to modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, May 17, 2018 at 02:39:42PM +0200, Paolo Bonzini wrote:
> x_keymap.o is common to the SDL and GTK+ modules, and it causes the
> QEMU binary to link to the X11 libraries.  Add it separately to the
> modules to keep the main QEMU binary smaller.

Added to ui patch queue.

thanks,
  Gerd
