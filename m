Received: from eggs.gnu.org ([209.51.188.92]:38071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1UYF-0004Vu-8y
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:17:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1UYD-00079D-Sd
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:17:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45901)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1UYD-00078r-KS
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:17:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id w17so12930137wrn.12
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 03:17:29 -0800 (PST)
References: <20190305181602.9051-1-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7f974735-1a97-cacc-2354-5f26bc0feda0@redhat.com>
Date: Wed, 6 Mar 2019 12:17:27 +0100
MIME-Version: 1.0
In-Reply-To: <20190305181602.9051-1-dgilbert@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/21] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, marcel.apfelbaum@gmail.com, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, chen.zhang@intel.com

On 3/5/19 7:15 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> The following changes since commit 0984a157c1c053394adbf64ed7de97f1aebe6a2d:
> 
>   Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2019-03-05 09:33:20 +0000)
> 
> are available in the Git repository at:
> 
>   git://github.com/dagrh/qemu.git tags/pull-migration-20190305a
> 
> for you to fetch changes up to 3feabbb5fc5e3d5504c735a77ebd1d7fc1eabb9b:
> 
>   qapi/migration.json: Remove a variable that doesn't exist in example (2019-03-05 18:04:05 +0000)
> 
> ----------------------------------------------------------------
> Migration pull 2019-03-05
> 
>    a) 3 small fixes including the cancel problem
>      that caused the ahci migration test to fail
>      intermittently
>    b) Yury's ignore-shared feature
>    c) Juan's extra tests
>    d) Wei Wang's free page hinting
>    e) Some Colo fixes from Zhang Chen
> 
> ----------------------------------------------------------------
> Dr. David Alan Gilbert (2):
>       migration: Fix cancel state
>       migration/rdma: Fix qemu_rdma_cleanup null check
> 
> Juan Quintela (3):
>       tests: Add migration xbzrle test
>       migration: Create socket-address parameter

Replying to cover for Peter scripts:

In patch 10/21 Daniel said he'll respin.

>       tests: Add basic migration precopy tcp test
> 
> Marcel Apfelbaum (1):
>       migration/rdma: clang compilation fix
> 
> Wei Wang (7):
>       bitmap: fix bitmap_count_one
>       bitmap: bitmap_count_one_with_offset
>       migration: use bitmap_mutex in migration_bitmap_clear_dirty
>       migration: API to clear bits of guest free pages from the dirty bitmap
>       migration/ram.c: add a notifier chain for precopy
>       migration/ram.c: add the free page optimization enable flag
>       virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
> 
> Yury Kotov (5):
>       exec: Change RAMBlockIterFunc definition
>       migration: Introduce ignore-shared capability
>       migration: Add an ability to ignore shared RAM blocks
>       tests/migration-test: Add a test for ignore-shared capability
>       migration: Add capabilities validation
> 
> Zhang Chen (3):
>       Migration/colo.c: Fix double close bug when occur COLO failover
>       Migration/colo.c: Make COLO node running after failover
>       qapi/migration.json: Remove a variable that doesn't exist in example
> 
>  exec.c                             |  38 ++---
>  hmp.c                              |  33 ++++
>  hw/virtio/virtio-balloon.c         | 263 +++++++++++++++++++++++++++++++
>  include/exec/cpu-common.h          |   7 +-
>  include/hw/virtio/virtio-balloon.h |  28 +++-
>  include/migration/misc.h           |  22 +++
>  include/qemu/bitmap.h              |  17 ++
>  migration/colo.c                   |   2 +-
>  migration/migration.c              |  52 ++++++-
>  migration/migration.h              |   9 +-
>  migration/postcopy-ram.c           |  48 +++---
>  migration/ram.c                    | 231 ++++++++++++++++++++++++----
>  migration/rdma.c                   |  18 ++-
>  migration/savevm.c                 | 152 ++++++++++++++++++
>  migration/socket.c                 |  11 ++
>  qapi/migration.json                |  13 +-
>  qapi/sockets.json                  |  18 +++
>  stubs/ram-block.c                  |  15 ++
>  tests/migration-test.c             | 308 +++++++++++++++++++++++++++++++++----
>  util/vfio-helpers.c                |   6 +-
>  vl.c                               |   1 +
>  21 files changed, 1169 insertions(+), 123 deletions(-)
> 
