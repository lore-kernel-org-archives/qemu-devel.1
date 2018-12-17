Received: from eggs.gnu.org ([2001:4830:134:3::10]:55654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gYsy7-0002tP-Au
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gYsy2-0005Bg-Dw
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 08:29:59 -0500
References: <20181213175807.12039-1-armbru@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <acaa022e-681c-bf52-a962-b3a10b08321e@vivier.eu>
Date: Mon, 17 Dec 2018 14:29:45 +0100
MIME-Version: 1.0
In-Reply-To: <20181213175807.12039-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] vl: Use error_fatal to
 simplify obvious fatal errors (again)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 13/12/2018 18:58, Markus Armbruster wrote:
> Patch created mechanically by rerunning:
> 
>     $ spatch --in-place --sp-file scripts/coccinelle/use-error_fatal.cocci \
>              --macro-file scripts/cocci-macro-file.h vl.c
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  vl.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index a5ae5f23d2..702a828ca2 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3138,11 +3138,8 @@ int main(int argc, char **argv, char **envp)
>                      Visitor *v;
>                      BlockdevOptions_queue *bdo;
>  
> -                    v = qobject_input_visitor_new_str(optarg, "driver", &err);
> -                    if (!v) {
> -                        error_report_err(err);
> -                        exit(1);
> -                    }
> +                    v = qobject_input_visitor_new_str(optarg, "driver",
> +                                                      &error_fatal);
>  
>                      bdo = g_new(BlockdevOptions_queue, 1);
>                      visit_type_BlockdevOptions(v, NULL, &bdo->bdo,
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
