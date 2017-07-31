Received: from eggs.gnu.org ([2001:4830:134:3::10]:39391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dc7I1-0006rr-I0
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dc7Hy-00083r-9Y
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:47:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dc7Hx-00082g-W8
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 05:47:02 -0400
Date: Mon, 31 Jul 2017 10:46:57 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170731094657.GE766@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <BCFCA0C8-8811-43C3-B65A-76B4470868FD@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BCFCA0C8-8811-43C3-B65A-76B4470868FD@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Add more function keys to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On Sun, Jul 30, 2017 at 04:29:27PM -0400, Programmingkid wrote:
> There are now keyboards that have 19 function keys. This patch extends QEMU so these function keys can be used.
> 
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
>  qapi-schema.json  | 12 +++++++++++-
>  ui/input-keymap.c |  9 +++++++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi-schema.json b/qapi-schema.json
> index c96f0a2..f1c989b 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -4862,6 +4862,15 @@
>  # @ac_refresh: since 2.10
>  # @ac_bookmarks: since 2.10
>  # altgr, altgr_r: dropped in 2.10
> +# @f16: since 2.11
> +# @f17: since 2.11
> +# @f18: since 2.11
> +# @f19: since 2.11
> +# @f20: since 2.11
> +# @f21: since 2.11
> +# @f22: since 2.11
> +# @f23: since 2.11
> +# @f24: since 2.11
>  #
>  # Since: 1.3.0
>  #
> @@ -4888,7 +4897,8 @@
>              'audionext', 'audioprev', 'audiostop', 'audioplay', 'audiomute',
>              'volumeup', 'volumedown', 'mediaselect',
>              'mail', 'calculator', 'computer',
> -            'ac_home', 'ac_back', 'ac_forward', 'ac_refresh', 'ac_bookmarks' ] }
> +            'ac_home', 'ac_back', 'ac_forward', 'ac_refresh', 'ac_bookmarks',
> +            'f16', 'f17', 'f18', 'f19', 'f20', 'f21', 'f22', 'f23', 'f24'] }
>  
>  ##
>  # @KeyValue:

This bit looks fine.

> diff --git a/ui/input-keymap.c b/ui/input-keymap.c
> index cf979c2..c0413e1 100644
> --- a/ui/input-keymap.c
> +++ b/ui/input-keymap.c
> @@ -251,6 +251,15 @@ static const int qcode_to_number[] = {
>  
>      [Q_KEY_CODE_F11] = 0x57,
>      [Q_KEY_CODE_F12] = 0x58,
> +    [Q_KEY_CODE_F16] = 0x59,
> +    [Q_KEY_CODE_F17] = 0x5a,
> +    [Q_KEY_CODE_F18] = 0x5b,
> +    [Q_KEY_CODE_F19] = 0x5c,
> +    [Q_KEY_CODE_F20] = 0x5d,
> +    [Q_KEY_CODE_F21] = 0x5e,
> +    [Q_KEY_CODE_F22] = 0x5f,
> +    [Q_KEY_CODE_F23] = 0x60,
> +    [Q_KEY_CODE_F24] = 0x61,

You've got a gap there F13, F14, F15 were all missing (pre-existing bug in
QEMU), so you can't carry on just incrementing after F12.

Even if that were not the case, AT set1 scancodes are insane with no logical
numbering scheme. So what we actually end up needing is

    F13 ==  0x5d
    F14 ==  0x5e
    F15 ==  0x5f
    F16 ==  0x55
    F17 ==  0x83
    F18 ==  0xf7
    F19 ==  0x84
    F20 ==  0x5a
    F21 ==  0x74
    F22 ==  0xf9
    F23 ==  0x6d
    F24 ==  0x6f



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
