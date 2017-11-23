Received: from eggs.gnu.org ([2001:4830:134:3::10]:60338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHtYH-0002lF-VP
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 10:36:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHtYH-000387-3Z
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 10:36:34 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:41723)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHtYG-00037e-VL
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 10:36:33 -0500
Received: by mail-ot0-x244.google.com with SMTP id b54so16595083otd.8
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 07:36:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171122084504.11984-1-quintela@redhat.com>
References: <20171122084504.11984-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Nov 2017 15:36:11 +0000
Message-ID: <CAFEAcA9T8LN4NSjJdCurqcpEtAdmTiG7t0y+NrHWB1ASMY=xNw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Migration PULL take 2
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

On 22 November 2017 at 08:45, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> This uses the right verslion of postcopy_running from from Daniel.
>
> Please, apply.
>
> Later, Juan.
>
> The following changes since commit a15d835f00dce270fd3194e83d9910f4b5b44ac0:
>
>   Update version for v2.11.0-rc2 release (2017-11-21 17:50:36 +0000)
>
> are available in the git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20171122
>
> for you to fetch changes up to acab30b85db0885ab161aff4c83c550628f6d8ca:
>
>   migration/ram.c: do not set 'postcopy_running' in POSTCOPY_INCOMING_END (2017-11-22 08:50:37 +0100)
>
> ----------------------------------------------------------------
> migration/next for 20171122
>
> ----------------------------------------------------------------
> Anthony PERARD (1):
>       migration, xen: Fix block image lock issue on live migration
>
> Daniel Henrique Barboza (1):
>       migration/ram.c: do not set 'postcopy_running' in POSTCOPY_INCOMING_END
>
>  migration/ram.c     | 16 ++++++++++++++--
>  migration/savevm.c  | 23 ++++++++++++++++++++++-
>  qapi/migration.json |  6 +++++-
>  3 files changed, 41 insertions(+), 4 deletions(-)

Applied, thanks.

-- PMM
