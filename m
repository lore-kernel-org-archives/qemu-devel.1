Received: from eggs.gnu.org ([2001:4830:134:3::10]:34897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dy1CF-0006EM-M7
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dy1CB-00040s-PD
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:43:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44702)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dy1CB-00040R-IX
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 15:43:35 -0400
Date: Fri, 29 Sep 2017 16:43:29 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170929194329.GO21016@localhost.localdomain>
References: <CAP26EVRNVb=Mq=O3s51w7fDhGVmf-e3XFFA73MRzc5b4qKBA4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP26EVRNVb=Mq=O3s51w7fDhGVmf-e3XFFA73MRzc5b4qKBA4g@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] x86: Correct translation of some rdgsbase
 and wrgsbase encodings
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Todd Eisenberger <teisenbe@google.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
List-ID: <qemu-devel.nongnu.org>

On Thu, Sep 28, 2017 at 10:17:06AM -0700, Todd Eisenberger via Qemu-devel wrote:
> It looks like there was a transcription error when writing this code
> initially.  The code previously only decoded src or dst of rax.  This
> resolves
> https://bugs.launchpad.net/qemu/+bug/1719984.
> 
> Signed-off-by: Todd Eisenberger <teisenbe@google.com>
> ---
>  target/i386/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index a8986f4c1a..7b920115f9 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -8155,9 +8155,9 @@ static target_ulong disas_insn(DisasContext *s,
> CPUState *cpu)

The patch is corrupted due to line wrapping.  I recommend using
git-send-email to avoid that.

I'm queueing it on x86-next after fixing it manually.


>              break;
> 
>          case 0xc0 ... 0xc7: /* rdfsbase (f3 0f ae /0) */
> -        case 0xc8 ... 0xc8: /* rdgsbase (f3 0f ae /1) */
> +        case 0xc8 ... 0xcf: /* rdgsbase (f3 0f ae /1) */
>          case 0xd0 ... 0xd7: /* wrfsbase (f3 0f ae /2) */
> -        case 0xd8 ... 0xd8: /* wrgsbase (f3 0f ae /3) */
> +        case 0xd8 ... 0xdf: /* wrgsbase (f3 0f ae /3) */
>              if (CODE64(s)
>                  && (prefixes & PREFIX_REPZ)
>                  && !(prefixes & PREFIX_LOCK)
> 

-- 
Eduardo
