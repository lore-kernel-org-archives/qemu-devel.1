Received: from eggs.gnu.org ([2001:4830:134:3::10]:49727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dURz7-0007hL-KD
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 02:15:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dURz2-00034W-Vv
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 02:15:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dURz2-00034J-PD
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 02:15:48 -0400
References: <1499586614-20507-1-git-send-email-cota@braap.org>
	<1499586614-20507-3-git-send-email-cota@braap.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a51cb905-62dc-a286-4d6a-53db3232ef24@redhat.com>
Date: Mon, 10 Jul 2017 08:15:43 +0200
MIME-Version: 1.0
In-Reply-To: <1499586614-20507-3-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/22] translate-all: remove redundant
 !tcg_enabled check in dump_exec_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

On 09.07.2017 09:49, Emilio G. Cota wrote:
> This check is redundant because it is already performed by the only
> caller of dump_exec_info -- the caller was updated by b7da97eef
> ("monitor: Check whether TCG is enabled before running the "info jit"
> code").
> 
> Checking twice wouldn't necessarily be too bad, but here the check also
> returns with tb_lock held. So we can either do the check before tb_lock is
> acquired, or just get rid of it. Given that it is redundant, I am going
> for the latter option.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/translate-all.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index dfb9f0d..f768681 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -1851,11 +1851,6 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
>  
>      tb_lock();
>  
> -    if (!tcg_enabled()) {
> -        cpu_fprintf(f, "TCG not enabled\n");
> -        return;
> -    }
> -
>      target_code_size = 0;
>      max_target_code_size = 0;
>      cross_page = 0;
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
