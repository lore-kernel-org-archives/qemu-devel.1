Received: from eggs.gnu.org ([2001:4830:134:3::10]:58960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8k0s-0004pc-6d
	for qemu-devel@nongnu.org; Thu, 11 May 2017 05:04:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8k0p-0005dq-21
	for qemu-devel@nongnu.org; Thu, 11 May 2017 05:03:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d8k0o-0005da-Rz
	for qemu-devel@nongnu.org; Thu, 11 May 2017 05:03:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <0f1f5bcd-815a-c070-5ba7-281f5a0ee146@twiddle.net>
	<20170510235204.9657-1-f4bug@amsat.org>
	<551f0d70-acdf-1a40-6aec-00b1dd40133d@amsat.org>
Date: Thu, 11 May 2017 11:03:51 +0200
In-Reply-To: <551f0d70-acdf-1a40-6aec-00b1dd40133d@amsat.org> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed,
	10 May 2017 21:13:59 -0300")
Message-ID: <87efvvzrwo.fsf@dusky.pond.sub.org>
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
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Ok I just understood Richard explanation, so this patch is WRONG and I
> need to get some real rest :(

Ha!  Get some sleep; we'll still be around in the morning ;)

> On 05/10/2017 08:52 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Apply this script using:
>>
>> $ docker run -v `pwd`:`pwd` -w `pwd` petersenna/coccinelle \
>>     --sp-file scripts/coccinelle/tcg_gen_extract.cocci \
>>     --macro-file scripts/cocci-macro-file.h \
>>     --dir target \
>>     --in-place
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>
>> This is a new version of the coccinelle script addressing Richard commen=
ts and
>> trying to do it correctly. Also changed license to GPLv2+.
>>
>> The first rule matches, it calls a python2 script that basically checks =
the
>> target_ulong is not overflowed: (msk << ofs) >> sizeof(target_ulong) =3D=
=3D 0
>
> WRONG
[...]

Is this script likely to be rerun in the future?  If yes, keeping it in
scripts/coccinelle/ is a good idea.  If no, I recommend to store it in
the commit message instead.
