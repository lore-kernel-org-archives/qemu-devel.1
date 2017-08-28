Received: from eggs.gnu.org ([2001:4830:134:3::10]:55861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1dmSGe-0005HB-AP
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 18:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1dmSGb-0000ZH-6K
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 18:12:24 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:36545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1dmSGb-0000Yi-0h
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 18:12:21 -0400
Received: by mail-pf0-x22a.google.com with SMTP id z87so4877876pfi.3
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 15:12:20 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Mon, 28 Aug 2017 17:12:07 -0500
Message-Id: <1503958330-14083-1-git-send-email-minyard@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/3] ipmi: Fix some minor issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>

I think this is ready, can someone pick this up?

Thanks,

-corey

Changes from v2:

 * Add Cédric's reviews

Changes from v1:

 * Get the data from the proper offset in the command array.
 * Use {} on all if statements.
