Received: from eggs.gnu.org ([2001:4830:134:3::10]:52236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dkr2Y-000668-TI
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dkr2X-0007YM-PQ
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:15:14 -0400
Received: from mail-ua0-x243.google.com ([2607:f8b0:400c:c08::243]:34272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dkr2X-0007Y9-Kj
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 08:15:13 -0400
Received: by mail-ua0-x243.google.com with SMTP id a10so1013550uai.1
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 05:15:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503576178-23966-4-git-send-email-armbru@redhat.com>
References: <1503576178-23966-1-git-send-email-armbru@redhat.com>
	<1503576178-23966-4-git-send-email-armbru@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 24 Aug 2017 14:15:12 +0200
Message-ID: <CAJ+F1CJYqHwZKw-v3QcT0f4_Ow1aUMu-A1ayuEaVLzH-x_RsQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] qapi-schema: Rocker doc section
 contains unrelated stuff, fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

On Thu, Aug 24, 2017 at 2:02 PM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Bug: section "Rocker switch device" starts with the rocker stuff, but
> then has unrelated stuff, like ReplayMode, xen-load-devices-state, ...
>
> Cause: rocker.json is included in the middle of section "QMP commands".
>
> Fix: include it in a sane place, namely next to the other sub-schemas.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>


Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  qapi-schema.json | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 76b5888..81cef23 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -82,6 +82,7 @@
>  { 'include': 'qapi/crypto.json' }
>  { 'include': 'qapi/block.json' }
>  { 'include': 'qapi/event.json' }
> +{ 'include': 'qapi/rocker.json' }
>  { 'include': 'qapi/trace.json' }
>  { 'include': 'qapi/introspect.json' }
>
> @@ -6273,9 +6274,6 @@
>  ##
>  { 'command': 'rtc-reset-reinjection' }
>
> -# Rocker ethernet network switch
> -{ 'include': 'qapi/rocker.json' }
> -
>  ##
>  # @ReplayMode:
>  #
> --
> 2.7.5
>
>



--=20
Marc-Andr=C3=A9 Lureau
