Received: from eggs.gnu.org ([209.51.188.92]:36347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goMmv-0005cn-2Z
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 01:22:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goMms-0000ne-HR
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 01:22:23 -0500
References: <cover.1548714862.git.DirtY.iCE.hu@gmail.com>
	<1d80d5adf4244445d18bfe1170d125a0d311383f.1548714862.git.DirtY.iCE.hu@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f06c0217-7b12-790e-52cc-dde7c0ed5b56@redhat.com>
Date: Tue, 29 Jan 2019 07:22:08 +0100
MIME-Version: 1.0
In-Reply-To: <1d80d5adf4244445d18bfe1170d125a0d311383f.1548714862.git.DirtY.iCE.hu@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 02/14] audio: use qapi AudioFormat
 instead of audfmt_e
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?S8WRdsOhZ8OzLCBab2x0w6Fu?= <dirty.ice.hu@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair@alistair23.me>, Michael Walle <michael@walle.cc>, "open list:ARM" <qemu-arm@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On 2019-01-28 23:43, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n wrote:
> I had to include an enum for audio sampling formats into qapi, but that
> meant duplicating the audfmt_e enum.  This patch replaces audfmt_e and
> associated values with the qapi generated AudioFormat enum.
>=20
> This patch is mostly a search-and-replace, except for switches where th=
e
> qapi generated AUDIO_FORMAT_MAX caused problems.
>=20
> Signed-off-by: K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <DirtY.iCE.hu@gmail.c=
om>
> ---

Reviewed-by: Thomas Huth <thuth@redhat.com>
