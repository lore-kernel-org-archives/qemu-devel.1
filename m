Received: from eggs.gnu.org ([2001:4830:134:3::10]:52597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlHZz-0006bz-M6
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:35:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlHZw-00027f-IN
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:35:31 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:37203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dlHZw-00027Z-CF
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 12:35:28 -0400
Received: by mail-qk0-x242.google.com with SMTP id o184so249989qkc.4
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 09:35:28 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170825155732.15665-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4eede1a1-5ac4-41e3-e6ef-700348fc3d37@amsat.org>
Date: Fri, 25 Aug 2017 13:35:24 -0300
MIME-Version: 1.0
In-Reply-To: <20170825155732.15665-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] scripts: add argparse module for
 Python 2.6 compatibility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: chugh.ishani@research.iiit.ac.in

Hi Stefan,

On 08/25/2017 12:57 PM, Stefan Hajnoczi wrote:
> Many scripts can benefit from the standard library argparse module, which has
> improvements over the older optparse module.  Unfortunately argparse was only
> shipped in Python 2.7 so we need a fallback for Python 2.6.

I probably missed some discussion about it, but what are the reasons to 
stay 2.6 compatible?

Python 2.6 support ended during October 2013, 4 years ago... [1] Why 
don't kill it, start deprecating 2.7 which support will end in less than 
3 years from now [2], and move efforts to version 3...?

Apparently we expect a C compiler compatible with GCC >= 4.1 which was 
released on 2006, before Python 2.5 :S
Then QEMU_BUILD_BUG_ON() try to use C11 feature...

[1] https://www.python.org/dev/peps/pep-0361/ and
https://mail.python.org/pipermail/python-dev/2013-September/128287.html
[2] https://www.python.org/dev/peps/pep-0373/ and
https://pythonclock.org/

Regards,

Phil.

> 
> This patch series adds a copy of argparse.py and updates scripts as necessary
> to import it.
> 
> Stefan Hajnoczi (3):
>    scripts: add argparse module for Python 2.6 compatibility
>    docker.py: Python 2.6 argparse compatibility
>    tests: migration/guestperf Python 2.6 argparse compatibility
> 
>   COPYING.PYTHON                     |  270 ++++
>   scripts/argparse.py                | 2406 ++++++++++++++++++++++++++++++++++++
>   tests/docker/docker.py             |    4 +-
>   tests/migration/guestperf/shell.py |    8 +-
>   4 files changed, 2684 insertions(+), 4 deletions(-)
>   create mode 100644 COPYING.PYTHON
>   create mode 100644 scripts/argparse.py
> 
