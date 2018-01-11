Received: from eggs.gnu.org ([2001:4830:134:3::10]:56634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eZds2-0007h6-Fg
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:30:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1eZdrx-00070H-Je
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:30:18 -0500
References: <1515607608-18250-1-git-send-email-thuth@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <69822e79-70af-a8f2-5e21-9b7c403f0ec3@msgid.tls.msk.ru>
Date: Thu, 11 Jan 2018 17:29:12 +0300
MIME-Version: 1.0
In-Reply-To: <1515607608-18250-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] ui/sdl2: Ignore key repeats for shortcut
 keys
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

10.01.2018 21:06, Thomas Huth wrote:
> Holding down a shortcut key currently continuesly triggers the shortcut
> event, e.g. holding CTRL-ALT-f continuesly switches between windowed and
> fullscreen mode, or holding CTRL-ALT-u even crashes QEMU with a segfault.
> This is ugly, we should rather ignore automatic key repeats when handling
> the keyboard shortcuts.

Applied to -trivial, thank you!

/mjt
