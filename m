Received: from eggs.gnu.org ([2001:4830:134:3::10]:33913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d63bp-00076r-8s
	for qemu-devel@nongnu.org; Wed, 03 May 2017 19:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d63bk-0000aC-As
	for qemu-devel@nongnu.org; Wed, 03 May 2017 19:23:01 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:36539)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d63bk-0000Zo-6X
	for qemu-devel@nongnu.org; Wed, 03 May 2017 19:22:56 -0400
Received: by mail-qk0-x243.google.com with SMTP id o4so663080qkb.3
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 16:22:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170503223846.6559-1-marcandre.lureau@redhat.com>
	<20170503223846.6559-3-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <db56ebe4-597a-8f9e-35a1-4ed0ca06678b@amsat.org>
Date: Wed, 3 May 2017 20:22:52 -0300
MIME-Version: 1.0
In-Reply-To: <20170503223846.6559-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 2/5] audio: fix capture buffer leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Gerd already sent this one few days ago ;)

http://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg05587.html

On 05/03/2017 07:38 PM, Marc-André Lureau wrote:
> Spotted by ASAN.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  audio/audio.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/audio/audio.c b/audio/audio.c
> index c8898d8422..beafed209b 100644
> --- a/audio/audio.c
> +++ b/audio/audio.c
> @@ -2028,6 +2028,8 @@ void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque)
>                      sw = sw1;
>                  }
>                  QLIST_REMOVE (cap, entries);
> +                g_free (cap->hw.mix_buf);
> +                g_free (cap->buf);
>                  g_free (cap);
>              }
>              return;
>
