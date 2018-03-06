Received: from eggs.gnu.org ([2001:4830:134:3::10]:41098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1et2mm-0008It-EF
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 21:57:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1et2mj-0004ln-BT
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 21:57:04 -0500
Date: Mon, 5 Mar 2018 21:56:59 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180306025659.GA4195@flamenco>
References: <1519944838-12430-1-git-send-email-cota@braap.org>
	<CAHNT7NusFbz=Dt0TGEWKFyJjDDpF3zjGmfkKw4w9thBOFzHb6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHNT7NusFbz=Dt0TGEWKFyJjDDpF3zjGmfkKw4w9thBOFzHb6g@mail.gmail.com>
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
To: Michael Clark <mjc@sifive.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, qemu-s390x@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, Stafford Horne <shorne@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, Aurelien Jarno <aurelien@aurel32.net>

On Tue, Mar 06, 2018 at 12:57:13 +1300, Michael Clark wrote:
> On Fri, Mar 2, 2018 at 11:53 AM, Emilio G. Cota <cota@braap.org> wrote:
> 
> > [ What is this all about? See this message:
> >   http://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04785.html ]
(snip)
> > You can fetch this series from:
> >   https://github.com/cota/qemu/tree/trloop-conv-v1
> 
> 
> Curious to know what we would need to change in RISC-V translate.c:
> 
> -
> https://github.com/riscv/riscv-qemu/blob/qemu-upstream-v8/target/riscv/translate.c
> 
> I'm going to make a v8.1 branch and tag that is a rebase of the v8 patch
> series against current QEMU master, and hopefully we get the RISC-V port
> merged before the soft-freeze. Fingers crossed.

I have patches that convert riscv as well.

Once riscv is on master I'll send the patches to the list; I don't want
this work to delay the riscv merge even more!

		Emilio
