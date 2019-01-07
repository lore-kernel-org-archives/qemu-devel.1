Received: from eggs.gnu.org ([209.51.188.92]:38007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggUnS-0007oj-Pd
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 08:18:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ggUnQ-0003a1-Qv
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 08:18:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ggUnO-0003II-SZ
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 08:18:24 -0500
Date: Mon, 7 Jan 2019 14:18:15 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190107131815.xtj3ejwksehcdja7@sirius.home.kraxel.org>
References: <cover.1545426882.git.yaroslav.isakov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1545426882.git.yaroslav.isakov@gmail.com>
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
To: Yaroslav Isakov <yaroslav.isakov@gmail.com>
Cc: qemu-devel@nongnu.org

On Fri, Dec 21, 2018 at 10:14:42PM +0100, Yaroslav Isakov wrote:
> This patch series introduces the ability for virtual audio drivers to pass
> information about guest-chosen DB values to backend audio drivers.
> 
> For now, supported virtual driver is hda-codec, and backend is pulseaudio, as
> they both support DB values.
> 
> Without these patches, emulated Windows has a very short range of hearable
> sound, as range in the guest is much smaller than in Pulseaudio.

It's more useful to add support for converting db values to linear
values, so it'll work properly with all backends not only pulse.

cheers,
  Gerd
