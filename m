Received: from eggs.gnu.org ([2001:4830:134:3::10]:56759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQjSL-0008MB-0o
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dQjSG-0004jn-8e
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:06:40 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:59953)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dQjSG-0004jE-3g
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 20:06:36 -0400
Date: Thu, 29 Jun 2017 20:06:34 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170630000634.GG13979@flamenco>
References: <149865219962.17063.10630533069463266646.stgit@frigg.lan>
	<149865389443.17063.5223786571159875501.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149865389443.17063.5223786571159875501.stgit@frigg.lan>
Subject: Re: [Qemu-devel] [PATCH v11 07/29] target/i386: [tcg] Refactor
 init_globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

On Wed, Jun 28, 2017 at 15:44:54 +0300, Lluís Vilanova wrote:
> Incrementally paves the way towards using the generic instruction translation
> loop.
> 
> Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
> ---
>  target/i386/translate.c |   29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 04453ce48a..d015ea73fa 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -8435,6 +8435,22 @@ static void i386_trblock_init_disas_context(DisasContextBase *dcbase, CPUState *
>  #endif
>  }
>  
> +static void i386_trblock_init_globals(DisasContextBase *dcbase, CPUState *cpu)

I'd do the s/trblock/tr/ conversion to all other patches. But I won't
mention it again :)

Reviewed-by: Emilio G. Cota <cota@braap.org>

		E.
