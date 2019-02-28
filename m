Received: from eggs.gnu.org ([209.51.188.92]:46775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzMe2-0006KE-Ld
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gzMe0-0001Aw-M2
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:26:42 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:36782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gzMdx-00016T-TN
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 09:26:38 -0500
Received: by mail-oi1-x241.google.com with SMTP id t206so16619414oib.3
	for <qemu-devel@nongnu.org>; Thu, 28 Feb 2019 06:26:31 -0800 (PST)
MIME-Version: 1.0
References: <4817f5c3b20aedba869608c06e76d11a722f4864.camel@gmail.com>
	<3aaecc9d-d03b-a754-0ef0-a65609777b2e@redhat.com>
In-Reply-To: <3aaecc9d-d03b-a754-0ef0-a65609777b2e@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Feb 2019 14:26:19 +0000
Message-ID: <CAFEAcA8ZxNPTcPWJZLBN7dir1-6Kj7-2LuLX3f58SfDMM7xyTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] trivial malloc to g_malloc in thunk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Aarushi Mehta <mehta.aaru20@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@mail.ru>

On Thu, 28 Feb 2019 at 14:00, Eric Blake <eblake@redhat.com> wrote:
>
> On 2/28/19 7:42 AM, Aarushi Mehta wrote:
> > Hi
> >
> > This is a trivial contribution part of the BiteSizedTasks on the wiki.
> > I found this discussion http://git.corpit.ru/?p=qemu.git;a=commit;h=b45c03f585ea9bb1af76c73e82195418c294919d
> > on migrating even g_malloc to g_new, is this not appropriate for the same?
> > The wiki can presumably use an update regarding this.
> >
> > Signed-off-by: Aarushi <mehta.aaru20@gmail.com>
> > ---
> >  thunk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/thunk.c b/thunk.c
> > index d5d8645cd4..03fb2abab7 100644
> > --- a/thunk.c
> > +++ b/thunk.c
> > @@ -89,7 +89,7 @@ void thunk_register_struct(int id, const char *name, const argtype *types)
> >      for(i = 0;i < 2; i++) {
> >          offset = 0;
> >          max_align = 1;
> > -        se->field_offsets[i] = malloc(nb_fields * sizeof(int));
> > +        se->field_offsets[i] = g_malloc(nb_fields * sizeof(int));
>
> Where is the counterpart free() that needs to be changed to g_free()?

There is none, because this code sets up a data structure at
startup which then lasts for the lifetime of the QEMU process.
This is definitely worth noting in the commit message.

thanks
-- PMM
