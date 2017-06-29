Received: from eggs.gnu.org ([2001:4830:134:3::10]:34469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQa5U-0005N1-Le
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dQa5Q-0006Y4-CD
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:06:25 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dQa5Q-0006X2-4T
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:06:24 -0400
Received: by mail-wr0-x22d.google.com with SMTP id k67so189541288wrc.2
	for <qemu-devel@nongnu.org>; Thu, 29 Jun 2017 07:06:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170628113106.5248-1-quintela@redhat.com>
References: <20170628113106.5248-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Jun 2017 15:06:00 +0100
Message-ID: <CAFEAcA-_AHtS9bO-dcNzsLTx3RW+9f_swFuSRcnyEySgR4_2Zg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/14] Migration pull request for 20170628
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On 28 June 2017 at 12:30, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> This is the migration pull request, it includes:
> - return path capability (peter)
> - objectify migration (peter)
>   Thanks to all the people who helped debug the QOM/QAPI.
> - fix access to ramblocks (Haozhong)
> - add error hint to VMSTATE*EQUAL macros (halil)
>   Fixed by hand the cases that didn't compile (me)
>
> Please, apply.
>
> The following changes since commit 577caa2672ccde7352fda3ef17e44993de862f0e:
>
>   Merge remote-tracking branch 'remotes/edgar/tags/edgar/mmio-exec-v2.for-upstream' into staging (2017-06-27 16:56:55 +0100)
>
> are available in the git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20170628
>
> for you to fetch changes up to 084140bd4989095d39978269fd0f43e398a0015d:
>
>   exec: fix access to ram_list.dirty_memory when sync dirty bitmap (2017-06-28 12:23:58 +0200)
>
> ----------------------------------------------------------------
> migration/next for 20170628
>
> ----------------------------------------------------------------
> Halil Pasic (1):
>       vmstate: error hint for failed equal checks
>
> Haozhong Zhang (1):
>       exec: fix access to ram_list.dirty_memory when sync dirty bitmap
>
> Peter Xu (12):
>       machine: export register_compat_prop()
>       accel: introduce AccelClass.global_props
>       vl: clean up global property registration
>       migration: let MigrationState be a qdev
>       migration: move global_state.optional out
>       migration: move only_migratable to MigrationState
>       migration: move skip_configuration out
>       migration: move skip_section_footers
>       migration: merge enforce_config_section somewhat
>       migration: hmp: dump globals
>       migration: add comment for TYPE_MIGRATE
>       migration: add "return-path" capability

Applied, thanks.

-- PMM
