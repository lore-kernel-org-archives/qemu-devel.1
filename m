Received: from eggs.gnu.org ([2001:4830:134:3::10]:36330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1em1io-0000CQ-U0
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:23:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1em1il-0003yw-LJ
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:23:58 -0500
Received: from mail-pl0-x232.google.com ([2607:f8b0:400e:c01::232]:36186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1em1il-0003yY-Fa
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 13:23:55 -0500
Received: by mail-pl0-x232.google.com with SMTP id v3so9001910plg.3
	for <qemu-devel@nongnu.org>; Wed, 14 Feb 2018 10:23:55 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Wed, 14 Feb 2018 12:23:42 -0600
Message-Id: <1518632624-29965-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v2 0/2] ipmi: Fix vmstate transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>

This took a while because I had other distractions and I spent some
time studying how all this vmstate code works, and that itself got
to be a distraction.

I'm not 100% sure what I have done is right.  Maybe there is a way to
do a backwards migration for KCS, but I'm not sure how.

Changes from v1:
  * Validate the data values in a pre_load functions.
  * For KCS, instead of an old function, create a separate vmstate
    structure for the new version.  The name on the old vmstate
    structure wasn't specific enough, so a new name was needed,
    The old structure is set up to never be sent, but it can be
    received.
