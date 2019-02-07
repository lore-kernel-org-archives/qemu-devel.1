Received: from eggs.gnu.org ([209.51.188.92]:48185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1grrIt-0000Z0-QA
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 16:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1grrIr-0006Cl-S4
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 16:33:51 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:50876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1grrIq-00069S-2G
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 16:33:49 -0500
Received: by mail-wm1-f52.google.com with SMTP id z5so1427737wmf.0
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 13:33:43 -0800 (PST)
References: <20190207193605.25676-1-crosa@redhat.com>
	<20190207193605.25676-2-crosa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bfda8184-db4e-ac05-2054-cb33fc45f1bb@redhat.com>
Date: Thu, 7 Feb 2019 22:33:40 +0100
MIME-Version: 1.0
In-Reply-To: <20190207193605.25676-2-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/4] configure: remove handling of "wav"
 audio driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>

On 2/7/19 8:36 PM, Cleber Rosa wrote:
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
