Received: from eggs.gnu.org ([2001:4830:134:3::10]:54633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fRK2S-0000bB-Uy
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1fRK2O-00081a-WD
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:14:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46760 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <crosa@redhat.com>) id 1fRK2O-00081H-RI
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:14:52 -0400
References: <20180608143026.20167-1-ehabkost@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <29c06db1-2a75-8d4f-358b-9aeff73b08d1@redhat.com>
Date: Fri, 8 Jun 2018 12:14:47 -0400
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
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Daniel P. Berrange" <berrange@redhat.com>



On 06/08/2018 10:30 AM, Eduardo Habkost wrote:
> All of the supported build platforms documented in qemu-doc.texi
> should already support Python 2.7.
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

This is a memorable milestone for the Python code.

Reviewed-by: Cleber Rosa <crosa@redhat.com>
