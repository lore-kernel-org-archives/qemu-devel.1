Received: from eggs.gnu.org ([2001:4830:134:3::10]:33085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fLYS5-0004GB-NT
	for qemu-devel@nongnu.org; Wed, 23 May 2018 14:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <naravamudan@digitalocean.com>) id 1fLYS4-0008Is-K4
	for qemu-devel@nongnu.org; Wed, 23 May 2018 14:25:33 -0400
Received: from mail-io0-x22d.google.com ([2607:f8b0:4001:c06::22d]:36055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <naravamudan@digitalocean.com>)
	id 1fLYS4-0008IX-3e
	for qemu-devel@nongnu.org; Wed, 23 May 2018 14:25:32 -0400
Received: by mail-io0-x22d.google.com with SMTP id d73-v6so23943350iog.3
	for <qemu-devel@nongnu.org>; Wed, 23 May 2018 11:25:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <340670a5-c9f3-ccf0-6af2-1bc1dc471866@redhat.com>
References: <CAGtobs_PEYmSyPwbYG-6oNp9PxwQ52xHaFuXh59ELWcrAm6LSA@mail.gmail.com>
	<340670a5-c9f3-ccf0-6af2-1bc1dc471866@redhat.com>
From: Nishanth Aravamudan <naravamudan@digitalocean.com>
Date: Wed, 23 May 2018 11:25:30 -0700
Message-ID: <CAGtobs_+H87Jeugx2Zc1OarQGvj6E0b_Vk0HpqOctzQoXTEE_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] AIO error case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>

On Wed, May 23, 2018 at 10:53 AM, John Snow <jsnow@redhat.com> wrote:
>
>
>
> On 05/22/2018 06:01 PM, Nishanth Aravamudan via Qemu-devel wrote:
> > Hi!
> >
>
> Hi! CCing qemu-block@nongnu.org;
>
> > I'm tracking an error case in the native AIO path, and was wondering if
> > there was a latent (albeit possibly hard to hit) bug. Specifically
> > util/async.c::aio_get_linux_aio:
> >
> > #ifdef CONFIG_LINUX_AIO
> > LinuxAioState *aio_get_linux_aio(AioContext *ctx)
> > {
> >     if (!ctx->linux_aio) {
> >         ctx->linux_aio = laio_init();
> >         laio_attach_aio_context(ctx->linux_aio, ctx);
> >     }
> >     return ctx->linux_aio;
> > }
> > #endif
> >
> > laio_init() can in certain conditions return NULL, but that's not
checked
> > here and then the NULL result is passed directly into
> > laio_attach_aio_context, which dereferences it without checking that the
> > pointer is valid.
> >
>
> Looks like a good old-fashioned bug to me:


Agreed!

<snip>

> Wanna send a patch?

Yep I'll work on this over the next few days. Thanks for reply!

-Nish
