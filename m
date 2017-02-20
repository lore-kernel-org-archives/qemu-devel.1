Received: from eggs.gnu.org ([2001:4830:134:3::10]:45724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cfcLZ-0001yz-O7
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 20:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cfcLZ-00046N-1t
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 20:00:57 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1483194856-14079-1-git-send-email-hpoussin@reactos.org>
	<8737gsl7o7.fsf@dusky.pond.sub.org>
	<4b140d8b-0745-6d7f-101f-25c3ca5f28c2@redhat.com>
	<fd8fb30f-4e54-e119-0287-2459fd6c85ca@reactos.org>
Date: Mon, 20 Feb 2017 02:00:46 +0100
In-Reply-To: <fd8fb30f-4e54-e119-0287-2459fd6c85ca@reactos.org>
	(=?utf-8?Q?=22Herv=C3=A9?=
	Poussineau"'s message of "Sat, 18 Feb 2017 18:58:10 +0100")
Message-ID: <87a89hvfpd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
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
To: =?utf-8?Q?Herv=C3=A9?= Poussineau <hpoussin@reactos.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, John Snow <jsnow@redhat.com>, qemu-block@nongnu.org

Herv=C3=A9 Poussineau <hpoussin@reactos.org> writes:

> Hi,
>
> Le 09/01/2017 =C3=A0 14:48, Paolo Bonzini a =C3=A9crit :
>>
>>
>> On 09/01/2017 13:49, Markus Armbruster wrote:
>>> Herv=C3=A9 Poussineau <hpoussin@reactos.org> writes:
>>>
>>>> 'ide-hd', 'ide-cd' and 'scsi-cd' devices already disable default cdrom.
>>>> Make it the same for 'scsi-hd'.
>>>>
>>>> That way, we can add/replace the device on lun=3D2 without using -node=
faults.
>>>
>>> Yes, but it might upset existing usage that relies on the default
>>> CD-ROM.  In my opinion, making your needs explicit is better than
>>> relying on defaults, but that doesn't mean we can change the defaults
>>> unthinkingly.  Definitely not qemu-trivial.
>>>
>>> Opinions on the change?
>>
>> The original rationale for the change was "ide-hd has to suppress the
>> default CD-ROM, or else you can't put one on secondary master without
>> -nodefaults" but the same applies for scsi-hd vs. lun=3D1.
>>
>> So I'm not sure, but I lean towards accepting the patch.
>>
>> Paolo
>
> Paolo, Markus, so what is the conclusion?
> Accepting the patch, or refusing it?

Suggest to repost with the commit message updated to mention the
backwards incompatibility, and why you think it's okay.
cc: John Snow <jsnow@redhat.com>, cc: qemu-block@nongnu.org
