Received: from eggs.gnu.org ([2001:4830:134:3::10]:35091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=44841c655=anthony.perard@citrix.com>)
	id 1e1ZTD-0002wk-Il
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=44841c655=anthony.perard@citrix.com>)
	id 1e1ZTA-0001pR-Gz
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:55:51 -0400
Received: from smtp02.citrix.com ([66.165.176.63]:14264)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=44841c655=anthony.perard@citrix.com>)
	id 1e1ZTA-0001oD-Aj
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 10:55:48 -0400
Date: Mon, 9 Oct 2017 15:55:42 +0100
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20171009145542.GA1771@perard.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] =?utf-8?b?4oCYdnRlX3Rlcm1pbmFsX2NvcHlfY2xpcGJvYXJk?=
 =?utf-8?q?=E2=80=99_is_deprecated?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Hi,

Looks like vte_terminal_copy_clipboard() is been deprecated:

  CC      ui/gtk.o
ui/gtk.c: In function ‘gd_menu_copy’
ui/gtk.c:1705:5: error: ‘vte_terminal_copy_clipboard’ is deprecated [-Werror=deprecated-declarations]
     vte_terminal_copy_clipboard(VTE_TERMINAL(vc->vte.terminal));
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
In file included from /usr/include/vte-2.91/vte/vte.h:35:0,
                 from ui/gtk.c:47:
/usr/include/vte-2.91/vte/vtedeprecated.h:94:6: note: declared here
 void vte_terminal_copy_clipboard(VteTerminal *terminal) _VTE_GNUC_NONNULL(1);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make: *** [/local/home/sheep/work/qemu/rules.mak:66: ui/gtk.o] Error 1


Package version:

$ pacman -Qo /usr/include/vte-2.91/vte/vte.h
/usr/include/vte-2.91/vte/vte.h is owned by vte3 0.50.1-1

Regards,

-- 
Anthony PERARD
