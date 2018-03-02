Received: from eggs.gnu.org ([2001:4830:134:3::10]:57988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1erma7-00050A-Nf
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:26:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1erma6-0005KZ-NS
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:26:47 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:36496)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1erma6-0005JY-Hu
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:26:46 -0500
Received: by mail-oi0-x242.google.com with SMTP id u73so7291620oie.3
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 07:26:45 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Fri,  2 Mar 2018 09:26:35 -0600
Message-Id: <1520004397-28521-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH v2 0/2] ipmi: Fix vmstate transfer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>

I apologize for the resend, I left the list off the previous post.

This is unchanged since the previous post, two weeks ago.  I received
no comments, so I guess it's ok.  It's fairly broken now, so I would
like this fixed.

Changes from v1:
  * Validate the data values in pre_load functions.
  * For KCS, instead of an old function, create a separate vmstate
    structure for the new version.  The name on the old vmstate
    structure wasn't specific enough, so a new name was needed,
    The old structure is set up to never be sent, but it can be
    received.

The following changes since commit 427cbc7e4136a061628cb4315cc8182ea36d772f:

  Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2018-03-01 18:46:41 +0000)

are available in the git repository at:

  https://github.com/cminyard/qemu.git tags/ipmi-vmstate-fixes

for you to fetch changes up to 90797371d9a3138657e7b1f7ab4425eb67d6fd0a:

  ipmi: Use proper struct reference for BT vmstate (2018-03-02 07:48:39 -0600)

----------------------------------------------------------------
Fix the IPMI vmstate code to work correctly in all cases.  Heavily
tested under load.

----------------------------------------------------------------
Corey Minyard (2):
      ipmi: Use proper struct reference for KCS vmstate
      ipmi: Use proper struct reference for BT vmstate

 hw/ipmi/isa_ipmi_bt.c  | 61 ++++++++++++++++++++++++++++++---------
 hw/ipmi/isa_ipmi_kcs.c | 77 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 123 insertions(+), 15 deletions(-)
