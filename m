Received: from eggs.gnu.org ([2001:4830:134:3::10]:57836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edb7S-0001wk-Pw
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:22:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edb7R-00017R-W0
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:22:34 -0500
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:45934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edb7R-00017G-Qq
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:22:33 -0500
Received: by mail-oi0-x22a.google.com with SMTP id j129so5754915oib.12
	for <qemu-devel@nongnu.org>; Mon, 22 Jan 2018 04:22:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180115115309.23982-1-quintela@redhat.com>
References: <20180115115309.23982-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2018 12:22:12 +0000
Message-ID: <CAFEAcA8AMejrf1P26QX1xne2+JvYziBvT1Q-HjcC2Pa=40gB6A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/27] Migration pull
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

On 15 January 2018 at 11:52, Juan Quintela <quintela@redhat.com> wrote:
> Hi
> - rebase on top of lastest
> - fix compilation on 32bit machines
> - add Peter Xu cleanups
>
> Please, apply.
>
> The following changes since commit fd06527b80c88c8dde1b35fdc692685b68d2fd93:
>
>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault' into staging (2018-01-15 10:39:29 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20180115
>
> for you to fetch changes up to 816306826a45f4d15352e32d157172af3a35899f:
>
>   migration: remove notify in fd_error (2018-01-15 12:48:13 +0100)
>
> ----------------------------------------------------------------
> migration/next for 20180115
>
> ----------------------------------------------------------------
> Alexey Perevalov (6):
>       migration: introduce postcopy-blocktime capability
>       migration: add postcopy blocktime ctx into MigrationIncomingState
>       migration: calculate vCPU blocktime on dst side
>       migration: postcopy_blocktime documentation
>       migration: add blocktime calculation into migration-test
>       migration: add postcopy total blocktime into query-migrate

I suggest that we should for the moment revert
3be98be4e9f5  migration: calculate vCPU blocktime on dst side
5f32dc8ee073  migration: add blocktime calculation into migration-test
ca6011c23291  migration: add postcopy total blocktime into query-migrate

unless there is an imminent fix for the ppc32 issues (which seems
unlikely since the code is fundamentally assuming it can atomically
do operations which can't be done atomically on all hosts).

I haven't yet tested that combination of reverts, I'm guessing
at which subsequent commits depend on 3be98be4e9f5. Let me know
if you have suggestions for additions/removals from the revert list.

thanks
-- PMM
