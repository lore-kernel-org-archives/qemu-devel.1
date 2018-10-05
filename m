Received: from eggs.gnu.org ([2001:4830:134:3::10]:51615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8QKO-0006PW-Na
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:39:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1g8QKL-0006Ly-M9
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:39:36 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37408)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1g8QKL-0006I4-D1
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 09:39:33 -0400
Received: by mail-wr1-f66.google.com with SMTP id y11-v6so2866275wrd.4
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 06:39:31 -0700 (PDT)
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-8-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <874d2488-771a-3f17-4838-c38f76e80dec@redhat.com>
Date: Fri, 5 Oct 2018 15:39:28 +0200
MIME-Version: 1.0
In-Reply-To: <20181004161852.11673-8-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/10] scripts/decodetree.py: remove unused
 imports
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
>  scripts/decodetree.py | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index 277f9a9bba..457cffea90 100755
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -149,12 +149,10 @@
>  #   trans_addl_i(ctx, &arg_opi, insn)
>  #
>  
> -import io
>  import os
>  import re
>  import sys
>  import getopt
> -import pdb
>  
>  insnwidth = 32
>  insnmask = 0xffffffff
> 
