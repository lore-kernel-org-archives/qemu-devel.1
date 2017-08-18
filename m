Received: from eggs.gnu.org ([2001:4830:134:3::10]:54572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1dii2w-0005XJ-Ri
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1dii2v-0005S7-Nm
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:14:46 -0400
Received: from mail-yw0-x22d.google.com ([2607:f8b0:4002:c05::22d]:33584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
	id 1dii2v-0005R9-Hg
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:14:45 -0400
Received: by mail-yw0-x22d.google.com with SMTP id p68so59582759ywg.0
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 07:14:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170815130740.31229-1-famz@redhat.com>
References: <20170815130740.31229-1-famz@redhat.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Fri, 18 Aug 2017 16:14:14 +0200
Message-ID: <CAATJJ0JcB4-S88oKKm9BEB_8ZcJQHb7bmBT--iVqazJWHtrkpg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.10 v2 0/4] block: Fix non-shared
 storage migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Aug 15, 2017 at 3:07 PM, Fam Zheng <famz@redhat.com> wrote:

> v2: Don't leak blk->vmsh when BB is deleted before the callback is called.
>     [Stefan]
>     From stub functions, don't return g_malloc0(1) which is risky, return
> NULL.
>     [Eric]


Thanks Fam Zheng and Kevin Wolf,
retesting on -rc3 clearly got me further.

Unfortunately the overall test of a libvirt controlled migration with
--copy-storage-all or --copy-storage-inc still does not work.
I have no good pointers yet where to look at, but wanted to give a heads up.

I'm tracking what I have in [1] so far and added upstream qemu as bug task
as well until we know better.

[1]: https://bugs.launchpad.net/qemu/+bug/1711602
