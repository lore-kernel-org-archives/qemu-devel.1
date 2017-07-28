Received: from eggs.gnu.org ([2001:4830:134:3::10]:55051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1db2l9-00080R-Kh
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1db2l8-0007yZ-SW
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:44:43 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:38280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1db2l8-0007xT-LG
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 06:44:42 -0400
Received: by mail-wr0-x234.google.com with SMTP id f21so97138512wrf.5
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 03:44:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170728092000.19216-1-cohuck@redhat.com>
References: <20170728092000.19216-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jul 2017 11:44:20 +0100
Message-ID: <CAFEAcA_f-atHctLiBnQuq6MkUU-_09jTMxACr7gH+FTA4mf8dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL for-2.10 0/4] s390x: more fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>

On 28 July 2017 at 10:19, Cornelia Huck <cohuck@redhat.com> wrote:
> The following changes since commit e01151de165070c25a1b202e9e2392950bd7c8da:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20170727-pull-request' into staging (2017-07-27 15:27:06 +0100)
>
> are available in the git repository at:
>
>   git://github.com/cohuck/qemu tags/s390x-20170728
>
> for you to fetch changes up to 4add0da64942d83e0564147c0876b01074bde9cb:
>
>   s390x/css: fix bits must be zero check for TIC (2017-07-28 10:06:25 +0200)
>
> ----------------------------------------------------------------
> More s390x fixes: Correct ilen, and ccw checking.
>
> ----------------------------------------------------------------
>
> David Hildenbrand (2):
>   target/s390x: fix pgm irq ilen for stsi
>   target/s390x: fix pgm irq ilen in translate_pages()
>
> Halil Pasic (2):
>   s390x/css: check ccw address validity
>   s390x/css: fix bits must be zero check for TIC
>
>  hw/s390x/css.c             | 7 ++++++-
>  target/s390x/misc_helper.c | 2 +-
>  target/s390x/mmu_helper.c  | 2 +-
>  3 files changed, 8 insertions(+), 3 deletions(-)

Applied, thanks.

-- PMM
