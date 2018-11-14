Received: from eggs.gnu.org ([2001:4830:134:3::10]:44564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMy3D-0000JE-J9
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:30:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gMy3C-00070l-No
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:29:59 -0500
References: <20181114132931.22624-1-marcandre.lureau@redhat.com>
	<16b78816-f2cc-a1e5-0d21-906fc2dbaa3d@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a2d9a2fd-2c1a-66e3-86ba-17da9f564e79@redhat.com>
Date: Wed, 14 Nov 2018 17:29:42 +0100
MIME-Version: 1.0
In-Reply-To: <16b78816-f2cc-a1e5-0d21-906fc2dbaa3d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vmstate: constify VMStateField
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Cornelia Huck <cohuck@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, dgilbert@redhat.com, quintela@redhat.com, "open list:S390" <qemu-s390x@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:PowerPC" <qemu-ppc@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Stafford Horne <shorne@gmail.com>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

On 2018-11-14 16:32, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Marc-Andr=C3=A9,
>=20
> On 14/11/18 14:29, Marc-Andr=C3=A9 Lureau wrote:
>> Because they are supposed to remain const.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>> =C2=A0 include/migration/vmstate.h |=C2=A0=C2=A0 6 +-
>> =C2=A0 hw/display/virtio-gpu.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4=
 +-
>> =C2=A0 hw/intc/s390_flic_kvm.c=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4=
 +-
>> =C2=A0 hw/nvram/eeprom93xx.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 6 +-
>> =C2=A0 hw/nvram/fw_cfg.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +-
>> =C2=A0 hw/pci/msix.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
>> =C2=A0 hw/pci/pci.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +--
>> =C2=A0 hw/pci/shpc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 ++-
>> =C2=A0 hw/scsi/scsi-bus.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 4 +-
>> =C2=A0 hw/timer/twl92230.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 4 +-
>> =C2=A0 hw/usb/redirect.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 12 ++--
>> =C2=A0 hw/virtio/virtio.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 8 +--
>> =C2=A0 migration/savevm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 7 ++-
>> =C2=A0 migration/vmstate-types.c=C2=A0=C2=A0 | 119 +++++++++++++++++++=
+----------------
>> =C2=A0 migration/vmstate.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 31 +++++-----
>> =C2=A0 target/alpha/machine.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 5 +-
>> =C2=A0 target/arm/machine.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 12 ++--
>> =C2=A0 target/hppa/machine.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 10 +--
>> =C2=A0 target/mips/machine.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 14 +++--
>> =C2=A0 target/openrisc/machine.c=C2=A0=C2=A0 |=C2=A0=C2=A0 5 +-
>> =C2=A0 target/ppc/machine.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 14 +++--
>> =C2=A0 target/sparc/machine.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 7 ++-
>> =C2=A0 22 files changed, 162 insertions(+), 135 deletions(-)
>>
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index 2b501d0466..61bef3ef5c 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -40,8 +40,8 @@ typedef struct VMStateField VMStateField;
>=20
> What about enforcing the constness in the typedef?
>=20
> -- >8 --
> @@ -32 +32 @@ typedef struct VMStateDescription VMStateDescription;
> -typedef struct VMStateField VMStateField;
> +typedef const struct VMStateField VMStateField;
> ---

Please don't. For rationale, see:
https://www.kernel.org/doc/html/v4.19/process/coding-style.html#typedefs

 Thomas
