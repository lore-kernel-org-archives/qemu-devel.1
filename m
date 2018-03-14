Received: from eggs.gnu.org ([2001:4830:134:3::10]:44194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1evyjZ-0005ju-W8
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 01:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1evyjW-0001ux-SX
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 01:13:53 -0400
Received: from chuckie.co.uk ([82.165.15.123]:58290
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1evyjW-0001s3-La
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 01:13:50 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <c0a2dcfb-1a30-e77c-0c8a-1f0b3aafbecf@ilande.co.uk>
Date: Wed, 14 Mar 2018 05:13:23 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] GTK warnings on console when closing window
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>

Rebasing a couple of my development branches onto master this morning, 
I'm noticing some GTK warnings when I close the QEMU GTK window directly 
rather than using the "Quit" menu option:

$ ./qemu-system-ppc
(qemu-system-ppc:19782): GLib-GObject-WARNING **: invalid unclassed 
pointer in cast to 'GtkCheckMenuItem'

(qemu-system-ppc:19782): Gtk-CRITICAL **: 
gtk_check_menu_item_set_active: assertion 'GTK_IS_CHECK_MENU_ITEM 
(check_menu_item)' failed

(qemu-system-ppc:19782): GLib-GObject-WARNING **: invalid unclassed 
pointer in cast to 'GtkWindow'

(qemu-system-ppc:19782): Gtk-CRITICAL **: gtk_window_set_title: 
assertion 'GTK_IS_WINDOW (window)' failed


ATB,

Mark.
