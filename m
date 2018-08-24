Received: from eggs.gnu.org ([2001:4830:134:3::10]:33595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftGKl-0007di-QC
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftGKk-0006re-J6
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:57:19 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:40076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftGKj-0006o6-TN
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 13:57:18 -0400
Received: by mail-oi0-x242.google.com with SMTP id l202-v6so9845437oig.7
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 10:57:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180820023110.6583-1-jcmvbkbc@gmail.com>
References: <20180820023110.6583-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 18:56:54 +0100
Message-ID: <CAFEAcA8JPnTaa_uXEMbTbBXwM+ATxBSMs5ed3PJm_R9srag_cQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/xtensa: convert to
 do_transaction_failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 August 2018 at 03:31, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  target/xtensa/cpu.c       |  2 +-
>  target/xtensa/cpu.h       |  7 ++++---
>  target/xtensa/op_helper.c | 12 +++++++-----
>  3 files changed, 12 insertions(+), 9 deletions(-)

Hi -- thanks for doing this conversion. This change means that
you'll no longer get guest exceptions for bus errors that happen
during get_pte()'s page table entry fetch. Don't you need at
least a TODO comment there indicating that there's missing
behaviour?

(Obviously the ideal would be to switch to address_space_ldl_*
and handle the case when they don't return MEMTX_OK.)

thanks
-- PMM
