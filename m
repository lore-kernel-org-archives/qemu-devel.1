Received: from eggs.gnu.org ([2001:4830:134:3::10]:57407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fiNaF-0006Nj-Gv
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 13:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fiNaC-0004t2-HB
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 13:28:19 -0400
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:41900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fiNaC-0004ro-83
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 13:28:16 -0400
Received: by mail-oi0-x234.google.com with SMTP id k12-v6so15278359oiw.8
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 10:28:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <153253867764.12274.1892143119027483590.malone@gac.canonical.com>
References: <152880770129.26761.1762643804065210181.malonedeb@gac.canonical.com>
	<153253867764.12274.1892143119027483590.malone@gac.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Jul 2018 18:27:55 +0100
Message-ID: <CAFEAcA8RosX691BsqQKr+GNWVtCtKmygj+UjRbNbHSak3BUSdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Bug 1776478] Re: Getting qemu: uncaught target
 signal 6 when running lv2 plugin cross-compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1776478 <1776478@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 25 July 2018 at 18:11, guysoft <guysoft@gmail.com> wrote:
> target: No such file or directory.
> /tmp/mount/remote: No such file or directory.
> (gdb) file DISTRHO-Ports/libs/lv2_ttl_generator
> Reading symbols from DISTRHO-Ports/libs/lv2_ttl_generator...(no debugging symbols found)...done.
> (gdb) file DISTRHO-Ports/bin/lv2/TAL-Filter-2.lv2/TAL-Filter-2.so
> Reading symbols from DISTRHO-Ports/bin/lv2/TAL-Filter-2.lv2/TAL-Filter-2.so...(no debugging symbols found)...done.

These files seem to have no debug symbols. Compiling them
with debug might help (or might not).

thanks
-- PMM
