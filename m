Received: from eggs.gnu.org ([2001:4830:134:3::10]:56491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD6pt-00029X-0Q
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:14:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dD6pp-0006Wl-SX
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:14:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dD6pp-0006Ud-MR
	for qemu-devel@nongnu.org; Tue, 23 May 2017 06:14:37 -0400
References: <20170523030312.6360-1-rth@twiddle.net>
	<20170523030312.6360-28-rth@twiddle.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bba1a26b-560b-e2d5-3694-1c6cc153d4b5@redhat.com>
Date: Tue, 23 May 2017 12:14:32 +0200
MIME-Version: 1.0
In-Reply-To: <20170523030312.6360-28-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 27/31] target/s390x: Use unwind data for
 helper_tprot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org

On 23.05.2017 05:03, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <rth@twiddle.net>
> ---
>  target/s390x/mem_helper.c | 1 -
>  target/s390x/translate.c  | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index a874f8a..7f22bf0 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -943,7 +943,6 @@ uint32_t HELPER(testblock)(CPUS390XState *env, uint64_t real_addr)
>  uint32_t HELPER(tprot)(uint64_t a1, uint64_t a2)
>  {
>      /* XXX implement */
> -

Unnecessary white space change ;-)

>      return 0;
>  }
>  
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index 694e099..282fa27 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -4054,7 +4054,6 @@ static ExitStatus op_testblock(DisasContext *s, DisasOps *o)
>  
>  static ExitStatus op_tprot(DisasContext *s, DisasOps *o)
>  {
> -    potential_page_fault(s);
>      gen_helper_tprot(cc_op, o->addr1, o->in2);
>      set_cc_static(s);
>      return NO_EXIT;
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
