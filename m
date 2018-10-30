Received: from eggs.gnu.org ([2001:4830:134:3::10]:50881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHWiy-0007oH-95
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:18:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gHWix-0004Ru-NK
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:18:36 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gHWix-0004Nv-99
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 12:18:35 -0400
Received: by mail-ot1-x342.google.com with SMTP id g10so583586otl.12
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 09:18:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181030035030.4542-1-zhangckid@gmail.com>
References: <20181030035030.4542-1-zhangckid@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Oct 2018 16:18:13 +0000
Message-ID: <CAFEAcA_T8WCimGtgErMjQvBL9yh8_kR9XpykaY=MJPCM7ghw+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] net/filter-rewirter.c: Fix coverity static
 analysis issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Zhang Chen <chen.zhang@intel.com>

On 30 October 2018 at 03:50, Zhang Chen <zhangckid@gmail.com> wrote:
> The original code just follow the TCP state diagram,
> but in this case, we can skip the TCPS_TIME_WAIT state to simplify
> the implementation.
>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> ---
>  net/filter-rewriter.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

NB: typo in Subject: s/rewirter/rewriter/

Hopefully whoever commits this patch can fix that up for you.

thanks
-- PMM
