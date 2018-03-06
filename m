Received: from eggs.gnu.org ([2001:4830:134:3::10]:47261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1et3TO-0005pA-62
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 22:41:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1et3TN-00040X-3Y
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 22:41:06 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:33759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1et3TM-000407-TH
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 22:41:05 -0500
Received: by mail-oi0-x243.google.com with SMTP id e9so7176212oii.0
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 19:41:04 -0800 (PST)
MIME-Version: 1.0
References: <1519944838-12430-1-git-send-email-cota@braap.org>
	<CAHNT7NusFbz=Dt0TGEWKFyJjDDpF3zjGmfkKw4w9thBOFzHb6g@mail.gmail.com>
	<20180306025659.GA4195@flamenco>
In-Reply-To: <20180306025659.GA4195@flamenco>
From: Michael Clark <mjc@sifive.com>
Date: Tue, 06 Mar 2018 03:40:53 +0000
Message-ID: <CAHNT7NuU-_Evs1XDu5tEOBregHx0HNO_ANvWDABsU6Ld02uMmQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCHv1 00/14] Translation loop conversion for
 sh4/sparc/mips/s390x/openrisc targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Alexander Graf <agraf@suse.de>, Artyom Tarasenko <atar4qemu@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Stafford Horne <shorne@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, qemu-s390x@nongnu.org

On Tue, 6 Mar 2018 at 3:57 PM, Emilio G. Cota <cota@braap.org> wrote:

> On Tue, Mar 06, 2018 at 12:57:13 +1300, Michael Clark wrote:
> > On Fri, Mar 2, 2018 at 11:53 AM, Emilio G. Cota <cota@braap.org> wrote:
> >
> > > [ What is this all about? See this message:
> > >   http://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04785.html ]
> (snip)
> > > You can fetch this series from:
> > >   https://github.com/cota/qemu/tree/trloop-conv-v1
> >
> >
> > Curious to know what we would need to change in RISC-V translate.c:
> >
> > -
> >
> https://github.com/riscv/riscv-qemu/blob/qemu-upstream-v8/target/riscv/translate.c
> >
> > I'm going to make a v8.1 branch and tag that is a rebase of the v8 patch
> > series against current QEMU master, and hopefully we get the RISC-V port
> > merged before the soft-freeze. Fingers crossed.
>
> I have patches that convert riscv as well.
>
> Once riscv is on master I'll send the patches to the list; I don't want
> this work to delay the riscv merge even more!


Appreciated. Thanks very much!

Michael

>
>
