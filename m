Received: from eggs.gnu.org ([2001:4830:134:3::10]:51201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felix.yzg@gmail.com>) id 1eLgBA-0005k8-K3
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 21:08:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felix.yzg@gmail.com>) id 1eLgB9-0001ju-Jt
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 21:08:20 -0500
Received: from mail-qk0-x22e.google.com ([2607:f8b0:400d:c09::22e]:33604)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <felix.yzg@gmail.com>) id 1eLgB9-0001jX-FW
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 21:08:19 -0500
Received: by mail-qk0-x22e.google.com with SMTP id 63so19714465qke.0
	for <qemu-devel@nongnu.org>; Sun, 03 Dec 2017 18:08:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_VZVcbS9JhorMa9SnTkO+j5uL4LFZ91vBsVqemVFUHRA@mail.gmail.com>
References: <1512200490-50021-1-git-send-email-felix.yzg@gmail.com>
	<CAFEAcA_VZVcbS9JhorMa9SnTkO+j5uL4LFZ91vBsVqemVFUHRA@mail.gmail.com>
From: felix yao <felix.yzg@gmail.com>
Date: Mon, 4 Dec 2017 10:08:18 +0800
Message-ID: <CAOH8tkR=k87rPGE=vYYk_nU3c8ug0mf88vfbuQX+Q+Kf+PDd1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/1] main loop: remove useless code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi Peter Maydell:

Got it, thank you very much!

2017-12-02 19:52 GMT+08:00 Peter Maydell <peter.maydell@linaro.org>:

> On 2 December 2017 at 07:41, FelixYao <felix.yzg@gmail.com> wrote:
> > hi Paolo Bonzini:
> >
> > Those codes seem useless, Could it be removed?
> >
> > Signed-off-by: FelixYao <felix.yzg@gmail.com>
> > ---
> >  vl.c | 4 ----
> >  1 file changed, 4 deletions(-)
> >
> > diff --git a/vl.c b/vl.c
> > index 1ad1c04..5bed4c2 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -2995,10 +2995,6 @@ static void set_memory_options(uint64_t
> *ram_slots, ram_addr_t *maxram_size,
> >
> >      sz = QEMU_ALIGN_UP(sz, 8192);
> >      ram_size = sz;
> > -    if (ram_size != sz) {
> > -        error_report("ram size too large");
> > -        exit(EXIT_FAILURE);
> > -    }
>
> ram_size is a ramaddr_t, which may be a 32-bit variable, whereas
> sz is a uint64_t. This check is making sure that the ram size
> specified can actually fit in a ramaddr_t.
>
> thanks
> -- PMM
>
