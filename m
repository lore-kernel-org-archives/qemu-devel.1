Received: from eggs.gnu.org ([2001:4830:134:3::10]:45796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYU2I-0001N8-Av
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYU2H-0006hO-7Y
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:15:50 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:38696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYU2G-0006h6-SO
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:15:49 -0400
Received: by mail-wm0-x232.google.com with SMTP id w191so8622900wmw.1
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 02:15:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170721041053.GQ11032@lemon>
References: <CAB3eZfs8E0xsBAFH_4U=M4LsVpRs73aPdFk5qy_ZUKqMom9P8g@mail.gmail.com>
	<20170721041053.GQ11032@lemon>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Jul 2017 10:15:27 +0100
Message-ID: <CAFEAcA-bDWpXsn9HyaLSX_Kqa7+5-6icks-zu4jZ0a0M4h41FQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] unrecognized option --object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?B?6Zmz5Z+55rOT?= <pahome.chen@mirlab.org>, QEMU Developers <qemu-devel@nongnu.org>

On 21 July 2017 at 05:10, Fam Zheng <famz@redhat.com> wrote:
> On Thu, 07/20 19:06, =E9=99=B3=E5=9F=B9=E6=B3=93 wrote:
>> I build qemu from the https://github.com/qemu/qemu, and it didn't show a=
ny
>> errors.
>>
>> I tried qemu-nbd --object secret,id=3Dsec0...
>> but it shows unrecognized option '--object '
>>
>> how to solve it?
>
> -object it is. Thanks.

Hmm? For me the help message says '--object' and the implementation
agrees that it wants two hyphens:

$ ./build/x86/qemu-nbd -object foo
Invalid offset `bject'
[ie interpreting it as -o plus an argument]
$ ./build/x86/qemu-nbd --object foo
Invalid number of arguments
Try `./build/x86/qemu-nbd --help' for more information.
[ie it recognized the option]

My guesses for why the original poster is getting
'unrecognized option' are either:
 (1) if the error message really has a space after
"t" and before the closing "'" then they're probably invoking
qemu-nbd via a script whose quoting is wrong and is passing
the literal string "--object " with a trailing space by mistake
 (2) otherwise, accidentally running the system qemu-nbd
(which is presumably an old version without this option)
rather than the one they've just built from git ?

thanks
-- PMM
