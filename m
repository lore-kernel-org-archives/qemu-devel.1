Received: from eggs.gnu.org ([2001:4830:134:3::10]:34555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fKmrj-0001rJ-0d
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <simon@ruderich.org>) id 1fKmrf-0005Jw-TG
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:36:50 -0400
Received: from zucker2.schokokeks.org ([178.63.68.90]:51641)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <simon@ruderich.org>) id 1fKmrf-0005J6-Mq
	for qemu-devel@nongnu.org; Mon, 21 May 2018 11:36:47 -0400
From: Simon Ruderich <simon@ruderich.org>
Date: Mon, 21 May 2018 17:36:39 +0200
Message-Id: <cover.1526916378.git.simon@ruderich.org>
In-Reply-To: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
References: <0e59c79ddc01e195ddc59d77d9df2b95bf89b600.1523395243.git.simon@ruderich.org>
Subject: [Qemu-devel] [PATCH v3 0/5] qmp: add pmemload command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Simon Ruderich <simon@ruderich.org>

Hello,

This is third version of this patch set, rebased on current
master.

As I've received no answers to [1] (and I'd prefer to keep the
patch as is for now if possible) this doesn't include any changes
to address the comments to [2].

If there's anything else I can do to get these patches merged
please tell me.

Regards
Simon

[1]: <20180424145053.GA21648@ruderich.org>
     https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg03894.html
[2]: <6f775e11a75a2faa1c66a86e6d23a97f695c2ca1.1523537181.git.simon@ruderich.org>
     https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg01757.html

Simon Ruderich (5):
  cpus: correct coding style in qmp_memsave/qmp_pmemsave
  cpus: convert qmp_memsave/qmp_pmemsave to use qemu_open
  cpus: use size_t in qmp_memsave/qmp_pmemsave
  hmp: don't truncate size in hmp_memsave/hmp_pmemsave
  qmp: add pmemload command

 cpus.c          | 71 +++++++++++++++++++++++++++++++++++++++++++++------------
 hmp-commands.hx | 14 ++++++++++++
 hmp.c           | 16 +++++++++++--
 hmp.h           |  1 +
 qapi/misc.json  | 20 ++++++++++++++++
 5 files changed, 106 insertions(+), 16 deletions(-)

-- 
2.15.0
