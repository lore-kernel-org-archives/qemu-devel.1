Received: from eggs.gnu.org ([2001:4830:134:3::10]:57025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9lAG-0002Bc-BF
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g9lAB-0001hh-8O
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:06:40 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:50700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g9lAB-0001hN-1e
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 02:06:35 -0400
Received: by mail-wm1-f42.google.com with SMTP id i8-v6so528457wmg.0
	for <qemu-devel@nongnu.org>; Mon, 08 Oct 2018 23:06:34 -0700 (PDT)
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-32-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bc784dff-ce3f-99ec-6a40-5dc8503d3675@redhat.com>
Date: Tue, 9 Oct 2018 08:06:32 +0200
MIME-Version: 1.0
In-Reply-To: <20181008173125.19678-32-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 31/31] vl: Simplify call of parse_name()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 08/10/2018 19:31, Markus Armbruster wrote:
> main() checks for parse_name() failure even though it can't actually
> fail.  That's okay.  Simplify it to check by passing &error_fatal,
> like the other users of qemu_opts_foreach().
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  vl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/vl.c b/vl.c
> index 101e0123d9..0a76c58943 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3926,10 +3926,8 @@ int main(int argc, char **argv, char **envp)
>      }
>  #endif
>  
> -    if (qemu_opts_foreach(qemu_find_opts("name"),
> -                          parse_name, NULL, NULL)) {
> -        exit(1);
> -    }
> +    qemu_opts_foreach(qemu_find_opts("name"),
> +                      parse_name, NULL, &error_fatal);
>  
>  #ifndef _WIN32
>      qemu_opts_foreach(qemu_find_opts("add-fd"),
> 
