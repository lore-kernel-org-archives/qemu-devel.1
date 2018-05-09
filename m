Received: from eggs.gnu.org ([2001:4830:134:3::10]:37352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fGDK9-0005JH-IU
	for qemu-devel@nongnu.org; Tue, 08 May 2018 20:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1fGDK8-0002wO-F8
	for qemu-devel@nongnu.org; Tue, 08 May 2018 20:51:17 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:38611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1fGDK8-0002uW-9J
	for qemu-devel@nongnu.org; Tue, 08 May 2018 20:51:16 -0400
Received: by mail-oi0-x243.google.com with SMTP id k17-v6so30044146oih.5
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 17:51:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5a725be3-4ca1-a883-7313-cee1dc5825c2@linaro.org>
References: <1523377186-32578-1-git-send-email-cota@braap.org>
	<e863cce3-d06e-f225-eb25-212729c5f05f@linaro.org>
	<20180411152942.GA4480@flamenco>
	<5a725be3-4ca1-a883-7313-cee1dc5825c2@linaro.org>
From: Michael Clark <mjc@sifive.com>
Date: Wed, 9 May 2018 12:51:14 +1200
Message-ID: <CAHNT7NtS6AazERJuoK9qtAW2Z6j=YWhQkFdsmEbx-O5L9UtG2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 00/10] Avoid integer overflow in
 next_page_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

On Thu, Apr 12, 2018 at 11:56 AM, Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 04/12/2018 01:29 AM, Emilio G. Cota wrote:
> > To ease an eventual merge I'll be updating the patches' R-b tags as
> > they come in this branch:
> >   https://github.com/cota/qemu/tree/next_page_overflow-r-b
> >
> > BTW to avoid conflicts we should merge this before the translator loop
> > conversion series; I'll make that clear when I send a new version
> > of that patch set.
>
> Right-o.  Thanks.  We'll get these in right away once development starts
> again
> so that you don't have to carry it long.


Emilio,

Is this your latest branch for these changes?

- https://github.com/cota/qemu/tree/trloop-conv-v3

I see that this branch has this change "target/riscv: avoid integer
overflow in next_page PC check"

I have some changes for target/riscv/translate.c and was thinking of basing
them on your patches so we don't have conflicts.

Thanks,
Michael
