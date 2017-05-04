Received: from eggs.gnu.org ([2001:4830:134:3::10]:56921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6HKQ-0001U9-Ri
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:01:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1d6HKN-00081V-Ug
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:01:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1d6HKN-000814-PE
	for qemu-devel@nongnu.org; Thu, 04 May 2017 10:01:55 -0400
Message-ID: <1493906512.371.19.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 04 May 2017 16:01:52 +0200
In-Reply-To: <1493894491-26130-1-git-send-email-vip-ak47@yandex.ru>
References: <1493894491-26130-1-git-send-email-vip-ak47@yandex.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] Video and sound capture to a videofile
 through ffmpeg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex K <vip-ak47@yandex.ru>
Cc: qemu-devel@nongnu.org, aliguori@amazon.com

On Do, 2017-05-04 at 13:41 +0300, Alex K wrote:
> Hello everyone,
>=20
> I've made a patch that adds ability to record video of what's going on
> inside qemu. It uses ffmpeg libraries. Basically, the patch adds
> 2 new commands to the console:
> capture_start path framerate
> capture_stop
>=20
> path is required
> framerate could be 24, 25, 30 or 60. Default is 60
> video codec is always h264
>=20
> The patch uses ffmpeg so you will need to install these packages:
> ffmpeg libavformat-dev libavcodec-dev libavutil-dev libswscale-dev
>=20
> This is my first time posting here, so please correct me if I'm doing
> something wrong

First, as others already mentioned, it would be better to do this
outside qemu, as vnc or spice client.  spice is probably the better
choice as spice supports passing the guest display as dma-buf, which
saves the encode-as-spice and decode-spice steps.  And the dma-bufs can
be passed to a hardware encoder.

Second, this must be a compile time option.  Breaking the build in case
ffmpeg is not installed isn't an option.

Third, supporting H.264 only is a non-starter too.  Due to the patent
situation you can't expect distros shipping ffmpeg with H.264 support
enabled.

cheers,
  Gerd
