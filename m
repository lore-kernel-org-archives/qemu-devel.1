Received: from eggs.gnu.org ([2001:4830:134:3::10]:43470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1famYM-0005aj-5O
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1famYL-0002ic-2u
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:30:58 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:42466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1famYK-0002hy-S9
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:30:57 -0400
Received: by mail-oi0-x243.google.com with SMTP id n84-v6so12264347oib.9
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 11:30:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703145915.32607-1-kwolf@redhat.com>
References: <20180703145915.32607-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Jul 2018 19:30:35 +0100
Message-ID: <CAFEAcA-xXYTcGJFtC90AvtFReRbFeAWuQNk2uobFCsioLHCikg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 3 July 2018 at 15:59, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit a395717cbd26e7593d3c3fe81faca121ec6d13e8:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2018-07-03 11:49:51 +0100)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 59738025a1674bb7e07713c3c93ff4fb9c5079f5:
>
>   block: Add blklogwrites (2018-07-03 16:09:48 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - qcow2: Use worker threads for compression to improve performance of
>   'qemu-img convert -W' and compressed backup jobs
> - blklogwrites: New filter driver to log write requests to an image in
>   the dm-log-writes format
>
> ----------------------------------------------------------------

Hi; this gives some a warning on OpenBSD and NetBSD:

/home/qemu/block/qcow2.c: In function 'qcow2_compress':
/home/qemu/block/qcow2.c:3684:18: warning: assignment discards 'const'
qualifier from pointer target type
     strm.next_in = src;
                  ^

thanks
-- PMM
