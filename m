Received: from eggs.gnu.org ([2001:4830:134:3::10]:38580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cf9HE-00066f-1e
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 12:58:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1cf9HB-0003G3-0o
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 12:58:32 -0500
References: <1483194856-14079-1-git-send-email-hpoussin@reactos.org>
	<8737gsl7o7.fsf@dusky.pond.sub.org>
	<4b140d8b-0745-6d7f-101f-25c3ca5f28c2@redhat.com>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <fd8fb30f-4e54-e119-0287-2459fd6c85ca@reactos.org>
Date: Sat, 18 Feb 2017 18:58:10 +0100
MIME-Version: 1.0
In-Reply-To: <4b140d8b-0745-6d7f-101f-25c3ca5f28c2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] vl: disable default cdrom when using
 explicitely scsi-hd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>

Hi,

Le 09/01/2017 =C3=A0 14:48, Paolo Bonzini a =C3=A9crit :
>
>
> On 09/01/2017 13:49, Markus Armbruster wrote:
>> Herv=C3=A9 Poussineau <hpoussin@reactos.org> writes:
>>
>>> 'ide-hd', 'ide-cd' and 'scsi-cd' devices already disable default cdro=
m.
>>> Make it the same for 'scsi-hd'.
>>>
>>> That way, we can add/replace the device on lun=3D2 without using -nod=
efaults.
>>
>> Yes, but it might upset existing usage that relies on the default
>> CD-ROM.  In my opinion, making your needs explicit is better than
>> relying on defaults, but that doesn't mean we can change the defaults
>> unthinkingly.  Definitely not qemu-trivial.
>>
>> Opinions on the change?
>
> The original rationale for the change was "ide-hd has to suppress the
> default CD-ROM, or else you can't put one on secondary master without
> -nodefaults" but the same applies for scsi-hd vs. lun=3D1.
>
> So I'm not sure, but I lean towards accepting the patch.
 >
 > Paolo

Paolo, Markus, so what is the conclusion?
Accepting the patch, or refusing it?

Regards,

Herv=C3=A9

>
>>> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>>> ---
>>>  vl.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/vl.c b/vl.c
>>> index d77dd86..da97fe2 100644
>>> --- a/vl.c
>>> +++ b/vl.c
>>> @@ -223,6 +223,7 @@ static struct {
>>>      { .driver =3D "ide-hd",               .flag =3D &default_cdrom  =
   },
>>>      { .driver =3D "ide-drive",            .flag =3D &default_cdrom  =
   },
>>>      { .driver =3D "scsi-cd",              .flag =3D &default_cdrom  =
   },
>>> +    { .driver =3D "scsi-hd",              .flag =3D &default_cdrom  =
   },
>>>      { .driver =3D "virtio-serial-pci",    .flag =3D &default_virtcon=
   },
>>>      { .driver =3D "virtio-serial",        .flag =3D &default_virtcon=
   },
>>>      { .driver =3D "VGA",                  .flag =3D &default_vga    =
   },
>>
>>
>
