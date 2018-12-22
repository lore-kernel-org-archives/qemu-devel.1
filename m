Received: from eggs.gnu.org ([2001:4830:134:3::10]:46888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yaroslav.isakov@gmail.com>) id 1gakQE-00008l-38
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 11:46:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yaroslav.isakov@gmail.com>) id 1gakQD-0006Tg-Db
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 11:46:42 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41608)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yaroslav.isakov@gmail.com>)
	id 1gakQD-0006ST-71
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 11:46:41 -0500
Received: by mail-wr1-x443.google.com with SMTP id x10so8105620wrs.8
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 08:46:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1545426882.git.yaroslav.isakov@gmail.com>
In-Reply-To: <cover.1545426882.git.yaroslav.isakov@gmail.com>
From: Yaroslav Isakov <yaroslav.isakov@gmail.com>
Date: Sat, 22 Dec 2018 17:46:28 +0100
Message-ID: <CADS+iDVkG9JVONLqZZ-vHy8ek0sp+D_ctJ+mbnrTAzLfX8jPOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] Allow hw/audio drivers to pass raw DB
 values to audio/ drivers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

Sorry for a mess, forgot to add maintainer. Gerd, please, take a look
at these patches.

=D0=BF=D1=82, 21 =D0=B4=D0=B5=D0=BA. 2018 =D0=B3. =D0=B2 22:40, Yaroslav Is=
akov <yaroslav.isakov@gmail.com>:
>
> This patch series introduces the ability for virtual audio drivers to pas=
s
> information about guest-chosen DB values to backend audio drivers.
>
> For now, supported virtual driver is hda-codec, and backend is pulseaudio=
, as
> they both support DB values.
>
> Without these patches, emulated Windows has a very short range of hearabl=
e
> sound, as range in the guest is much smaller than in Pulseaudio.
>
> Yaroslav Isakov (3):
>   Allow audio driver to pass DB value to underlying drivers
>   Pass raw DB values from hda-codec.c to audio driver
>   If raw DB values are known, use them in paaudio
>
>  audio/audio.c               | 15 +++++++++++++--
>  audio/audio.h               |  6 ++++--
>  audio/mixeng.h              |  6 ++++--
>  audio/paaudio.c             |  9 +++++++--
>  hw/audio/ac97.c             |  4 ++--
>  hw/audio/hda-codec-common.h |  2 +-
>  hw/audio/hda-codec.c        | 12 ++++++++++--
>  hw/audio/lm4549.c           |  2 +-
>  hw/audio/wm8750.c           | 18 ++++++++++++------
>  hw/display/xlnx_dp.c        |  3 ++-
>  hw/usb/dev-audio.c          |  6 ++++--
>  11 files changed, 60 insertions(+), 23 deletions(-)
>
> --
> 2.18.1
>
