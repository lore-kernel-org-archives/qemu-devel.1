Received: from eggs.gnu.org ([209.51.188.92]:41142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1ZL2-0002XB-Mw
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:24:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1ZL1-0004nf-UG
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:24:12 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:41454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1ZL1-0004mk-NO
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:24:11 -0500
Received: by mail-ot1-x32a.google.com with SMTP id t7so11237985otk.8
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 08:24:11 -0800 (PST)
MIME-Version: 1.0
References: <20190306114227.9125-1-dgilbert@redhat.com>
In-Reply-To: <20190306114227.9125-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Mar 2019 16:23:58 +0000
Message-ID: <CAFEAcA_88_uhEaeJ+52BfTVUDMw6UV+vdcozE176uujTDmb03A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/22] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, Zhang Chen <chen.zhang@intel.com>, Markus Armbruster <armbru@redhat.com>

On Wed, 6 Mar 2019 at 11:44, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit b5b6b2b912bbcd3953407da938a8f969577ad3a1:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-mar-05-2019' into staging (2019-03-05 21:07:29 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20190306a
>
> for you to fetch changes up to b5922fc5891261153f1a0f20e814c620aabeb6ac:
>
>   qapi/migration.json: Remove a variable that doesn't exist in example (2019-03-06 10:49:18 +0000)
>
> ----------------------------------------------------------------
> Migation pull 2019-03-06
>
> (This replaces the pull sent yesterday)
>
>    a) 4 small fixes including the cancel problem
>      that caused the ahci migration test to fail
>      intermittently
>    b) Yury's ignore-shared feature
>    c) Juan's extra tests
>    d) Wei Wang's free page hinting
>    e) Some Colo fixes from Zhang Chen
>
> Diff from yesterdays pull:
>   1) A missing fix of mine (cleanup during exit)
>   2) Changes from Eric/Markus on 'Create socket-address parameter'
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
