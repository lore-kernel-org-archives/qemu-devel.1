Received: from eggs.gnu.org ([2001:4830:134:3::10]:43857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1frzQa-00082H-IS
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:42:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1frzQZ-0002Uv-F1
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:42:04 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50150 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1frzQZ-0002Ub-97
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 01:42:03 -0400
Date: Tue, 21 Aug 2018 07:42:02 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180821054201.phmglqn52lbw4l2e@sirius.home.kraxel.org>
References: <20180726225900.180698-1-lepton@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726225900.180698-1-lepton@google.com>
Subject: Re: [Qemu-devel] [PATCH] sdl2: redraw correctly when scanout_mode
 enabled.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tao Wu <lepton@google.com>
Cc: qemu-devel@nongnu.org

On Thu, Jul 26, 2018 at 03:59:00PM -0700, Tao Wu wrote:
> When scanout_mode enabled, surface is out of sync with actual screen.
> In such case, we just call sdl2_gl_scanout_flush to do redraw. This
> fixes bug reported in
> https://lists.freedesktop.org/archives/virglrenderer-devel/2018-July/001330.html

Added to ui queue.

thanks,
  Gerd
