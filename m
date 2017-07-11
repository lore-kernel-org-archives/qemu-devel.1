Received: from eggs.gnu.org ([2001:4830:134:3::10]:37848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUr3X-0000NK-Jz
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:02:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dUr3U-0003zx-Ie
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:02:07 -0400
Received: from mail-wr0-f176.google.com ([209.85.128.176]:33071)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dUr3U-0003zK-9o
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 05:02:04 -0400
Received: by mail-wr0-f176.google.com with SMTP id r103so174033286wrb.0
	for <qemu-devel@nongnu.org>; Tue, 11 Jul 2017 02:02:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170710171040.21021-1-dgilbert@redhat.com>
References: <20170710171040.21021-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2017 10:00:42 +0100
Message-ID: <CAFEAcA8WyrCPgM71YADnJ8tOjqhij=-OAse1CuvYD7r+rYM53Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>

On 10 July 2017 at 18:10, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 6b06e3e49eb8c91cc286c16d6bf3181ac296f33d:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2017-07-10-v2' into staging (2017-07-10 16:12:47 +0100)
>
> are available in the git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20170710a
>
> for you to fetch changes up to f0afa331ce670ba39bde3f5620d75dcd56890cb6:
>
>   migration: Make compression_threads use save/load_setup/cleanup() (2017-07-10 17:52:21 +0100)
>
> ----------------------------------------------------------------
> Migration pull 2017-07-10
>
> ----------------------------------------------------------------
> Juan Quintela (5):
>       migration: Rename save_live_setup() to save_setup()
>       migration: Rename cleanup() to save_cleanup()
>       migration: Create load_setup()/cleanup() methods
>       migration: Convert ram to use new load_setup()/load_cleanup()
>       migration: Make compression_threads use save/load_setup/cleanup()
>
> Peter Xu (4):
>       migration: fix handling for --only-migratable
>       vl: move global property, migrate init earlier
>       doc: add item for "-M enforce-config-section"
>       doc: update TYPE_MIGRATION documents

Applied, thanks.

-- PMM
