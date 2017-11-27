Received: from eggs.gnu.org ([2001:4830:134:3::10]:34653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1eJJq4-0002rh-LH
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 08:52:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1eJJq1-00083y-IQ
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 08:52:48 -0500
Received: from speedy.comstyle.com ([2001:470:1d:8c::2]:39522
	helo=mail.comstyle.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brad@comstyle.com>) id 1eJJq1-00082w-Bi
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 08:52:45 -0500
References: <20171126211356.GA46174@humpty.home.comstyle.com>
	<CAFEAcA_m0KMfsUYWpdg2LL2y5U88d4-LoXZuUXkGUxtGCgD66g@mail.gmail.com>
From: Brad Smith <brad@comstyle.com>
Message-ID: <e247c73f-7390-1ce8-14d5-5aba2f1b36f8@comstyle.com>
Date: Mon, 27 Nov 2017 08:52:43 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_m0KMfsUYWpdg2LL2y5U88d4-LoXZuUXkGUxtGCgD66g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] configure: Fix curses probe for older
 ncurses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 11/27/2017 7:02 AM, Peter Maydell wrote:

> On 26 November 2017 at 22:13, Brad Smith <brad@comstyle.com> wrote:
>> Fix the curses probe with older ncurses (.e.g. 5.7, as used by OpenBSD=
).
>>
>> ncurses 5.7 requires _XOPEN_SOURCE_EXTENDED to be defined for WACS_* c=
onstants.
> ncurses 5.7 was released in 2008 and is now 9 years old. Why
> is OpenBSD still using such an ancient version?

Someone has to put the time and effort into updating it.

revision 1.61
date: 2010/09/06 17:26:17;=C2=A0 author: nicm;=C2=A0 state: Exp;=C2=A0 li=
nes: +257 -5;
Enable wide character support in ncurses. It is built into libcurses,
libform, libmenu, libpanel and each library is also linked to a
corresponding "w" version.

This is a major bump for all four libraries.

Thanks to landry, stsp, sthen, naddy, oga, Martin Pieuchot, and anyone
else I've forgotten for testing.

ok naddy krw deraadt
----------------------------
revision 1.60
date: 2010/01/12 23:21:59;=C2=A0 author: nicm;=C2=A0 state: Exp;=C2=A0 li=
nes: +768 -638;
Update to ncurses 5.7, with local changes reapplied.

This is around eight years worth of changes (previously we were around=20
ncurses
5.2), too many to list - many bug fixes and also a few new functions.

A major bump for libcurses, libpanel, libform and libmenu.

ok deraadt
----------------------------
revision 1.59
date: 2001/02/28 22:58:53;=C2=A0 author: millert;=C2=A0 state: Exp;=C2=A0=
 lines: +2 -2;
ncurses-5.2-20010224
----------------------------
revision 1.58
date: 2001/02/22 04:16:34;=C2=A0 author: millert;=C2=A0 state: Exp;=C2=A0=
 lines: +2 -2;
Update to ncurses-5.2-20010210:
o remove macro callPutChar() from tty_update.c, since this is no longer
 =C2=A0 needed (reported by Philippe Blain).
o add a null-pointer check in tic.c to handle the case when the input
 =C2=A0 file is really empty.=C2=A0 Modify the next_char() function in co=
mp_scan.c
 =C2=A0 to allow arbitrarily long lines, and incidentally supply a newlin=
e to
 =C2=A0 files that do not end in a newline.=C2=A0 These changes improve t=
ic's
 =C2=A0 recovery from attempts to read binary files, e.g., its output fro=
m
 =C2=A0 the terminfo database (reported by Bernhard Rosenkraenzer).
o revert change to c++/demo.cc from 20001209, which changed definition
 =C2=A0 of main() apparently to accommodate cygwin linker, but broke the =
demo
 =C2=A0 program.
----------------------------
revision 1.57
date: 2001/01/22 18:01:33;=C2=A0 author: millert;=C2=A0 state: Exp;=C2=A0=
 lines: +497 -484;
Update to ncurses-5.2-20010114
----------------------------
revision 1.56
date: 2000/12/06 17:18:49;=C2=A0 author: deraadt;=C2=A0 state: Exp;=C2=A0=
 lines: +3 -3;
use __x__ formats for __attribute__ arguments; guenther@gac.edu
----------------------------
revision 1.55
date: 2000/10/22 18:27:19;=C2=A0 author: millert;=C2=A0 state: Exp;=C2=A0=
 lines: +4 -4;
update to ncurses 5.2

>> Signed-off-by: Brad Smith <brad@comstyle.com>
>>
>>
>> diff --git a/configure b/configure
>> index 0c6e7572db..9715b9c2cc 100755
>> --- a/configure
>> +++ b/configure
>> @@ -3186,7 +3186,7 @@ EOF
>>     IFS=3D:
>>     for curses_inc in $curses_inc_list; do
>>       # Make sure we get the wide character prototypes
>> -    curses_inc=3D"-DNCURSES_WIDECHAR $curses_inc"
>> +    curses_inc=3D"-DNCURSES_WIDECHAR -D_XOPEN_SOURCE_EXTENDED $curses=
_inc"
> I'm a bit wary of this because we've found in the past that
> defining _XOPEN_* defines breaks compilation with some
> C libraries which assume that if you define _XOPEN_whatever
> it means "only that X/Open stuff and no OS-specific extras",
> and we depend on the OS-specific extras.
>
> That said, I did a test compile on OSX, which was the
> one that had trouble previously, so this may be OK. I think
> I'd rather leave it until after 2.11 releases, though.
>
> thanks
> -- PMM

The other option I was looking at was removing the add_wch() function
call from the probe as the rest of the curses code within QEMU compiles
Ok without _XOPEN_SOURCE_EXTENDED.
