Received: from eggs.gnu.org ([2001:4830:134:3::10]:35170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d63iN-0000Uw-IH
	for qemu-devel@nongnu.org; Wed, 03 May 2017 19:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d63iI-0004Bf-G1
	for qemu-devel@nongnu.org; Wed, 03 May 2017 19:29:47 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d63iI-0004BR-Bx
	for qemu-devel@nongnu.org; Wed, 03 May 2017 19:29:42 -0400
Received: by mail-qk0-x241.google.com with SMTP id k74so507428qke.2
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 16:29:42 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170503223846.6559-1-marcandre.lureau@redhat.com>
	<20170503223846.6559-4-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <59856f47-a684-0801-c741-5fdb4a4c1ed2@amsat.org>
Date: Wed, 3 May 2017 20:29:38 -0300
MIME-Version: 1.0
In-Reply-To: <20170503223846.6559-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 3/5] audio: fix WAVState leak
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

On 05/03/2017 07:38 PM, Marc-André Lureau wrote:
> Spotted by ASAN.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  audio/wavcapture.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/audio/wavcapture.c b/audio/wavcapture.c
> index 8bfb9e7654..5863803584 100644
> --- a/audio/wavcapture.c
> +++ b/audio/wavcapture.c
> @@ -88,6 +88,7 @@ static void wav_capture_destroy (void *opaque)
>      WAVState *wav = opaque;
>
>      AUD_del_capture (wav->cap, wav);
> +    g_free (wav);
>  }
>
>  static void wav_capture_info (void *opaque)
>
