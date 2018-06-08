Received: from eggs.gnu.org ([2001:4830:134:3::10]:54860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRIWO-0004M9-KY
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:37:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRIWL-0000w7-H0
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:37:44 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRIWL-0000vt-CB
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:37:41 -0400
Received: by mail-qt0-x243.google.com with SMTP id l10-v6so8434396qtj.0
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 07:37:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180608143026.20167-1-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <24e7a171-33b6-e9ca-9d9c-d61a7a2c5047@amsat.org>
Date: Fri, 8 Jun 2018 11:37:36 -0300
MIME-Version: 1.0
In-Reply-To: <20180608143026.20167-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] configure: Require Python 2.7 or newer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>

Cc'ing Eric

On 06/08/2018 11:30 AM, Eduardo Habkost wrote:
> All of the supported build platforms documented in qemu-doc.texi
> should already support Python 2.7.

https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg05173.html

  On 08/25/2017 11:40 AM, Peter Maydell wrote:
  > Our choices about our dependencies are generally driven by "what
  > are the versions available on the oldest distros which we wish
  > to support building QEMU on", which typically is whatever the
  > long-term-support versions of Ubuntu, SUSE, Redhat, etc are.
  >
  > Has somebody checked what that means for our Python version
  > requirements?

  At least this one:

  RHEL/CentOS 6: Python-2.6.6

> 
> Removing support for Python 2.6 will allow us to remove some
> compatibility modules we carry in the QEMU tree:
> 
> * scripts/argparse.py
> * scripts/ordereddict.py
> 
> Python 2.6 is also not receiving bug fixes upstream and is not
> supported by pylint, which makes it harder to keep the code
> compatible with both Python 2 and Python 3.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  configure | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/configure b/configure
> index 14b11130a7..a8c4094c87 100755
> --- a/configure
> +++ b/configure
> @@ -1651,8 +1651,8 @@ fi
>  
>  # Note that if the Python conditional here evaluates True we will exit
>  # with status 1 which is a shell 'false' value.
> -if ! $python -c 'import sys; sys.exit(sys.version_info < (2,6))'; then
> -  error_exit "Cannot use '$python', Python 2 >= 2.6 or Python 3 is required." \
> +if ! $python -c 'import sys; sys.exit(sys.version_info < (2,7))'; then
> +  error_exit "Cannot use '$python', Python 2 >= 2.7 or Python 3 is required." \
>        "Use --python=/path/to/python to specify a supported Python."
>  fi
>  
> 
