Received: from eggs.gnu.org ([2001:4830:134:3::10]:42472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ettgl-0002kB-99
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:26:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ettgk-00051P-Ej
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:26:23 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:46746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ettgk-00051A-A4
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:26:22 -0500
Received: by mail-oi0-x243.google.com with SMTP id x12so4072659oie.13
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 03:26:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180307111822.29403-1-kwolf@redhat.com>
References: <20180307111822.29403-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Mar 2018 11:26:01 +0000
Message-ID: <CAFEAcA8Dka7arV45q9i27foXb73HsamDkgEq15AJp0z6x33vHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Multiboot patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, jack.schwartz@oracle.com

On 7 March 2018 at 11:18, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit f32408f3b472a088467474ab152be3b6285b2d7b:
>
>   misc: don't use hwaddr as a type in trace events (2018-03-06 14:24:30 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 4b9006a41ea8818f2385ae5228e07f211bb4a33d:
>
>   multiboot: fprintf(stderr...) -> error_report() (2018-03-07 11:53:37 +0100)
>
> ----------------------------------------------------------------
> Multiboot patches
>
> ----------------------------------------------------------------
> Jack Schwartz (4):
>       multiboot: bss_end_addr can be zero
>       multiboot: Remove unused variables from multiboot.c
>       multiboot: Use header names when displaying fields
>       multiboot: fprintf(stderr...) -> error_report()
>
>  hw/i386/multiboot.c | 77 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 38 insertions(+), 39 deletions(-)

Applied, thanks.

-- PMM
