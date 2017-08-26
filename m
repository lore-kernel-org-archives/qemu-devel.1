Received: from eggs.gnu.org ([2001:4830:134:3::10]:57374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dlOyw-0002B1-9w
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 20:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dlOyr-00023s-Cu
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 20:29:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dlOyr-00023X-6U
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 20:29:41 -0400
Date: Sat, 26 Aug 2017 08:29:34 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170826002934.GA2018@lemon.lan>
References: <20170825155732.15665-1-stefanha@redhat.com>
	<20170825155732.15665-3-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170825155732.15665-3-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] docker.py: Python 2.6 argparse
 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, chugh.ishani@research.iiit.ac.in, Daniel Berrange <berrange@redhat.com>

On Fri, 08/25 16:57, Stefan Hajnoczi wrote:
> Add the scripts/ directory to sys.path so Python 2.6 will be able to
> import argparse.
> 
> Cc: Fam Zheng <famz@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/docker/docker.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index ee40ca04d9..81c87ee329 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -13,12 +13,14 @@
>  
>  import os
>  import sys
> +sys.path.append(os.path.join(os.path.dirname(__file__),
> +                             '..', '..', 'scripts'))
> +import argparse
>  import subprocess
>  import json
>  import hashlib
>  import atexit
>  import uuid
> -import argparse
>  import tempfile
>  import re
>  import signal
> -- 
> 2.13.5
> 

Acked-by: Fam Zheng <famz@redhat.com>
