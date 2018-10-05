Received: from eggs.gnu.org ([2001:4830:134:3::10]:51900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8QLC-0006vE-Gc
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8QL9-0007kU-7n
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:40:26 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g8QL8-0007kE-VJ
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:40:23 -0400
Received: by mail-wm1-f67.google.com with SMTP id b19-v6so1922885wme.3
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 06:40:22 -0700 (PDT)
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-9-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <26ba5275-20bb-ba04-180c-7edbe0d0dbe4@redhat.com>
Date: Fri, 5 Oct 2018 15:40:20 +0200
MIME-Version: 1.0
In-Reply-To: <20181004161852.11673-9-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 08/10] scripts/decodetree.py: fix reference
 to attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>

On 04/10/2018 18:18, Cleber Rosa wrote:
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  scripts/decodetree.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index 457cffea90..37c76b5507 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -298,7 +298,7 @@ class Field:
>              s = 's'
>          else:
>              s = ''
> -        return str(pos) + ':' + s + str(len)
> +        return str(self.pos) + ':' + s + str(self.len)
>  
>      def str_extract(self):
>          if self.sign:
> 
