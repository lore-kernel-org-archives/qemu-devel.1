Received: from eggs.gnu.org ([2001:4830:134:3::10]:42066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejlnR-0004sd-9q
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 07:59:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejlnQ-0005lt-44
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 07:59:25 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:34130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejlnP-0005lh-UF
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 07:59:24 -0500
Received: by mail-ot0-x241.google.com with SMTP id l10so4231545oth.1
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 04:59:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180205102659.60552-1-marcel@redhat.com>
References: <20180205102659.60552-1-marcel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2018 12:59:02 +0000
Message-ID: <CAFEAcA8OO7jEeAe5UWKBqSb_+tap7OVM2YxEsqWDVZV8jN7cmA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] RDMA patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, yuval.shaia@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>, dotanb@mellanox.com

On 5 February 2018 at 10:26, Marcel Apfelbaum <marcel@redhat.com> wrote:
> The following changes since commit f24ee107a07f093bd7ed475dd48d7ba57ea3d8fe:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180202-pull-request' into staging (2018-02-02 18:54:11 +0000)
>
> are available in the git repository at:
>
>   https://github.com/marcel-apf/qemu tags/rdma-pull-request
>
> for you to fetch changes up to f172ba1b02724fb66dabd69cd553cfa625b413e5:
>
>   MAINTAINERS: add entry for hw/rdma (2018-02-05 11:53:00 +0200)
>
> ----------------------------------------------------------------
> PVRDMA implementation
>
> ----------------------------------------------------------------
> Marcel Apfelbaum (3):
>       mem: add share parameter to memory-backend-ram
>       docs: add pvrdma device documentation.
>       MAINTAINERS: add entry for hw/rdma
>
> Yuval Shaia (1):
>       pvrdma: initial implementation

Hi. The technical details of this pullreq are all fine (pgp
key, format, etc), and it passes my build tests. But I gave
this pullreq a bit of a closer inspection than I normally
would, since it's your first, and there are a few things I
thought worth bringing up:

(1) I notice that some of the new files in this pullreq are licensed
as "GPL, version 2", rather than "version 2 or any later version".
Did you really mean that? Per 'LICENSE', we have a strong preference
for 2-or-later for new code.

(2) Some new files have no copyright or license comment at the
top of them. Can you fix that, please?

(3) Some of the new headers use kernel-internals __u32 etc types.
This isn't portable. ('HACKING' has some suggestions for types you
might want instead.)

(4) One of your patches doesn't have any reviewed-by tags.
We don't always manage to review everything, but it is
nicer if we can get review, especially for patches from
new submaintainers.

(5) This is an absolutely enormous diffstat for a single commit:
 26 files changed, 5149 insertions(+), 4 deletions(-)

thanks
-- PMM
