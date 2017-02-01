Received: from eggs.gnu.org ([2001:4830:134:3::10]:39467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYuqE-0005wg-0V
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:20:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cYuq9-0006Ta-Uk
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:20:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cYuq9-0006Sl-PB
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 08:20:49 -0500
Message-ID: <1485955246.1076.55.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 01 Feb 2017 14:20:46 +0100
In-Reply-To: <001001d27bbe$2770c3f0$76524bd0$@ru>
References: <20170131115913.6828.12266.stgit@PASHA-ISP>
	<CAJ+F1CKUVDvnyhOT6XR1=bQL8ia9GCUBx=0xotGCBmojtR6XSg@mail.gmail.com>
	<001001d27bbe$2770c3f0$76524bd0$@ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] audio: make audio poll timer deterministic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: =?ISO-8859-1?Q?=27Marc-Andr=E9?= Lureau' <marcandre.lureau@gmail.com>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org, pbonzini@redhat.com

On Di, 2017-01-31 at 15:32 +0300, Pavel Dovgalyuk wrote:
> This patch is needed to make this timer deterministic and to use
> execution record/replay
>=20
> for audio devices.
>=20
> =20
>=20
> audio_reset_timer is used in the function
> audio_vm_change_state_handler.
>=20
> Therefore every time VM is stopped or restarted the timer will be
> reset to new timeout.
>=20
> Virtual clock does not proceed while VM is stopped. Therefore there is
> no need
>=20
> in resetting the timeout when VM restarts.

Add that to the commit message please.

cheers,
  Gerd
