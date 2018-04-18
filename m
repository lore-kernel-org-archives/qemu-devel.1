Received: from eggs.gnu.org ([2001:4830:134:3::10]:39481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8jJx-0003m7-DK
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f8jJs-0000gK-H8
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 05:24:09 -0400
References: <20180418075045.27393-1-olaf@aepfle.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <41df38a4-dc02-7c17-4877-26541fddd209@redhat.com>
Date: Wed, 18 Apr 2018 11:23:56 +0200
MIME-Version: 1.0
In-Reply-To: <20180418075045.27393-1-olaf@aepfle.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] configure: recognize more rpmbuild
 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>, qemu-trivial@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On 18/04/2018 09:50, Olaf Hering wrote:
> Extend the list of recognized, but ignored options from rpms %configure
> macro. This fixes build on hosts running SUSE Linux.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  configure | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/configure b/configure
> index 0a19b033bc..6e9b994f21 100755
> --- a/configure
> +++ b/configure
> @@ -959,6 +959,9 @@ for opt do
>    ;;
>    --firmwarepath=*) firmwarepath="$optarg"
>    ;;
> +  --host=*|--build=*|\
> +  --program-prefix=*|--exec-prefix=*|\
> +  --disable-dependency-tracking|\
>    --sbindir=*|--sharedstatedir=*|\
>    --oldincludedir=*|--datarootdir=*|--infodir=*|--localedir=*|\
>    --htmldir=*|--dvidir=*|--pdfdir=*|--psdir=*)
> 

Queued, thanks.

Paolo
