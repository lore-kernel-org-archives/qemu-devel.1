Received: from eggs.gnu.org ([209.51.188.92]:51635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gw2ok-0004bV-8c
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 05:40:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gw2oj-0003io-8v
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 05:40:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1gw2oh-0003gR-Pf
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 05:40:00 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27B5E2F5D
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 10:39:53 +0000 (UTC)
References: <20190219101510.9356-1-kraxel@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a7050f62-b56f-cc1a-7600-5197b83a27ac@redhat.com>
Date: Tue, 19 Feb 2019 11:39:49 +0100
MIME-Version: 1.0
In-Reply-To: <20190219101510.9356-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] audio: don't use alsa by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On 19.02.19 11:15, Gerd Hoffmann wrote:
> ardware is present the driver initializes
> successfully and throws errors later on, i.e. effectively the
> automatic probing doesn't work.  So the driver should not be
> used by default (until that is fixed).  Drop the can_be_default
> flag.
>=20
> Explicitly picking the alsa driver (using QEMU_AUDIO_DRV=3Dalsa
> environment variable) will continue to work.

Just pointing out that with this patch, audio initialization still
hinders me from starting guests on my Fedora 29 when running under root
(I don't think this patch was also intended to fix that, just pointing
out for me the problem still exists).


ALSA lib pulse.c:243:(pulse_connect) PulseAudio: Unable to connect:
Connection refused

sdl: SDL_OpenAudio failed
sdl: Reason: ALSA: Couldn't open audio device: Connection refused
ALSA lib pulse.c:243:(pulse_connect) PulseAudio: Unable to connect:
Connection refused

sdl: SDL_OpenAudio failed
sdl: Reason: ALSA: Couldn't open audio device: Connection refused
audio: Failed to create voice `pcspk'
qemu-system-x86_64: Initialization of device isa-pcspk failed:
Initializing audio voice failed


For whatever reason, on my Fedora29 root cannot access alsa devices.
Maybe it is a Fedora 29 problem, maybe only my setup is messed up (e.g.
because of an upgrade). The workaround for me is to not run QEMU as
root. (I don't have time to look into the details)

--=20

Thanks,

David / dhildenb
