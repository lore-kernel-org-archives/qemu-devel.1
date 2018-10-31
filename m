Received: from eggs.gnu.org ([2001:4830:134:3::10]:47480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gHefh-0002CX-43
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gHefg-0007hj-8y
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:47:44 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1gHefg-0007cV-0U
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 20:47:44 -0400
Received: by mail-wr1-x442.google.com with SMTP id r10-v6so14595227wrv.6
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 17:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <20181030035030.4542-1-zhangckid@gmail.com>
	<CAFEAcA_T8WCimGtgErMjQvBL9yh8_kR9XpykaY=MJPCM7ghw+g@mail.gmail.com>
In-Reply-To: <CAFEAcA_T8WCimGtgErMjQvBL9yh8_kR9XpykaY=MJPCM7ghw+g@mail.gmail.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 31 Oct 2018 08:47:19 +0800
Message-ID: <CAK3tnvLfkkdNvzXJeF1LKGAujDsxyuzxJSWRd33T8Q0Pj+zPxA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, Zhang Chen <chen.zhang@intel.com>

Oh, Sorry.
I will send the V2 patch.

Thank
Zhang Chen

On Wed, Oct 31, 2018 at 12:18 AM Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 30 October 2018 at 03:50, Zhang Chen <zhangckid@gmail.com> wrote:
> > The original code just follow the TCP state diagram,
> > but in this case, we can skip the TCPS_TIME_WAIT state to simplify
> > the implementation.
> >
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  net/filter-rewriter.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
>
> NB: typo in Subject: s/rewirter/rewriter/
>
> Hopefully whoever commits this patch can fix that up for you.
>
> thanks
> -- PMM
>
