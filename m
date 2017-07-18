Received: from eggs.gnu.org ([2001:4830:134:3::10]:34793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXIXl-0002pU-4Z
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 22:47:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXIXh-0007wM-72
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 22:47:25 -0400
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:36535)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXIXh-0007w3-2a
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 22:47:21 -0400
Received: by mail-qt0-x231.google.com with SMTP id 21so5943046qtx.3
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 19:47:20 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 17 Jul 2017 23:47:08 -0300
Message-Id: <20170718024713.27557-1-f4bug@amsat.org>
In-Reply-To: <20170717144848.11793-1-alex.bennee@linaro.org>
References: <20170717144848.11793-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2.5 0/5] (more) Updated Travis Queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Sorry I messed previous series... just updated last 5 patches of v2.

v2.5:
- MXE replaced <tab> by <space>s
- docker9/ports: lost package 'clang' re-added
- include patch keep 'debian.docker' base image backward incompatible 

On 07/17/2017 09:31 PM, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> a bit late, but in case you can take some for 2.10:
> 
> v2:
> - cleanup few packages (to improve image caching)
> - dropped mipsEL and keep mipsEB image (32-bit big endian)
> - add mips64EL (64-bit little endian)
> - add mingw32 and mingw64 targets (shared libs, could be static)
> - add debian Ports image [can be dropped, use as base for SH4 for 2.11]
> 
> On 07/17/2017 11:48 AM, Alex Bennée wrote:
>> Hi,
>>
>> This is the current status of the travis/next patch queue. The
>> includes updates from Paolo to allow parallelism while testing in the
>> docker environment. I've extended the travis image so we can actually
>> run our travis.py script in the Travis image.
>>
>> There are also a number of updates from Phillipe which add a bunch of
>> additional cross compile targets to our shippable setup. The cachinfo
>> patch is temporary and won't make the pull as it is already queued in
>> Richard's tcg-next.
>>
>> I'm currently trying to catch one of our Travis hangs in the act
>> (postcopy-test) but it seems to be very much a heavy load race
>> condition which annoyingly stops happening once you try and get
>> debugging tools on it. This is the reason I've updated the travis
>> docker image to include the debug tools;-)
>>
>> As long as there are no screams of outrage I'll roll a pullreq for
>> softfreeze tomorrow.

Philippe Mathieu-Daudé (5):
  docker: add MXE (M cross environment) base image for MinGW-w64
  shippable: add win32/64 targets
  docker: add debian Ports base image
  docker: warn users to use newer debian8/debian9 base image
  docker: install clang since Shippable setup_ve() verify it is
    available

 .shippable.yml                                     |  4 +++
 tests/docker/Makefile.include                      |  4 +++
 tests/docker/dockerfiles/debian-ports.docker       | 35 ++++++++++++++++++++++
 tests/docker/dockerfiles/debian-win32-cross.docker | 32 ++++++++++++++++++++
 tests/docker/dockerfiles/debian-win64-cross.docker | 32 ++++++++++++++++++++
 tests/docker/dockerfiles/debian.docker             | 13 ++++++++
 tests/docker/dockerfiles/debian8-mxe.docker        | 18 +++++++++++
 tests/docker/dockerfiles/debian9.docker            |  1 +
 8 files changed, 139 insertions(+)
 create mode 100644 tests/docker/dockerfiles/debian-ports.docker
 create mode 100644 tests/docker/dockerfiles/debian-win32-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-win64-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian.docker
 create mode 100644 tests/docker/dockerfiles/debian8-mxe.docker

-- 
2.13.2
