Received: from eggs.gnu.org ([2001:4830:134:3::10]:58669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dX5NC-0006yO-Eg
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dX5N7-0001YB-Kz
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:43:38 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dX5N7-0001Xz-GW
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:43:33 -0400
Received: by mail-qt0-x243.google.com with SMTP id 19so2164565qty.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 05:43:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170717114332.2941-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a72f84d2-b8aa-72e7-8e38-0d7e65ff35b1@amsat.org>
Date: Mon, 17 Jul 2017 09:43:29 -0300
MIME-Version: 1.0
In-Reply-To: <20170717114332.2941-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] keymaps: fr-ca: more fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?B?SsOpcsO0bWUgUG91bGlu?= <jeromepoulin@gmail.com>
Cc: Thomas Huth <thuth@redhat.com>

Cc: Jérôme

I'd expect Jérôme email in this tag but since this is not a 
Signed-off-by that should be ok.

On 07/17/2017 08:43 AM, Gerd Hoffmann wrote:
> Fixes: https://bugs.launchpad.net/qemu/+bug/533613
> Cc: Thomas Huth <thuth@redhat.com>
> Suggested-by: Jérôme Poulin

Jérôme Poulin <jeromepoulin@gmail.com>

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   pc-bios/keymaps/fr-ca | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/pc-bios/keymaps/fr-ca b/pc-bios/keymaps/fr-ca
> index 030f56a78e..b177d074c9 100644
> --- a/pc-bios/keymaps/fr-ca
> +++ b/pc-bios/keymaps/fr-ca
> @@ -3,6 +3,8 @@
>   include common
>   map 0xc0c
>   
> +numbersign 0x29
> +bar 0x29
>   backslash 0x29 altgr
>   plusminus 0x2 altgr
>   at 0x3 altgr
> @@ -10,7 +12,6 @@ sterling 0x4 altgr
>   cent 0x5 altgr
>   currency 0x6 altgr
>   notsign 0x7 altgr
> -bar 0x29 shift
>   twosuperior 0x9 altgr
>   threesuperior 0xa altgr
>   onequarter 0xb altgr
> @@ -38,6 +39,10 @@ dead_cedilla 0x1b
>   dead_diaeresis 0x1b shift
>   exclam 0x2 shift
>   quotedbl 0x3 shift
> +comma 0x33
> +apostrophe 0x33 shift
> +period 0x34
> +period 0x34 shift
>   slash 0x4 shift
>   dollar 0x5 shift
>   percent 0x6 shift
> @@ -49,4 +54,7 @@ parenright 0xb shift
>   underscore 0xc shift
>   plus 0xd shift
>   minus 0xc
> +underscore 0xc shift
>   equal 0xd
> +semicolon 0x27
> +colon 0x27 shift
> 
