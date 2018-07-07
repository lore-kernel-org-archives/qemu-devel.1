Received: from eggs.gnu.org ([2001:4830:134:3::10]:33575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fbba5-0004Zd-PY
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 21:00:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1fbba4-0008Vc-Pi
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 21:00:09 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:46632)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1fbba4-0008U5-Gr
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 21:00:08 -0400
Received: by mail-lf0-x243.google.com with SMTP id l16-v6so11098512lfc.13
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 18:00:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA902f9nRM6FysuEKd8AZNsYXM4BVVVN8KfxyHOBYgaLRQ@mail.gmail.com>
References: <1530806837-5416-1-git-send-email-cota@braap.org>
	<CAFEAcA902f9nRM6FysuEKd8AZNsYXM4BVVVN8KfxyHOBYgaLRQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 6 Jul 2018 17:59:36 -0700
Message-ID: <CAKmqyKMmoFaxgWUOvT=EHC4eut2Q3G9sjN839Wqv=upwWaKiWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] translate-all: honour CF_NOCACHE in
 tb_gen_code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Jul 6, 2018 at 6:05 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 5 July 2018 at 17:07, Emilio G. Cota <cota@braap.org> wrote:
>> This fixes a record-replay regression introduced by 95590e2
>> ("translate-all: discard TB when tb_link_page returns an existing
>> matching TB", 2018-06-15). The problem is that code using CF_NOCACHE
>> assumes that the TB returned from tb_gen_code is always a
>> newly-generated one. This assumption, however, was broken in
>> the aforementioned commit.
>>
>> Fix it by honouring CF_NOCACHE, so that tb_gen_code always
>> returns a newly-generated TB when CF_NOCACHE is passed to it.
>> Do this by avoiding the TB hash table if CF_NOCACHE is set.
>>
>> Reported-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>> Tested-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>> Signed-off-by: Emilio G. Cota <cota@braap.org>
>
> This bug can also cause crashes when using -icount, without
> record-replay; I hit it looking at a test case in LP:1774677.
> This patch seems to fix the crash.

This fixes the icount crash for me as well.

Tested-by: Alistair Francis <alistair.francis@wdc.com>

Alistair


>
> thanks
> -- PMM
>
