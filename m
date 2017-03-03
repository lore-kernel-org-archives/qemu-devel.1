Received: from eggs.gnu.org ([2001:4830:134:3::10]:59801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjq7T-0004uH-AM
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:31:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjq7R-0002lt-5q
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:31:51 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:35694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjq7Q-0002l6-UP
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 11:31:49 -0500
Received: by mail-wm0-x22e.google.com with SMTP id v186so19439346wmd.0
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 08:31:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8WXnBXQ-qNmzRw6yD_tuYLQepmSC0be50s8h=-1r-VQw@mail.gmail.com>
References: <1488320775-9849-1-git-send-email-armbru@redhat.com>
	<CAFEAcA8WXnBXQ-qNmzRw6yD_tuYLQepmSC0be50s8h=-1r-VQw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 16:31:27 +0000
Message-ID: <CAFEAcA8oG+uODONjXpeAWpNxcmWfoxEbK31LksrLUQp5kbupgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/24] block: Command line option -blockdev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 March 2017 at 15:25, Peter Maydell <peter.maydell@linaro.org> wrote:
> make check failures on OSX host:

> May or may not be this pull's fault.

I gave the pull another test, since I've pretty much run out of
other stuff in the queue, but it failed again in the same way,
on both OSX and x86-64 Linux.
So I think there's definitely something up with this pull.

OSX host:
TEST: tests/qom-test... (pid=85614)
  /sparc/qom/SS-4:
Broken pipe
FAIL
GTester: last random seed: R02Sb28294de82a0cf258dc2ca2baf6b18c8
(pid=85617)
  /sparc/qom/LX:
Broken pipe
FAIL
GTester: last random seed: R02S4eb26bbab5c416277b06006ad8156cf1
(pid=85622)
  /sparc/qom/leon3_generic:                                            OK
  /sparc/qom/SS-600MP:                                                 OK
  /sparc/qom/Voyager:                                                  OK
  /sparc/qom/none:                                                     OK
  /sparc/qom/SS-10:
Broken pipe
FAIL
GTester: last random seed: R02S469761818cf79d3e6fa4962320fa77b1
(pid=85639)
  /sparc/qom/SS-20:
Broken pipe
FAIL
GTester: last random seed: R02S3a7473b699bcfb26035fd7c28443bf95
(pid=85644)
  /sparc/qom/SS-5:                                                     OK
  /sparc/qom/SPARCbook:
Broken pipe
FAIL
GTester: last random seed: R02Se07a10fe8e79e45763039203f04c24a1
(pid=85652)
  /sparc/qom/SPARCClassic:
Broken pipe
FAIL
GTester: last random seed: R02S9e34d27b7ec926de3636396718a84757
(pid=85655)
FAIL: tests/qom-test


x86-64 Linux host:

QTEST_QEMU_BINARY=cris-softmmu/qemu-system-cris
QTEST_QEMU_IMG=qemu-img MALLOC_PERTURB_=${MALLOC_PERTURB_:-$((RANDOM %
255 + 1))} gtester -k --verbose -m=quick  tests/qmp-test
tests/device-introspect-test tests/qom-test
TEST: tests/qmp-test... (pid=31974)
  /cris/qmp/protocol:
Broken pipe
FAIL
GTester: last random seed: R02S3574aa418580efa4bcf246970fbc840b
(pid=31979)
FAIL: tests/qmp-test
TEST: tests/device-introspect-test... (pid=31980)
  /cris/device/introspect/list:
Broken pipe
FAIL
GTester: last random seed: R02Sa1d63dd8533875a5d93dd74844a975d6
(pid=31984)
  /cris/device/introspect/none:
Broken pipe
FAIL
GTester: last random seed: R02S356b6ad895fd1c7287d0aca33d282e85
(pid=31988)
  /cris/device/introspect/abstract:
Broken pipe
FAIL
GTester: last random seed: R02Sc21ac5a1763bc530d24534be33594f47
(pid=31992)
  /cris/device/introspect/concrete:
Broken pipe
FAIL
GTester: last random seed: R02Sa794b06429bb8751ef09a03597812a8a
(pid=31998)
  /cris/device/introspect/abstract-interfaces:
Broken pipe
FAIL
GTester: last random seed: R02Scb050561a91791436483fa6e49d517a1
(pid=32002)
FAIL: tests/device-introspect-test
TEST: tests/qom-test... (pid=32003)
Broken pipe
FAIL: tests/qom-test

thanks
-- PMM
