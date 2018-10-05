Received: from eggs.gnu.org ([2001:4830:134:3::10]:37164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8RB1-0001uX-78
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8RAw-0000Q1-0l
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:33:59 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g8RAv-0000PE-O4
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 10:33:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id g15-v6so11171328wru.9
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 07:33:53 -0700 (PDT)
References: <20181004140522.945682-1-eblake@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e454e2ea-6ee6-4605-50ad-16112ef6f5cc@redhat.com>
Date: Fri, 5 Oct 2018 16:33:51 +0200
MIME-Version: 1.0
In-Reply-To: <20181004140522.945682-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] edid: Ignore built binary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, kraxel@redhat.com

On 04/10/2018 16:05, Eric Blake wrote:
> Added in commit 72d277a7.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 5668d027824..64efdfd9292 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -107,6 +107,7 @@
>  /qemu-doc.html
>  /qemu-doc.info
>  /qemu-doc.txt
> +/qemu-edid
>  /qemu-img
>  /qemu-nbd
>  /qemu-options.def
> 
