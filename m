Received: from eggs.gnu.org ([2001:4830:134:3::10]:61000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAc1K-0007cC-Ma
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eAc1G-0001Os-Mm
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:28:26 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:46908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eAc1G-0001OT-FQ
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 09:28:22 -0400
Received: by mail-wm0-x232.google.com with SMTP id r68so1542101wmr.1
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 06:28:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1509715357.5662.1.camel@redhat.com>
References: <1509697171.31823.9.camel@redhat.com>
	<CAFEAcA8LWHP-yWZxSQmnL_U2f_RAk-_ZfSERF8U48zqRE+bq0Q@mail.gmail.com>
	<1509715357.5662.1.camel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Nov 2017 13:28:00 +0000
Message-ID: <CAFEAcA-0d1hEz-O1Q9cCGYAJfcc-rFAg2hNA3Wwq5LzBx1PD9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] capstone broke mingw cross build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 3 November 2017 at 13:22, Gerd Hoffmann <kraxel@redhat.com> wrote:
>> Works for me for the crossbuild I do with mingw64, so I wonder
>> what's different about your setup?
>
> It's RHEL-7, with the mingw packages from epel.
>
> For some reason just using x86_64-w64-mingw32-ar seems to not be
> enough.  When running "x86_64-w64-mingw32-ranlib capstone/capstone.lib"
> (as suggested by the error msg) manually, then kick "make" again the
> build finishes successfully.
>
> "x86_64-w64-mingw32-ar --version" says "GNU ar (GNU Binutils) 2.25"

Hmm, I guess this 'ar' isn't capable of avoiding the requirement for
ranlib. The capstone makefiles look like they have support for
running ranlib, though...

Probably unrelatedly, when you build on OSX ranlib complains a lot:
  AR      libcapstone.a
ar: creating archive /Users/pm215/src/qemu/build/x86/capstone/libcapstone.a
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib:
file: /Users/pm215/src/qemu/build/x86/capstone/libcapstone.a(MipsDisassembler.o)
has no symbols
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib:
file: /Users/pm215/src/qemu/build/x86/capstone/libcapstone.a(MipsInstPrinter.o)
has no symbols
[etc etc etc for 40 or 50 files]
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib:
file: /Users/pm215/src/qemu/build/x86/capstone/libcapstone.a(XCoreModule.o)
has no symbols


thanks
-- PMM
