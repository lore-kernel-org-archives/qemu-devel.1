Received: from eggs.gnu.org ([2001:4830:134:3::10]:45848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ciQvi-0001aq-G1
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:25:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ciQvh-0006EX-Ga
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 14:25:54 -0500
References: <1487623279-29930-1-git-send-email-hpoussin@reactos.org>
	<d30feb73-cbfd-561c-9ee1-555b6809ca6e@reactos.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <06b73003-0e57-4ba0-d54c-d93604397770@redhat.com>
Date: Mon, 27 Feb 2017 14:25:46 -0500
MIME-Version: 1.0
In-Reply-To: <d30feb73-cbfd-561c-9ee1-555b6809ca6e@reactos.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] vl: disable default cdrom when using
 explicitely scsi-hd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org



On 02/27/2017 01:45 PM, Herv=C3=A9 Poussineau wrote:
> Ping?
>=20
> Le 20/02/2017 =C3=A0 21:41, Herv=C3=A9 Poussineau a =C3=A9crit :
>> In commit af6bf1328ef90fae617857c02697e0174b84d596 (May 2011),
>> ide-hd, ide-cd and scsi-cd have been added to disable default cdrom,
>> "or else you can't put one on secondary master without -nodefaults".
>>
>> Make it the same for scsi-hd, so you can put one on scsi-id 2 without
>> using -nodefaults.
>> scsi-hd has probably been forgotten, as it has been added in the
>> preceding commit (b443ae67130d32ad06b06fc9aa6d04d05ccd93ce).
>>
>> Affected users are the ones using a machine with SCSI devices and
>> start QEMU
>> with -device scsi-hd but without -device scsi-cd or -cdrom
>> In that case, the default cdrom device will disappear instead of being
>> empty.
>>
>> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>> ---
>>  vl.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/vl.c b/vl.c
>> index 27d9829..4af95b3 100644
>> --- a/vl.c
>> +++ b/vl.c
>> @@ -226,6 +226,7 @@ static struct {
>>      { .driver =3D "ide-hd",               .flag =3D &default_cdrom   =
  },
>>      { .driver =3D "ide-drive",            .flag =3D &default_cdrom   =
  },
>>      { .driver =3D "scsi-cd",              .flag =3D &default_cdrom   =
  },
>> +    { .driver =3D "scsi-hd",              .flag =3D &default_cdrom   =
  },
>>      { .driver =3D "virtio-serial-pci",    .flag =3D &default_virtcon =
  },
>>      { .driver =3D "virtio-serial",        .flag =3D &default_virtcon =
  },
>>      { .driver =3D "VGA",                  .flag =3D &default_vga     =
  },
>>
>=20
>=20

ACK

Paolo, for you?

--js
