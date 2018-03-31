Received: from eggs.gnu.org ([2001:4830:134:3::10]:59243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiangshanlai@gmail.com>) id 1f2Da8-0001OB-HK
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 06:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiangshanlai@gmail.com>) id 1f2Da7-0006ob-I3
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 06:17:56 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:42772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiangshanlai@gmail.com>)
	id 1f2Da7-0006o8-DH
	for qemu-devel@nongnu.org; Sat, 31 Mar 2018 06:17:55 -0400
Received: by mail-io0-x243.google.com with SMTP id d5so13277534iob.9
	for <qemu-devel@nongnu.org>; Sat, 31 Mar 2018 03:17:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180331084500.33313-1-jiangshanlai@gmail.com>
References: <20180331084500.33313-1-jiangshanlai@gmail.com>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Sat, 31 Mar 2018 18:17:54 +0800
Message-ID: <CAJhGHyDvag1eK24-NF-sTDJL27o8dAvE-rcde0doBX=s0t-3Vg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] migration: add capability to bypass the
 shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, "James O . D . Hunt" <james.o.hunt@intel.com>, Xu Wang <gnawux@gmail.com>, Peng Tao <bergwolf@gmail.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

The attached patch is based on v2.11.1.  It was pushed on
https://github.com/hyperhq/qemu v2.11.1-template

The updated patch for upstream qemu is on
https://github.com/hyperhq/qemu upstream-template


On Sat, Mar 31, 2018 at 4:45 PM, Lai Jiangshan <jiangshanlai@gmail.com> wrote:

> ---
>  migration/migration.c | 13 +++++++++++++
>  migration/migration.h |  1 +
>  migration/ram.c       | 26 +++++++++++++++++---------
>  qapi/migration.json   |  8 +++++++-
>  4 files changed, 38 insertions(+), 10 deletions(-)
>
