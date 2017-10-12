Received: from eggs.gnu.org ([2001:4830:134:3::10]:41100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2aMq-0002sO-6y
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2aMk-00012J-Iw
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:05:28 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:48726)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2aMk-00011G-8g
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 06:05:22 -0400
Received: by mail-wm0-x22d.google.com with SMTP id i124so11582630wmf.3
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 03:05:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171011185103.26259-1-ehabkost@redhat.com>
References: <20171011185103.26259-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 11:04:59 +0100
Message-ID: <CAFEAcA-SvJvhAsiK-7QRwQNaG-_QXP8ZV4p-3=0Fz_3NzZmueg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/5] Python queue, 2017-10-11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>

On 11 October 2017 at 19:50, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit bac960832015bf4c4c1b873011612e2675e4464c:
>
>   Merge remote-tracking branch 'remotes/elmarco/tags/vus-pull-request' into staging (2017-10-11 13:10:36 +0100)
>
> are available in the git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to 1a6d3757107181dc0b9baf3dd8ff40fb2a242b66:
>
>   scripts: Remove debug parameter from QEMUMachine (2017-10-11 15:15:17 -0300)
>
> ----------------------------------------------------------------
> Python queue, 2017-10-11
>
> ----------------------------------------------------------------
>
> Eduardo Habkost (5):
>   iotests: Set up Python logging
>   basevm: Call logging.basicConfig()
>   guestperf: Configure logging on all shell frontends
>   scripts: Remove debug parameter from QEMUMonitorProtocol
>   scripts: Remove debug parameter from QEMUMachine
>
>  scripts/qemu.py                     |  9 +++------
>  scripts/qmp/qmp.py                  | 16 +++++++---------
>  tests/migration/guestperf/engine.py |  6 ++----
>  tests/migration/guestperf/shell.py  | 13 +++++++++++++
>  tests/qemu-iotests/iotests.py       |  5 +++--
>  tests/vm/basevm.py                  |  4 ++--
>  6 files changed, 30 insertions(+), 23 deletions(-)

Applied, thanks.

-- PMM
