Received: from eggs.gnu.org ([2001:4830:134:3::10]:32909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1ceWom-0003tY-FR
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 19:54:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1ceWoj-0001ot-Ti
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 19:54:36 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:33228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1ceWoj-0001oS-Pv
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 19:54:33 -0500
Received: by mail-qk0-x242.google.com with SMTP id 11so4721565qkl.0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 16:54:33 -0800 (PST)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Thu, 16 Feb 2017 19:54:29 -0500
Message-Id: <20170217005431.4016-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [PATCH 0/2] Add mardown formatting to README
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org, berrange@redhat.com, eblake@redhat.com

Also create README.md as a symlink to README so that github displays
markdown.

Update the README file to markdown so that it makes the github page
look prettier. I know that github repo is a mirror and not the
official repo, but I think it doesn't hurt to have it in markdown
format.

The last time we tried, it caused issues for building installers and
the check patch. Creating a symlink will hopefully avoid those.

To compare, you can take a look at the following links:

old: https://github.com/pranith/qemu/
new: https://github.com/pranith/qemu/tree/readme

Pranith Kumar (2):
  Update README to accomodate markdown format
  Create README.md as a symlink to README

 README    | 44 +++++++++++++++++++++-----------------------
 README.md |  1 +
 2 files changed, 22 insertions(+), 23 deletions(-)
 create mode 120000 README.md

-- 
2.11.0
