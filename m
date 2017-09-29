Received: from eggs.gnu.org ([2001:4830:134:3::10]:46971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <teisenbe@google.com>) id 1dy1tY-000200-Ac
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 16:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <teisenbe@google.com>) id 1dy1tX-0007hp-4e
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 16:28:24 -0400
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:56764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <teisenbe@google.com>) id 1dy1tW-0007h3-U9
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 16:28:23 -0400
Received: by mail-qt0-x236.google.com with SMTP id l25so1034482qtf.13
	for <qemu-devel@nongnu.org>; Fri, 29 Sep 2017 13:28:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170929194329.GO21016@localhost.localdomain>
References: <CAP26EVRNVb=Mq=O3s51w7fDhGVmf-e3XFFA73MRzc5b4qKBA4g@mail.gmail.com>
	<20170929194329.GO21016@localhost.localdomain>
From: Todd Eisenberger <teisenbe@google.com>
Date: Fri, 29 Sep 2017 13:28:20 -0700
Message-ID: <CAP26EVQoZPT5i-HJ=QhhNvkzQrMgAa+HM+u17g+J_y=Sr6mdig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] x86: Correct translation of some rdgsbase
 and wrgsbase encodings
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
List-ID: <qemu-devel.nongnu.org>

Ah, sorry for that trouble.  I'll look into setting up git-send-email next
time I need to send a patch out.

On Fri, Sep 29, 2017 at 12:43 PM, Eduardo Habkost <ehabkost@redhat.com>
wrote:

> On Thu, Sep 28, 2017 at 10:17:06AM -0700, Todd Eisenberger via Qemu-devel
> wrote:
> > It looks like there was a transcription error when writing this code
> > initially.  The code previously only decoded src or dst of rax.  This
> > resolves
> > https://bugs.launchpad.net/qemu/+bug/1719984.
> >
> > Signed-off-by: Todd Eisenberger <teisenbe@google.com>
> > ---
> >  target/i386/translate.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/i386/translate.c b/target/i386/translate.c
> > index a8986f4c1a..7b920115f9 100644
> > --- a/target/i386/translate.c
> > +++ b/target/i386/translate.c
> > @@ -8155,9 +8155,9 @@ static target_ulong disas_insn(DisasContext *s,
> > CPUState *cpu)
>
> The patch is corrupted due to line wrapping.  I recommend using
> git-send-email to avoid that.
>
> I'm queueing it on x86-next after fixing it manually.
>
>
> >              break;
> >
> >          case 0xc0 ... 0xc7: /* rdfsbase (f3 0f ae /0) */
> > -        case 0xc8 ... 0xc8: /* rdgsbase (f3 0f ae /1) */
> > +        case 0xc8 ... 0xcf: /* rdgsbase (f3 0f ae /1) */
> >          case 0xd0 ... 0xd7: /* wrfsbase (f3 0f ae /2) */
> > -        case 0xd8 ... 0xd8: /* wrgsbase (f3 0f ae /3) */
> > +        case 0xd8 ... 0xdf: /* wrgsbase (f3 0f ae /3) */
> >              if (CODE64(s)
> >                  && (prefixes & PREFIX_REPZ)
> >                  && !(prefixes & PREFIX_LOCK)
> >
>
> --
> Eduardo
>
