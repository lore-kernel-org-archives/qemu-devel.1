Received: from eggs.gnu.org ([2001:4830:134:3::10]:37104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eeRUA-0005rI-WD
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 15:17:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eeRUA-0007JN-2e
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 15:17:30 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:36005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eeRU9-0007JB-TK
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 15:17:30 -0500
Received: by mail-oi0-x241.google.com with SMTP id w135so3729477oie.3
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 12:17:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516747387-31760-1-git-send-email-mst@redhat.com>
References: <1516747387-31760-1-git-send-email-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Jan 2018 20:17:08 +0000
Message-ID: <CAFEAcA8UCvw7L55-tw8zacD51zHPa2UeVgxWYgXbMnc3udA3Mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] virtio: quick fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 January 2018 at 22:44, Michael S. Tsirkin <mst@redhat.com> wrote:
> This is just a quick bugfix so people can make progress.
> Will send a pull req with more patches queues later this week.
>
> The following changes since commit 52483b067cce4a88ffbf8fbeea26de7549d2ad23:
>
>   Merge remote-tracking branch 'remotes/huth/tags/pull-request-2018-01-22' into staging (2018-01-23 10:15:09 +0000)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 3e59a4745a1668eeec94d142b0f5a7847b866a87:
>
>   kvm-all: Partially reverts 4fe6d78b2e to remove the cleanup call (2018-01-24 00:41:50 +0200)
>
> ----------------------------------------------------------------
> virtio: quick fix
>
> Fixes a regression in virtio that's causing issues
> for many people.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Jose Ricardo Ziviani (1):
>       kvm-all: Partially reverts 4fe6d78b2e to remove the cleanup call
>
>  accel/kvm/kvm-all.c | 4 ----
>  1 file changed, 4 deletions(-)

Hi -- this pullreq is superseded by your later one, right?

thanks
-- PMM
