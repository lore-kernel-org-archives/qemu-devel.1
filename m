Received: from eggs.gnu.org ([209.51.188.92]:38134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <voltagex@voltagex.org>) id 1gnydM-0001ei-9d
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 23:34:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <voltagex@voltagex.org>) id 1gnydL-0008Rt-3i
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 23:34:56 -0500
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b]:32783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <voltagex@voltagex.org>)
	id 1gnydJ-0008PB-0D
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 23:34:54 -0500
Received: by mail-vk1-xa2b.google.com with SMTP id d201so3393795vka.0
	for <qemu-devel@nongnu.org>; Sun, 27 Jan 2019 20:34:52 -0800 (PST)
MIME-Version: 1.0
From: Adam Baxter <voltagex@voltagex.org>
Date: Mon, 28 Jan 2019 15:34:38 +1100
Message-ID: <CAChFQ9RDi+VK_EERZsPB6UK_DpL-LDs97A6VivYSbuk=0VKP7A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] Building nsis installer - cross compile for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I'm getting stuck trying to build the NSIS installer for Windows


export CFLAGS="-Wno-stringop-truncation"
./configure --python=$(command -v python3)
--cross-prefix=x86_64-w64-mingw32- --enable-docs
echo 3.99.99 > VERSION
make -j`nproc`
make -j`nproc` installer

results in:

make[1]: Leaving directory '/drone/src'
(cd /tmp/qemu-nsis; \
         for i in qemu-system-*.exe; do \
           arch=${i%.exe}; \
           arch=${arch#qemu-system-}; \
           echo Section \"$arch\" Section_$arch; \
           echo SetOutPath \"\$INSTDIR\"; \
           echo File \"\${BINDIR}\\$i\"; \
           echo SectionEnd; \
         done \
        ) >/tmp/qemu-nsis/system-emulations.nsh
makensis -V2 -NOCD \
                -DCONFIG_DOCUMENTATION="y" \
                 \
                -DBINDIR="/tmp/qemu-nsis" \
                 \
                -DSRCDIR="/drone/src" \
                -DOUTFILE="qemu-setup-3.99.99.exe" \
                -DDISPLAYVERSION="3.99.99" \
                /drone/src/qemu.nsi
File: "/tmp/qemu-nsis\*.bmp" -> no files found.
Usage: File [/nonfatal] [/a] ([/r] [/x filespec [...]] filespec [...] |
   /oname=outfile one_file_only)
Error in script "/drone/src/qemu.nsi" on line 122 -- aborting creation process
make: *** [Makefile:915: qemu-setup-3.99.99.exe] Error 1

Any ideas?

Platform is Fedora / mingw x86_64-w64-mingw32 in a Docker container.

Thanks,
Adam
