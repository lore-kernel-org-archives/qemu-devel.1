Received: from eggs.gnu.org ([209.51.188.92]:34120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDZs-0006Dk-8b
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:45:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDZq-0004Wi-Tw
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 04:45:08 -0500
References: <20190207193605.25676-1-crosa@redhat.com>
	<20190207193605.25676-2-crosa@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <aff2dc8f-4be1-8c05-a8c7-45c704b45e1a@vivier.eu>
Date: Thu, 14 Feb 2019 10:44:32 +0100
MIME-Version: 1.0
In-Reply-To: <20190207193605.25676-2-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 1/4] configure: remove
 handling of "wav" audio driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>

On 07/02/2019 20:36, Cleber Rosa wrote:
> This looks like a leftover that was never implemented.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>  configure | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/configure b/configure
> index fbd0825488..ff55e2273e 100755
> --- a/configure
> +++ b/configure
> @@ -3350,10 +3350,6 @@ for drv in $audio_drv_list; do
>        oss_libs="$oss_lib"
>      ;;
>  
> -    wav)
> -    # XXX: Probes for CoreAudio, DirectSound
> -    ;;
> -
>      *)
>      echo "$audio_possible_drivers" | grep -q "\<$drv\>" || {
>          error_exit "Unknown driver '$drv' selected" \
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
