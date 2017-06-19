Received: from eggs.gnu.org ([2001:4830:134:3::10]:57325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tobleminer@gmail.com>) id 1dN6GA-0005CZ-8E
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 19:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tobleminer@gmail.com>) id 1dN6G9-000050-EY
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 19:39:06 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:36849)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tobleminer@gmail.com>)
	id 1dN6G9-0008WV-7L
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 19:39:05 -0400
Received: by mail-wr0-x243.google.com with SMTP id 77so15468658wrb.3
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 16:39:05 -0700 (PDT)
From: Tobias Schramm <tobleminer@gmail.com>
Date: Tue, 20 Jun 2017 01:37:17 +0200
Message-Id: <20170619233718.24959-1-tobleminer@gmail.com>
Subject: [Qemu-devel] [PATCH v5 0/1] 9pfs: local: Add support for custom
 fmode/dmode in 9ps mapped security modes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aneesh.kumar@linux.vnet.ibm.com, groug@kaod.org, el13635@mail.ntua.gr, Tobias Schramm <tobleminer@gmail.com>

Hi Greg,

thank you for your hints on improving this patch. I've implemented them all
in this version.

In the last version of the patch I moved the path check down because I moved
the g_strdup and tried to keep all operations performed on path as close
together as possible to increase readability. But I clearly didn't think of
madatory vs optional aguments.

I introduced extra variables for fmode and dmode for clear separation of
fetching and processing of arguments. But I guess that trade off is just
personal preference.

I do agree that unifying the mapped mode checks is a good idea. Considering
that it is used in quite a few places might it be a good idea to write a macro
for that check?

Also I have added a much more descriptive commit message.

Again, thank you for the great help (and patience :)).

Regards,

Tobias Schramm

Tobias Schramm (1):
  9pfs: local: Add support for custom fmode/dmode in 9ps mapped security
    modes

 fsdev/file-op-9p.h      |  4 ++++
 fsdev/qemu-fsdev-opts.c | 12 ++++++++++++
 hw/9pfs/9p-local.c      | 25 +++++++++++++++++++++----
 hw/9pfs/9p.c            |  3 +++
 qemu-options.hx         | 20 ++++++++++++++++----
 5 files changed, 56 insertions(+), 8 deletions(-)

-- 
2.13.1
