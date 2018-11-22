Received: from eggs.gnu.org ([2001:4830:134:3::10]:43486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gPkzN-0007vT-GX
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 04:09:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gPkzI-0005Lu-TG
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 04:09:33 -0500
References: <mhng-ce1dc513-eb34-4ace-b3a2-248347025887@palmer-si-x1c4>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1a6f23a1-fba1-578b-38cb-4274177ee7d5@redhat.com>
Date: Thu, 22 Nov 2018 10:09:16 +0100
MIME-Version: 1.0
In-Reply-To: <mhng-ce1dc513-eb34-4ace-b3a2-248347025887@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.1 1/2] MAINTAINERS: Any file with
 "riscv" in the name is a RISC-V file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>, philmd@redhat.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On 2018-11-22 02:44, Palmer Dabbelt wrote:
> On Wed, 21 Nov 2018 16:29:09 PST (-0800), philmd@redhat.com wrote:
>> On 22/11/18 0:46, Palmer Dabbelt wrote:
>>> There was a recent thread about unmaintained files in QEMU where it w=
as
>>> noted that a few RISC-V related files had slipped through the pattern=
s
>>> in our MAINTAINERS file entry.=C2=A0 This patch adds some more aggres=
sive
>>> pattern matching in an attempt to rectify this situation.
>>>
>>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>>> ---
>>> =C2=A0 MAINTAINERS | 2 ++
>>> =C2=A0 1 file changed, 2 insertions(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 1032406c5607..e89adc81d5d5 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -255,6 +255,8 @@ F: target/riscv/
>>> =C2=A0 F: hw/riscv/
>>> =C2=A0 F: include/hw/riscv/
>>> =C2=A0 F: disas/riscv.c
>>> +K: riscv

Please be very careful with the "K:" lines ... you could suddenly end up
being a "maintainer" for files that you did not expect. For example,
after applying your patch, I guess the following commands will tell you
that you're the maintainer of these files:

 script/get_maintainer.pl -f MAINTAINERS
 script/get_maintainer.pl -f qapi/misc.json
 script/get_maintainer.pl -f configure
 ...

For this reason, we've limited the "K:" lines in MAINTAINERS so far to
files that contain the regex "^Subject:", too (so that they only match
patches with the keyword in the subject).

>>> +N: riscv
>>
>> QEMU doesn't support the 'N' tag.
>> I see from the Linux kernel:
>>
>> =C2=A0=C2=A0 N: Files and directories with regex patterns.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 N:=C2=A0=C2=A0 [^a-z]tegra=C2=A0=C2=A0=C2=
=A0=C2=A0 all files whose path contains the word tegra
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 One pattern per line.=C2=A0 Multiple N:=
 lines acceptable.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scripts/get_maintainer.pl has different=
 behavior for files that
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 match F: pattern and matches of N: patt=
erns.=C2=A0 By default,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_maintainer will not look at git log=
 history when an F: pattern
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 match occurs.=C2=A0 When an N: match oc=
curs, git log history is used
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to also notify the people that have git=
 commit signatures.
>>
>> Should we add this feature to checkscript?
>=20
> Ah, I didn't check because I just copied this from our Linux entry.=C2=A0
> It's pretty much the core of what I'm trying to do here so if it's easy
> then that'd be great.
>=20
> Unfortunately I don't know how to do so.

Try to export the commits eb90d0855 and bbbe96ed8 from the Linux kernel
git and see whether the patches can be applied to our version of
get_maintainers.pl, too.

 HTH,
  Thomas
