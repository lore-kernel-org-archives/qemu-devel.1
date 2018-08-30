Received: from eggs.gnu.org ([2001:4830:134:3::10]:55568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fvT7o-0000k6-ML
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 16:01:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fvT7g-0002tI-Cf
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 16:01:02 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180830122756.13991-1-david@redhat.com>
	<20180830122756.13991-9-david@redhat.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <239b8ae4-6686-4bbe-b2f8-9e5fd7f64f89@twiddle.net>
Date: Thu, 30 Aug 2018 12:55:48 -0700
MIME-Version: 1.0
In-Reply-To: <20180830122756.13991-9-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 8/9] s390x/tcg: fix FP register pair
 checks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Alexander Graf <agraf@suse.de>

On 08/30/2018 05:27 AM, David Hildenbrand wrote:
> Valid register pairs are 0/2, 1/3, 4/6, 5/7, 8/10, 9/11, 12/14, 13/15.
> 
> R1/R2 always selects the lower number, so the current checks are not
> correct as e.g. 2/4 could be selected as a pair.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/translate.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 1ca6ef45a1..5cc65b0840 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -1110,7 +1110,7 @@ typedef struct {
>  #define IF_HFP3     0x0004      /* r3 points at fp reg for HFP instructions */
>  #define IF_BFP      0x0008      /* binary floating point instruction */
>  #define IF_DFP      0x0010      /* decimal floating point instruction */
> -#define IF_PRIV     0x0020      /* priviledged instruction */
> +#define IF_PRIV     0x0020      /* privileged instruction */
> @@ -6013,7 +6019,7 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
>  
>      /* process flags */
>      if (insn->flags) {
> -        /* priviledged instruction */
> +        /* privileged instruction */

Merge these back into the previous patch.  But otherwise,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
