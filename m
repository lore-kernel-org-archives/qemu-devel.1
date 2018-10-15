Received: from eggs.gnu.org ([2001:4830:134:3::10]:53440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gCBOg-0002Cr-Q5
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:31:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gCBOc-0005Ya-4N
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:31:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gCBOb-0005Hu-Rj
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 18:31:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id d2-v6so23145670wro.7
	for <qemu-devel@nongnu.org>; Mon, 15 Oct 2018 15:31:12 -0700 (PDT)
References: <20181015172817.19796-1-mreitz@redhat.com>
	<20181015172817.19796-6-mreitz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <592b19a1-cdc4-634c-40f1-d1d29e4a33c7@redhat.com>
Date: Tue, 16 Oct 2018 00:31:10 +0200
MIME-Version: 1.0
In-Reply-To: <20181015172817.19796-6-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/5] fw_cfg: Drop newline in @file
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

On 15/10/2018 19:28, Max Reitz wrote:
> There is no good reason why there should be a newline in this
> description, so remove it.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  vl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/vl.c b/vl.c
> index f9ed053eab..19f8cc67ff 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -529,7 +529,7 @@ static QemuOptsList qemu_fw_cfg_opts = {
>          }, {
>              .name = "file",
>              .type = QEMU_OPT_STRING,
> -            .help = "Sets the name of the file from which\n"
> +            .help = "Sets the name of the file from which "
>                      "the fw_cfg blob will be loaded",
>          }, {
>              .name = "string",
> 
