Received: from eggs.gnu.org ([2001:4830:134:3::10]:35757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXkww-0004CR-EZ
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:44:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gXkwr-0001gZ-Fb
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:44:06 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:43609)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gXkwr-0001fT-44
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 05:44:01 -0500
Received: by mail-wr1-f44.google.com with SMTP id r10so4930893wrs.10
	for <qemu-devel@nongnu.org>; Fri, 14 Dec 2018 02:43:59 -0800 (PST)
References: <20181213175807.12039-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <db306820-d31e-b277-182e-09f37c6d0e2e@redhat.com>
Date: Fri, 14 Dec 2018 11:43:56 +0100
MIME-Version: 1.0
In-Reply-To: <20181213175807.12039-1-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] vl: Use error_fatal to simplify obvious
 fatal errors (again)
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

On 12/13/18 6:58 PM, Markus Armbruster wrote:
> Patch created mechanically by rerunning:
> 
>     $ spatch --in-place --sp-file scripts/coccinelle/use-error_fatal.cocci \
>              --macro-file scripts/cocci-macro-file.h vl.c
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

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
