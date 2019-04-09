Received: from eggs.gnu.org ([209.51.188.92]:48556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hDuhx-0004Jx-5W
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:38:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1hDuhv-0001V3-5L
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:38:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1hDuhs-0001TJ-0q
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 13:38:49 -0400
References: <e5fb5172-983a-c8a0-1d86-8406fe8ff99c@redhat.com>
	<ef6ca1d8-50ac-5239-34eb-be05fad7af69@reactos.org>
	<87o95hjbtu.fsf@dusky.pond.sub.org>
	<cca2f2c2-6916-8db9-ef4c-72cd2a79c9ef@redhat.com>
	<68660807-deb6-f08a-f714-7fa1782c70bf@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6e29bbde-4271-70d2-614b-4c06a4fb079d@redhat.com>
Date: Tue, 9 Apr 2019 13:38:42 -0400
MIME-Version: 1.0
In-Reply-To: <68660807-deb6-f08a-f714-7fa1782c70bf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] How to correctly use more than 2 floppy drives?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Thomas Huth <thuth@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>



On 4/9/19 7:38 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 4/8/19 9:30 PM, John Snow wrote:
>> On 4/8/19 1:38 AM, Markus Armbruster wrote:
>>> Herv=C3=A9 Poussineau <hpoussin@reactos.org> writes:
>>>
>>>> Le 05/04/2019 =C3=A0 12:29, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=
=C2=A0:
>>>>> Hi,
>>>>>
>>>>> I am trying to understand the possible values for the MAX_FD variab=
le
>>>>> used by the floppy controller model (hw/block/fdc.c).
>=20
>> Out of curiosity, why?
>=20
> Cleaning Super I/O chipset I figured some code uses arrays of 2 element=
s
> while other use MAX_FD. If we want to have a build-configurable MAX_FD
> we can't simply replace "2" -> "MAX_FD" to clean the codebase, we need
> to correct various places, and fix migration.
> If we agree that MAX_FD is strictly 2, then we can clean the codebase
> and remove the MAX_FD !=3D 2 cases (point 3/ below).

OK! I just get nervous when people start poking around floppy disks :)

It's "maintained" but really I just keep it on life support. If anyone
were to claim responsibility for it I would happily let them. As you can
guess, floppy disks are not a huge business priority for my employer and
I am not personally passionate about them, so...

I just keep it alive out of kindness and, for a time, support for
loading virtio drivers on Windows XP VMs, which is a use case that Red
Hat doesn't care about too much anymore.

>>
>> I think I'd rather have MAX_FD set to 2 and a cleaner codebase than a
>> half-working implementation for 4.
>>
>> Or, does it actually work with four? I think if Herv=C3=A9 wants to pr=
eserve
>> this feature it should be formalized as a device property and made to
>> work with migration ... or I am content to remove it.
>=20
> I understand Herv=C3=A9 doesn't want to preserve his attempt ("no emula=
ted
> board took advantage of it"), and the work is safe in the git history i=
f
> someone want to restore it (in a way that doesn't break migration).
>=20
> Since we all seems to agree, I prepared a series to remove it and will
> send it soon (although there is no rush).
>=20
> Thanks,
>=20
> Phil.
>=20

Sounds good, thank you!
