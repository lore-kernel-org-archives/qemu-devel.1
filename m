Received: from eggs.gnu.org ([2001:4830:134:3::10]:59862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fVCTb-0006iU-UI
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 04:59:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fVCTb-0004wt-9z
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 04:59:00 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:44537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fVCTb-0004wL-2a
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 04:58:59 -0400
Received: by mail-wr0-x242.google.com with SMTP id x4-v6so19656258wro.11
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 01:58:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180619065448.kf3sguslhbqnczvv@sirius.home.kraxel.org>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
	<20180618161729.334-27-marcandre.lureau@redhat.com>
	<20180619065448.kf3sguslhbqnczvv@sirius.home.kraxel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 19 Jun 2018 10:58:57 +0200
Message-ID: <CAJ+F1CJNuOhWQTibD=iQna=cnCZ71FmZxNDRuBpXsYkfq6HLbA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 26/26] hw/display: add vhost-user-vga &
 gpu-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>

Hi

On Tue, Jun 19, 2018 at 8:54 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>   Hi,
>
>> +    VHOST_USER_GPU_SCANOUT,
>> +    VHOST_USER_GPU_UPDATE,
>> +    VHOST_USER_GPU_DMABUF_SCANOUT,
>> +    VHOST_USER_GPU_DMABUF_UPDATE,
>
> Hmm, still two command versions.
>
> I still think there should be no separate 2d code path.  Just
> put the 2d display updates into a texture, or into a drm buffer,
> then use VHOST_USER_GPU_DMABUF_* for both 2d and 3d updates (see
> also ui/console-gl.c, which does basically the same).

It will use DMABUF for both 2d and 3d, unless it's not capable of
doing it (currently only intel gpu). So the regular scanout/update are
fallback. They share a lot of similarities.


--=20
Marc-Andr=C3=A9 Lureau
