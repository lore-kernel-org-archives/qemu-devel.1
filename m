Received: from eggs.gnu.org ([209.51.188.92]:40021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDQXx-0002C5-0m
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:26:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDQJj-0007Ow-UR
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:11:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hDQJj-0007OZ-LX
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 05:11:51 -0400
References: <20190405123928.70da87e2.olaf@aepfle.de>
	<1cec1873-9962-f258-a052-167efec620e9@redhat.com>
	<20190405125918.462c6ae4.olaf@aepfle.de>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <9a4ea235-29ce-2a98-a723-0a61be55433f@redhat.com>
Date: Mon, 8 Apr 2019 11:04:09 +0200
MIME-Version: 1.0
In-Reply-To: <20190405125918.462c6ae4.olaf@aepfle.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On 04/05/19 12:59, Olaf Hering wrote:
> Am Fri, 5 Apr 2019 12:49:15 +0200
> schrieb Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>:
>=20
>> The EDK2 submodule was added for UEFI testing, you don't need to compi=
le
>> it to build/use QEMU.
>>
>> How did you end up compiling it?
>=20
> The qemu.spec file has this since a very long time:
> make -C roms efirom ${unrelated_settings}
>=20
> This used to work still in January with c9d18c1c150c84e7a976df989ad04dd=
f01083f46.

This is not a QEMU build failure, but an issue in the downstream
packaging that not only tries to build QEMU, but performs a maintainer
build on binary artifacts.

I responded in more detail under Phil's thread

[PATCH for-4.0 v2 0/2] roms: Rename the EFIROM variable and let it be
overridable

Thanks
Laszlo
