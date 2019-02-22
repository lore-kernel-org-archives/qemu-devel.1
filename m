Received: from eggs.gnu.org ([209.51.188.92]:60772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxD3R-0001j1-8K
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:48:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gxD3Q-0007oJ-EA
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:48:01 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:33753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gxD3Q-0007Zv-7L
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 10:48:00 -0500
Received: by mail-ot1-x32a.google.com with SMTP id q24so2253745otk.0
	for <qemu-devel@nongnu.org>; Fri, 22 Feb 2019 07:47:48 -0800 (PST)
MIME-Version: 1.0
References: <20190221173326.31874-1-mst@redhat.com>
In-Reply-To: <20190221173326.31874-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Feb 2019 15:47:36 +0000
Message-ID: <CAFEAcA_Nmo1bpWr5rUmXotB_J9J78wvqB9TU174WWyqt+CEZZw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/26] pci, pc, virtio: fixes, cleanups,
 tests
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

On Fri, 22 Feb 2019 at 02:40, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit fc3dbb90f2eb069801bfb4cfe9cbc83cf9c5f4a9:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-02-21 13:09:33 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 1f8c04f18d2ee2f6ec88217dfd547ab38d2be5c5:
>
>   pci: Sanity test minimum downstream LNKSTA (2019-02-21 12:28:41 -0500)
>
> ----------------------------------------------------------------
> pci, pc, virtio: fixes, cleanups, tests
>
> Lots of work on tests: BiosTablesTest UEFI app,
> vhost-user testing for non-Linux hosts.
> Misc cleanups and fixes all over the place
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------

Compile failure on clang:

/home/petmay01/linaro/qemu-for-merges/hw/virtio/virtio-balloon.c:40:3:
error: redefinition of typedef 'PartiallyBalloonedPage' is a C11
feature [-Werror,-Wtypedef-redefinition]
} PartiallyBalloonedPage;
  ^
/home/petmay01/linaro/qemu-for-merges/include/hw/virtio/virtio-balloon.h:33:39:
note: previous definition is here
typedef struct PartiallyBalloonedPage PartiallyBalloonedPage;
                                      ^
1 error generated.
/home/petmay01/linaro/qemu-for-merges/rules.mak:69: recipe for target
'hw/virtio/virtio-balloon.o' failed

thanks
-- PMM
