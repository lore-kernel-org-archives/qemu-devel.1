Received: from eggs.gnu.org ([2001:4830:134:3::10]:45065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coYRG-0001fG-5S
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coYRF-00072P-5y
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:39:46 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:34268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1coYRE-00072K-Ut
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 12:39:45 -0400
Received: by mail-wr0-x234.google.com with SMTP id l37so36036846wrc.1
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 09:39:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170316090141.13421-1-quintela@redhat.com>
References: <20170316090141.13421-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Mar 2017 16:39:23 +0000
Message-ID: <CAFEAcA_ZrZBijRnaQEkydvVC9N5F4o25gorRYBNkpJ+fY62qdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/6] Migration fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 16 March 2017 at 09:01, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> This are this week fixes for Migration:
> - fix calculation of dirty-pages-rate (it was being too optimistic)
> - Make sure we can remove tls params for migration (Dan)
> - Disable postcopy with shared memory (Dave)
> - migration-block: Don't call blk_drain too much (Lidong)
> - Fix failed iotests cases (QingFeng)
>
> Please apply, Juan.
>
> The following changes since commit 1883ff34b540daacae948f493b0ba525edf5f642:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into staging (2017-03-15 18:44:05 +0000)
>
> are available in the git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20170316
>
> for you to fetch changes up to 8679638b0e231f97ad3456c681bf569ca7f7f6d5:
>
>   postcopy: Check for shared memory (2017-03-16 09:02:26 +0100)
>
> ----------------------------------------------------------------
> migration/next for 20170316
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
