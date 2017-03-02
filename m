Received: from eggs.gnu.org ([2001:4830:134:3::10]:53312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjWO3-0007Mv-RJ
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:27:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjWO2-0007iw-Uc
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:27:39 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:38679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjWO2-0007il-ND
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:27:38 -0500
Received: by mail-wm0-x22e.google.com with SMTP id t193so20698343wmt.1
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 11:27:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170228124056.5074-1-dgilbert@redhat.com>
References: <20170228124056.5074-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Mar 2017 19:27:16 +0000
Message-ID: <CAFEAcA-28jrOb2cnhBT_Lk9=MR1sjDE1Bdo0dC9hCsdeRukK5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/27] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, pasic@linux.vnet.ibm.com, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, Ashijeet Acharya <ashijeetacharya@gmail.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, danielhb@linux.vnet.ibm.com

On 28 February 2017 at 12:40, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 6181478f6395cdd9d6ffd99623d0c9f39ea536=
06:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2017-02-28 08:46:03 +0000)
>
> are available in the git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20170228a
>
> for you to fetch changes up to 665414ad06aa1bc92e615db9641e58fb13d07de1:
>
>   postcopy: Add extra check for COPY function (2017-02-28 11:30:24 +0000)
>
> ----------------------------------------------------------------
> Migration pull
>
> Note: The 'postcopy: Update userfaultfd.h header' is part of
> Paolo's header update and will disappear if applied after it.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> ----------------------------------------------------------------
> Ashijeet Acharya (1):
>       migrate: Introduce a 'dc->vmsd' check to avoid segfault for --only-=
migratable
>
> Daniel Henrique Barboza (1):
>       Changing error message of QMP 'migrate_set_downtime' to seconds
>
> Dr. David Alan Gilbert (17):
>       migration: Update docs to discourage version bumps
>       postcopy: Transmit ram size summary word
>       postcopy: Transmit and compare individual page sizes
>       postcopy: Chunk discards for hugepages
>       exec: ram_block_discard_range
>       postcopy: enhance ram_block_discard_range for hugepages
>       postcopy: Record largest page size
>       postcopy: Plumb pagesize down into place helpers
>       postcopy: Use temporary for placing zero huge pages
>       postcopy: Load huge pages in one go
>       postcopy: Mask fault addresses to huge page boundary
>       postcopy: Send whole huge pages
>       postcopy: Allow hugepages
>       postcopy: Update userfaultfd.h header
>       postcopy: Check for userfault+hugepage feature
>       postcopy: Add doc about hugepages and postcopy
>       postcopy: Add extra check for COPY function
>
> Halil Pasic (5):
>       migration/vmstate: renames in (load|save)_state
>       migration/vmstate: split up vmstate_base_addr
>       migration/vmstate: fix array of ptr with nullptrs
>       tests/test-vmstate.c: test array of ptr with null
>       tests/test-vmstate.c: test array of ptr to primitive
>
> Laurent Vivier (1):
>       vmstate-static-checker: update white list with spapr_pci
>
> Marc-Andr=C3=A9 Lureau (1):
>       migration: fix id leak regression
>
> Vladimir Sementsov-Ogievskiy (1):
>       migration: fix use-after-free of to_dst_file

Applied, thanks.

-- PMM
