Received: from eggs.gnu.org ([2001:4830:134:3::10]:40010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAA3D-000681-48
	for qemu-devel@nongnu.org; Mon, 15 May 2017 03:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dAA38-0006gm-7A
	for qemu-devel@nongnu.org; Mon, 15 May 2017 03:04:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dAA37-0006gi-U9
	for qemu-devel@nongnu.org; Mon, 15 May 2017 03:04:10 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <0f1f5bcd-815a-c070-5ba7-281f5a0ee146@twiddle.net>
	<20170510235204.9657-1-f4bug@amsat.org>
	<551f0d70-acdf-1a40-6aec-00b1dd40133d@amsat.org>
	<87efvvzrwo.fsf@dusky.pond.sub.org>
	<cc870909-1694-73a3-db66-2d113736c7d6@amsat.org>
Date: Mon, 15 May 2017 09:04:05 +0200
In-Reply-To: <cc870909-1694-73a3-db66-2d113736c7d6@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu,
	11 May 2017 23:01:09 -0300")
Message-ID: <8737c64n4q.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2] coccinelle: add a script to
 optimize tcg op using tcg_gen_extract()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Hi Markus,
>
> On 05/11/2017 06:03 AM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>
>>> Ok I just understood Richard explanation, so this patch is WRONG and I
>>> need to get some real rest :(
>>
>> Ha!  Get some sleep; we'll still be around in the morning ;)
>>
>>> On 05/10/2017 08:52 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> Apply this script using:
>>>>
>>>> $ docker run -v `pwd`:`pwd` -w `pwd` petersenna/coccinelle \
>>>>     --sp-file scripts/coccinelle/tcg_gen_extract.cocci \
>>>>     --macro-file scripts/cocci-macro-file.h \
>>>>     --dir target \
>>>>     --in-place
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>> ---
>>>>
>>>> This is a new version of the coccinelle script addressing Richard comm=
ents and
>>>> trying to do it correctly. Also changed license to GPLv2+.
>>>>
>>>> The first rule matches, it calls a python2 script that basically check=
s the
>>>> target_ulong is not overflowed: (msk << ofs) >> sizeof(target_ulong) =
=3D=3D 0
>>>
>>> WRONG
>> [...]
>>
>> Is this script likely to be rerun in the future?  If yes, keeping it in
>> scripts/coccinelle/ is a good idea.  If no, I recommend to store it in
>> the commit message instead.
>
> It is unlikely to be rerun in the future, at least for this specific
> pattern. But it can be easily adapted for another TCG optimization.
>
> I could not find much documentation about how to do a such script
> using Python, except on a thread [1]. If it is documented enough I
> think it is worth to keep it.
>
> About putting it in each commit message, it is now 3 times bigger than
> the patch it generates!

Consider putting it into the first commit message, and have the others
reference back.
