Received: from eggs.gnu.org ([2001:4830:134:3::10]:42995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1frzO4-0005HC-6Y
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:39:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1frzNS-0008MI-2k
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:38:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38724 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1frzNR-0008L2-UA
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:38:50 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 081CD40216E8
	for <qemu-devel@nongnu.org>; Tue, 21 Aug 2018 05:38:48 +0000 (UTC)
Date: Tue, 21 Aug 2018 07:38:47 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180821053847.tozku46h2mcs6lnt@sirius.home.kraxel.org>
References: <1533721602-15763-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533721602-15763-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.1] ui/sdl2: Remove the obsolete
 SDL_INIT_NOPARACHUTE flag
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

On Wed, Aug 08, 2018 at 11:46:42AM +0200, Thomas Huth wrote:
> SDL_INIT_NOPARACHUTE is not used in SDL2 anymore, and the define is just
> a dummy (see https://wiki.libsdl.org/MigrationGuide#Some_general_truths
> for example). So we can remove it and get rid of the "flags" variable
> nowadays.

Added to ui queue.

thanks,
  Gerd
