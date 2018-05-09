Received: from eggs.gnu.org ([2001:4830:134:3::10]:57466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fGSDp-0000kc-J0
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fGSDn-0002eQ-1t
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:45:45 -0400
Date: Wed, 9 May 2018 12:45:39 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180509164539.GA9663@flamenco>
References: <1523377186-32578-1-git-send-email-cota@braap.org>
	<e863cce3-d06e-f225-eb25-212729c5f05f@linaro.org>
	<20180411152942.GA4480@flamenco>
	<5a725be3-4ca1-a883-7313-cee1dc5825c2@linaro.org>
	<CAHNT7NtS6AazERJuoK9qtAW2Z6j=YWhQkFdsmEbx-O5L9UtG2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHNT7NtS6AazERJuoK9qtAW2Z6j=YWhQkFdsmEbx-O5L9UtG2A@mail.gmail.com>
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
To: Michael Clark <mjc@sifive.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Max Filippov <jcmvbkbc@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>

On Wed, May 09, 2018 at 12:51:14 +1200, Michael Clark wrote:
> Emilio,
> 
> Is this your latest branch for these changes?
> 
> - https://github.com/cota/qemu/tree/trloop-conv-v3
> 
> I see that this branch has this change "target/riscv: avoid integer
> overflow in next_page PC check"
> 
> I have some changes for target/riscv/translate.c and was thinking of basing
> them on your patches so we don't have conflicts.

Yes that's the latest branch. Richard is currently working
on a pull request to get that branch merged, so you'll soon
be able to rebase your changes on top of master.

Thanks,

		Emilio
