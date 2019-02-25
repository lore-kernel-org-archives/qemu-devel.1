Received: from eggs.gnu.org ([209.51.188.92]:55385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyFFe-0001Ey-Q5
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyFFe-0004et-58
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 07:20:54 -0500
References: <20190225115552.7534-1-david@redhat.com>
	<20190225115552.7534-3-david@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e34a8a1e-7bc4-48d8-f12b-a325c62c6f35@redhat.com>
Date: Mon, 25 Feb 2019 13:20:42 +0100
MIME-Version: 1.0
In-Reply-To: <20190225115552.7534-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/7] s390x/tcg: Simplify disassembler
 operands initialization
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>

On 25/02/2019 12.55, David Hildenbrand wrote:
> Let's simply initialization to 0.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/translate.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 19072efec6..c646e50eb3 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -6091,7 +6091,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
>      const DisasInsn *insn;
>      DisasJumpType ret = DISAS_NEXT;
>      DisasFields f;
> -    DisasOps o;
> +    DisasOps o = {};
>  
>      /* Search for the insn in the table.  */
>      insn = extract_insn(env, s, &f);
> @@ -6161,12 +6161,6 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
>      /* Set up the strutures we use to communicate with the helpers. */
>      s->insn = insn;
>      s->fields = &f;
> -    o.g_out = o.g_out2 = o.g_in1 = o.g_in2 = false;
> -    o.out = NULL;
> -    o.out2 = NULL;
> -    o.in1 = NULL;
> -    o.in2 = NULL;
> -    o.addr1 = NULL;
>  
>      /* Implement the instruction.  */
>      if (insn->help_in1) {
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
