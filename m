Received: from eggs.gnu.org ([2001:4830:134:3::10]:54335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpANM-0001cu-0M
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpANH-00013C-69
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:42:32 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpANG-00012x-Vc
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:42:27 -0400
Received: by mail-wm0-x22b.google.com with SMTP id u26so16375766wma.0
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 02:42:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA92RBgkvKQ-6DGgRFr-bxz_60zbXSuQ1AGtz1eUuX_rYw@mail.gmail.com>
References: <20170905092230.8243-1-berrange@redhat.com>
	<CAFEAcA92RBgkvKQ-6DGgRFr-bxz_60zbXSuQ1AGtz1eUuX_rYw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 10:42:04 +0100
Message-ID: <CAFEAcA-PERUcwZw7_is27nHGQ2WSNmyBUsSP-nygF7RLwCQVcw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/9] Merge QEMU I/O 2017/09/05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 5 September 2017 at 10:37, Peter Maydell <peter.maydell@linaro.org> wrote:
> and test-listen fails on my x86-64 Linux box:

OpenBSD fails too, but only starting at thread 124, and
it fails like this for all the tests whereas Linux
only failed on the ipv6 test:

TEST: tests/test-listen... (pid=12010)
  /socket/listen-serial/ipv4:
** Failed to assign a port to thread 124 (errno = 48)
** Failed to assign a port to thread 125 (errno = 48)
** Failed to assign a port to thread 126 (errno = 48)
** Failed to assign a port to thread 127 (errno = 48)
** Failed to assign a port to thread 128 (errno = 48)
** Failed to assign a port to thread 129 (errno = 48)
** Failed to assign a port to thread 130 (errno = 48)
** Failed to assign a port to thread 131 (errno = 48)
** Failed to assign a port to thread 132 (errno = 48)
[snip]
** Failed to assign a port to thread 197 (errno = 48)
** Failed to assign a port to thread 198 (errno = 48)
** Failed to assign a port to thread 199 (errno = 48)
**
ERROR:/home/qemu/tests/test-listen.c:195:listen_compete_nthr:
assertion failed (failed_listens == 0): (76 == 0)
FAIL
GTester: last random seed: R02S5df2be6aaaf10151ac566254ab2f7e88
(pid=37081)
  /socket/listen-serial/ipv6:
** Failed to assign a port to thread 124 (errno = 48)
** Failed to assign a port to thread 125 (errno = 48)
** Failed to assign a port to thread 126 (errno = 48)
** Failed to assign a port to thread 127 (errno = 48)
[snip]
** Failed to assign a port to thread 198 (errno = 48)
** Failed to assign a port to thread 199 (errno = 48)
**
ERROR:/home/qemu/tests/test-listen.c:195:listen_compete_nthr:
assertion failed (failed_listens == 0): (76 == 0)
FAIL
GTester: last random seed: R02Sa41cf200664d43a074a38d7fff7b5393
(pid=93074)
  /socket/listen-serial/generic:
** Failed to assign a port to thread 124 (errno = 48)
** Failed to assign a port to thread 125 (errno = 48)
** Failed to assign a port to thread 126 (errno = 48)
** Failed to assign a port to thread 127 (errno = 48)
[snip]
** Failed to assign a port to thread 198 (errno = 48)
** Failed to assign a port to thread 199 (errno = 48)
**
ERROR:/home/qemu/tests/test-listen.c:195:listen_compete_nthr:
assertion failed (failed_listens == 0): (76 == 0)
FAIL
GTester: last random seed: R02S072bffdb79ddc59e35f0b9c1f8b8f69f
(pid=56289)
  /socket/listen-compete/ipv4:
** Failed to assign a port to thread 124 (errno = 24)
** Failed to assign a port to thread 127 (errno = 24)
** Failed to assign a port to thread 128 (errno = 24)
** Failed to assign a port to thread 129 (errno = 24)
** Failed to assign a port to thread 130 (errno = 24)
[etc etc]

thanks
-- PMM
