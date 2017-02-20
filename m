Received: from eggs.gnu.org ([2001:4830:134:3::10]:54892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cfu2e-00047x-Te
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:54:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cfu2d-0002KN-V5
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 14:54:36 -0500
References: <1483194856-14079-1-git-send-email-hpoussin@reactos.org>
	<8737gsl7o7.fsf@dusky.pond.sub.org>
	<4b140d8b-0745-6d7f-101f-25c3ca5f28c2@redhat.com>
	<fd8fb30f-4e54-e119-0287-2459fd6c85ca@reactos.org>
	<87a89hvfpd.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <75f7111c-d7b1-e2a1-449f-52c38ef2d07f@redhat.com>
Date: Mon, 20 Feb 2017 14:54:29 -0500
MIME-Version: 1.0
In-Reply-To: <87a89hvfpd.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
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
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-block@nongnu.org



On 02/19/2017 08:00 PM, Markus Armbruster wrote:
> Herv=C3=A9 Poussineau <hpoussin@reactos.org> writes:
>=20
>> Hi,
>>
>> Le 09/01/2017 =C3=A0 14:48, Paolo Bonzini a =C3=A9crit :
>>>
>>>
>>> On 09/01/2017 13:49, Markus Armbruster wrote:
>>>> Herv=C3=A9 Poussineau <hpoussin@reactos.org> writes:
>>>>
>>>>> 'ide-hd', 'ide-cd' and 'scsi-cd' devices already disable default cd=
rom.
>>>>> Make it the same for 'scsi-hd'.
>>>>>
>>>>> That way, we can add/replace the device on lun=3D2 without using -n=
odefaults.
>>>>
>>>> Yes, but it might upset existing usage that relies on the default
>>>> CD-ROM.  In my opinion, making your needs explicit is better than
>>>> relying on defaults, but that doesn't mean we can change the default=
s
>>>> unthinkingly.  Definitely not qemu-trivial.
>>>>
>>>> Opinions on the change?
>>>
>>> The original rationale for the change was "ide-hd has to suppress the
>>> default CD-ROM, or else you can't put one on secondary master without
>>> -nodefaults" but the same applies for scsi-hd vs. lun=3D1.
>>>
>>> So I'm not sure, but I lean towards accepting the patch.
>>>
>>> Paolo
>>
>> Paolo, Markus, so what is the conclusion?
>> Accepting the patch, or refusing it?
>=20
> Suggest to repost with the commit message updated to mention the
> backwards incompatibility, and why you think it's okay.
> cc: John Snow <jsnow@redhat.com>, cc: qemu-block@nongnu.org
>=20

I don't have a lot of history with the SCSI devices, so I'd be pretty
much relying exclusively on a statement on what breaks with the change,
and why that breakage would be justified.

No strong feelings for/against right now and am likely to just defer to
Paolo, who was leaning towards accepting it.

--js
