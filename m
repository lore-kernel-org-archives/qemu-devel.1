Received: from eggs.gnu.org ([2001:4830:134:3::10]:42977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cX7V2-0002nb-Av
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:27:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cX7Uw-0001NT-6n
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:27:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cX7Uw-0001NJ-18
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 09:27:30 -0500
References: <cover.1484165352.git.atar4qemu@gmail.com>
	<662c7a5b81926a9daba26c943b0c11e99068c867.1484165352.git.atar4qemu@gmail.com>
	<87bmuumfxp.fsf@dusky.pond.sub.org>
	<CACXAS8CFZzU1-PQenvAX2iSnDoWOo62Zb7mNPJSeJJnzNmyXVQ@mail.gmail.com>
	<8737g4k36w.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <95f20307-f7c0-e88f-67c8-45d3f22af588@redhat.com>
Date: Fri, 27 Jan 2017 15:27:26 +0100
MIME-Version: 1.0
In-Reply-To: <8737g4k36w.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 30/30] target-sparc: fix up niagara
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>



On 27/01/2017 15:06, Markus Armbruster wrote:
>> Is rom_add_file_fixed supposed to mark the memory region read-only? Or
>> should it be created read-only before calling rom_add_file_fixed?
> I'm not familiar with the memory API, but the fact that you're getting
> RW suggests that you need to mark read-only yourself.  Suggest to
> examine similar code elsewhere for additional clues.
>=20
>>> The monkey-patching of dinfo->is_default is to silence the "Orphaned
>>> drive without device" warning.  Naughty.
>>>
>>> This use of -drive if=3Dpflash is highly unorthodox.  To suggest bett=
er
>>> ways, we need to understand the role of "the virtual ramdisk".  Can y=
ou
>>> explain?  How does it work on a physical system?
>> AFAIK except for simulators it's only used on FPGA boards. It's what
>> the comment says: a kind of initrd, but it resides outside of the
>> partition RAM. So, it is a RAM region pre-filled with data in the way
>> not visible to the guest.
>>
>> I would have used an -initrd option instead of -pflash, but it
>> required a -kernel option, and there is no sensible way to use the
>> -kernel with Solaris.
>> If QEMU had something like a nvram-disk - it would have worked here th=
e best.
>
> Have you considered pressing -bios into service?  -option-rom?  -object
> memory-backend-file?  Paolo, any recommendations?

Yeah, I think -bios is closest.  By the way, where do I get all the .rom
files for the Niagara board?  "make check" complains about them.

Paolo
