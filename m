Received: from eggs.gnu.org ([2001:4830:134:3::10]:44712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1djY3e-0007Fa-85
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 17:46:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1djY3a-0003qE-Ke
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 17:46:58 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:34446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1djY3a-0003pd-F5
	for qemu-devel@nongnu.org; Sun, 20 Aug 2017 17:46:54 -0400
Received: by mail-pg0-x231.google.com with SMTP id n4so24380976pgn.1
	for <qemu-devel@nongnu.org>; Sun, 20 Aug 2017 14:46:53 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Sun, 20 Aug 2017 16:46:39 -0500
Message-Id: <1503265602-9349-1-git-send-email-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/3] ipmi: Fix SEL get/set time commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

Resend, with the style issues and the problem that Cédric pointed
out.
Thanks Cédric, for the review.

Changes from v1:

 * Get the data from the proper offset in the command array.
 * Use {} on all if statements.
