Received: from eggs.gnu.org ([2001:4830:134:3::10]:36722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNaRP-0005Kv-SR
	for qemu-devel@nongnu.org; Tue, 29 May 2018 04:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fNaRP-00054u-6v
	for qemu-devel@nongnu.org; Tue, 29 May 2018 04:57:15 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:43323)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fNaRP-00054W-22
	for qemu-devel@nongnu.org; Tue, 29 May 2018 04:57:15 -0400
Received: by mail-ot0-x242.google.com with SMTP id y10-v6so16086313otg.10
	for <qemu-devel@nongnu.org>; Tue, 29 May 2018 01:57:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180525133246.7839-1-quintela@redhat.com>
References: <20180525133246.7839-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 May 2018 09:56:53 +0100
Message-ID: <CAFEAcA_jrF3DGi3vq1G64_UiUFrcTz2OnO-Zaa_huD8YyM-kxQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Migration pull
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

On 25 May 2018 at 14:32, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> this pull:
> - fix iotests problems
> - add a fix for coverity.
>
> Apply, please.
>
> The following changes since commit 5a5c383b1373aeb6c87a0d6060f6c3dc7c53082b:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-2.13-pull-request' into staging (2018-05-25 10:04:36 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20180525
>
> for you to fetch changes up to bf269906f5b225a04825b2bce4364bfe1d509999:
>
>   migration: use g_free for ram load bitmap (2018-05-25 15:29:48 +0200)
>
> ----------------------------------------------------------------
> migration/next for 20180525
>
> ----------------------------------------------------------------
> Juan Quintela (1):
>       migration: fix exec/fd migrations
>
> Peter Xu (1):
>       migration: use g_free for ram load bitmap
>
>  migration/exec.c | 4 ++++
>  migration/fd.c   | 4 ++++
>  migration/ram.c  | 4 ++--
>  3 files changed, 10 insertions(+), 2 deletions(-)

Applied, thanks.

-- PMM
