Received: from eggs.gnu.org ([2001:4830:134:3::10]:57521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1f57vr-0007KU-4O
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 06:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1f57vo-0000eF-44
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 06:52:23 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:43019)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1f57vn-0000dL-TD
	for qemu-devel@nongnu.org; Sun, 08 Apr 2018 06:52:20 -0400
Date: Sun, 8 Apr 2018 12:52:18 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180321135041.15768-1-kraxel@redhat.com>
Message-ID: <alpine.BSF.2.21.1804081251340.49362@zero.eik.bme.hu>
References: <20180321135041.15768-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH 0/5] sdl2 text console fixes and cleanups.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, 21 Mar 2018, Gerd Hoffmann wrote:
> Gerd Hoffmann (5):
>  ui: add ctrl modifier support to kbd_put_qcode_console()
>  sdl2: track kbd modifier state unconditionally
>  sdl2: enable ctrl modifier keys for text consoles
>  sdl2: drop QEMU_KEY_BACKSPACE special case
>  sdl2: drop dead code
>
> include/ui/console.h |  2 +-
> ui/console.c         | 15 +++++++++++++--
> ui/gtk.c             |  4 ++--
> ui/sdl2-input.c      | 46 ++++++++++++++++++++--------------------------
> 4 files changed, 36 insertions(+), 31 deletions(-)

Will this be included in 2.12? I haven't seen it reaching master yet.

Regards,
BALATON Zoltan
