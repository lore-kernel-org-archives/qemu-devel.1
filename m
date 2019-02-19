Received: from eggs.gnu.org ([209.51.188.92]:55900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gw56r-0000Ig-AP
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gw56h-0008A3-Ki
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:06:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54332)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gw56d-00084r-8S
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:06:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D20F87628
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 13:06:36 +0000 (UTC)
References: <20190219124257.3001-1-kraxel@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <fa45ba19-b6e0-7a85-e370-ca19f31d9b7f@redhat.com>
Date: Tue, 19 Feb 2019 14:06:34 +0100
MIME-Version: 1.0
In-Reply-To: <20190219124257.3001-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] audio: don't build alsa and sdl by
 default on linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 19.02.19 13:42, Gerd Hoffmann wrote:
> In case no sound hardware is present both alsa and sdl drivers
> initialize successfully and throw errors later on, i.e. effectively
> the automatic probing doesn't work.  Drop them from the list of
> default audio drivers for linux because of that.
> 
> Fixes: 6a48541873 audio: probe audio drivers by default
> Buglink: https://bugs.launchpad.net/qemu/+bug/1816052
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index fbd0825488..651b4f7514 100755
> --- a/configure
> +++ b/configure
> @@ -877,7 +877,7 @@ Haiku)
>    LIBS="-lposix_error_mapper -lnetwork $LIBS"
>  ;;
>  Linux)
> -  audio_drv_list="try-pa try-alsa try-sdl oss"
> +  audio_drv_list="try-pa oss"
>    audio_possible_drivers="oss alsa sdl pa"
>    linux="yes"
>    linux_user="yes"
> 

It makes it work under my crazy environment again.

Tested-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb
