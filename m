Received: from eggs.gnu.org ([209.51.188.92]:50811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkXeL-0004J0-F1
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:09:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkXeK-0007XI-9D
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:09:45 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:34169)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkXeJ-0006yS-Gy
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:09:44 -0500
Received: by mail-oi1-x244.google.com with SMTP id r62so9541431oie.1
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 09:09:29 -0800 (PST)
MIME-Version: 1.0
References: <20181024201303.114-1-likan_999.student@sina.com>
	<0ad53de4-6910-240a-4732-82bf2dc94aec@vivier.eu>
In-Reply-To: <0ad53de4-6910-240a-4732-82bf2dc94aec@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 17:09:15 +0000
Message-ID: <CAFEAcA-UT_y=7B_155DFaMLByN4kDtQN0fFXPMp82XTT0WwEqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] Fix linux-user crashes in
 ioctl(SIOCGIFCONF) when ifc_buf is NULL.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Kan Li <likan_999.student@sina.com>, QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On Wed, 24 Oct 2018 at 22:05, Laurent Vivier <laurent@vivier.eu> wrote:
>
> On 24/10/2018 21:13, Kan Li wrote:
> > Summary:
> > This is to fix bug https://bugs.launchpad.net/qemu/+bug/1796754.
> > It is valid for ifc_buf to be NULL according to
> > http://man7.org/linux/man-pages/man7/netdevice.7.html.
> >
> > Signed-off-by: Kan Li <likan_999.student@sina.com>
> > ---
> >  linux-user/syscall.c | 55 ++++++++++++++++++++++++++++------------------------
> >  1 file changed, 30 insertions(+), 25 deletions(-)
> >
>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>

Hi Laurent -- did this patch get lost? It doesn't seem to have
made it into master.

thanks
-- PMM
