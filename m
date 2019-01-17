Received: from eggs.gnu.org ([209.51.188.92]:51649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gk4GF-0007NE-1M
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:46:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gk4GE-0001IN-9d
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:46:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:18495)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gk4GE-0001Gj-44
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:46:54 -0500
Date: Thu, 17 Jan 2019 10:46:51 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190117094651.6wv67nspdyqm6add@sirius.home.kraxel.org>
References: <cover.1547681517.git.DirtY.iCE.hu@gmail.com>
	<2770bdbdff44ea3ca88ab30378a8eddbd7e2ef52.1547681517.git.DirtY.iCE.hu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2770bdbdff44ea3ca88ab30378a8eddbd7e2ef52.1547681517.git.DirtY.iCE.hu@gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 18/50] audio: audiodev= parameters no
 longer optional when -audiodev present
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>
Cc: qemu-devel@nongnu.org

On Thu, Jan 17, 2019 at 12:36:51AM +0100, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1=
n wrote:
> This means you should probably stop using -soundhw (as it doesn't allow
> you to specify any options) and add the device manually with -device.
> The exception is pcspk, it's currently not possible to manually add it.
> To use it with audiodev, use something like this:
>=20
>     -audiodev id=3Dfoo,... -global isa-pcspk.audiodev=3Dfoo -soundhw pc=
spk
>=20
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.c=
om>
> ---
>  audio/audio.c   |  24 ++--
>  audio/paaudio.c | 304 ++++++++++++++++++++++++++++--------------------

Hmm, the big paaudio chunk looks suspicious ...

cheers,
  Gerd
