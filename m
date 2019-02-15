Received: from eggs.gnu.org ([209.51.188.92]:53725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gugH5-0007yV-3a
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:23:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gugH2-0004Is-K8
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:23:38 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:39676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gugGy-0003wW-JH
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:23:34 -0500
Received: by mail-ot1-x32e.google.com with SMTP id n8so17427236otl.6
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 08:23:18 -0800 (PST)
MIME-Version: 1.0
References: <20190213234907.24173-1-jsnow@redhat.com>
In-Reply-To: <20190213234907.24173-1-jsnow@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Feb 2019 16:23:06 +0000
Message-ID: <CAFEAcA-X-JRhycbWZqJr4D7z2osO_gpW8RBb_M3328sSzeZ6aw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] Bitmaps patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 13 Feb 2019 at 23:49, John Snow <jsnow@redhat.com> wrote:
>
> The following changes since commit 0b5e750bea635b167eb03d86c3d9a09bbd43bc=
06:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2019-02-12 10:53:37 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/jnsnow/qemu.git tags/bitmaps-pull-request
>
> for you to fetch changes up to fbe8c2e3b041c682d3d52030b53e1627f285a84b:
>
>   blockdev: acquire aio_context for bitmap add/remove (2019-02-13 18:42:4=
6 -0500)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------

As Eric says, this doesn't compile:

/home/petmay01/linaro/qemu-for-merges/blockdev.c: In function
=E2=80=98qmp_block_dirty_bitmap_add=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/blockdev.c:2869:5: error:
expected =E2=80=98;=E2=80=99 before =E2=80=98}=E2=80=99 token
     }
     ^

but I've confirmed that I have your updated gpg key info and
could verify the tag signature.

thanks
-- PMM
