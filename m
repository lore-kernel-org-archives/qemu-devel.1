Received: from eggs.gnu.org ([2001:4830:134:3::10]:50709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1fBMKe-0001r8-9f
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:27:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1fBMKd-0007hO-D9
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:27:44 -0400
Received: from mail-pf0-x22f.google.com ([2607:f8b0:400e:c00::22f]:43068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1fBMKd-0007g5-77
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:27:43 -0400
Received: by mail-pf0-x22f.google.com with SMTP id j11so15517831pff.10
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 08:27:43 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Wed, 25 Apr 2018 10:27:29 -0500
Message-Id: <1524670052-28373-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v3 0/3] ipmi: Fix vmstate transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

I was going to just re-send the previous versions of these, but after
looking I realized it would have the same misuse of vmstate_register(),
and I didn't have a way to work around it.  I had already done the
VMSTATE_VSTRUCT work earlier, so I merged that in.

Changes from v2:
  * Added VMSTATE_VSTRUCT types of vmstate macros that allow the
    specific structure version used to be specified.
  * Reworked the KCS vmstate code to use the new VMSTATE_VSTRUCT
    macros.

Changes from v1:
  * Validate the data values in pre_load functions.
  * For KCS, instead of an old function, create a separate vmstate
    structure for the new version.  The name on the old vmstate
    structure wasn't specific enough, so a new name was needed,
    The old structure is set up to never be sent, but it can be
    received.
