Received: from eggs.gnu.org ([209.51.188.92]:45870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gw9cZ-0003mt-5s
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:55:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gw9cN-0003Is-3n
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:55:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gw9cM-0003I0-Lj
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:55:42 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <B9D713FC-5896-4923-9788-AF7EAA9B462D@oberlin.edu>
	<ab1a67c0-8872-6e22-fc70-946bbcabb8a1@redhat.com>
	<BD5AEBD4-0B91-4756-B8D6-C0E643CF1F42@oberlin.edu>
	<87ftsl2clg.fsf@dusky.pond.sub.org>
	<91720BD9-D5A6-4457-BC99-D2132550BEDA@oberlin.edu>
	<87ef84z4v6.fsf@dusky.pond.sub.org>
	<62E7EC09-CB88-4802-9D28-45B06C020614@oberlin.edu>
	<87imxfssq1.fsf@dusky.pond.sub.org>
	<E3178A67-9CFC-4CD5-921F-4EE5CCB46F62@oberlin.edu>
Date: Tue, 19 Feb 2019 18:55:39 +0100
In-Reply-To: <E3178A67-9CFC-4CD5-921F-4EE5CCB46F62@oberlin.edu> (Stephen
	Checkoway's message of "Tue, 19 Feb 2019 11:00:16 -0500")
Message-ID: <87y36boe78.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Testing sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Cc: Thomas Huth <thuth@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, =?utf-8?B?TMOhc3psw7Mgw4lyc2Vr?= <lersek@redhat.com>

Stephen Checkoway <stephen.checkoway@oberlin.edu> writes:

>> On Feb 19, 2019, at 10:28, Markus Armbruster <armbru@redhat.com> wrote:
>>=20
>> My terminology might be confused...
>>=20
>> Let me backtrack a bit an explain my use case.  On physical PCs, the
>> single flash chip is commonly configured to have a read-only part and a
>> read/write part.  The read-only part holds UEFI code, and the read-write
>> part holds its persistent state.
>>=20
>> Since our virtual flash chips lack this feature, our virtual PCs have
>> *two* of them: one configured read-only, and one configured read/write.
>> Cleaning that up would be nice.
>>=20
>> The comment "It does not implement software data protection as found in
>> many real chips" in both pflash_cfi0*.c might be referring to this
>> missing feature.
>
> I understand now, thank you for explaining. I noticed the comments about =
software data protection in the code, but I didn't investigate.
>
>>From a quick look at <https://www.cypress.com/file/195291/download> Table=
 27 on page 8, I see there are at least 4 different protection modes. I thi=
nk the most common one (based on my reading of a handful of data sheets for=
 flash chips) is the high voltage one. Essentially, there are sector groups=
 that can be locked/unlocked using high voltage. It seems easy enough to mo=
del this by configuring sectors as locked and refusing to erase or program =
them.
>
> Software command locking would probably involve implementing a few additi=
onal commands.
>
> I'm not sure what the others are.
>
> Which locking method do you need?

L=C3=A1szl=C3=B3, Philippe, what would you prefer to work with in OVMF?
