Received: from eggs.gnu.org ([2001:4830:134:3::10]:54500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcvD-0008NA-Cy
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:50:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcv8-0006Zd-NS
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:50:18 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:43712)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fdcv8-0006Xt-8U
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 10:50:14 -0400
Received: by mail-qt0-x241.google.com with SMTP id f18-v6so24288753qtp.10
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 07:50:14 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180712012829.20231-1-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <916bd5c9-bcf6-ee8e-72b6-ab61e354a02a@amsat.org>
Date: Thu, 12 Jul 2018 11:50:02 -0300
MIME-Version: 1.0
In-Reply-To: <20180712012829.20231-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Add a CentOS test image to run
 docker tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, pbonzini@redhat.com

On 07/11/2018 10:28 PM, Fam Zheng wrote:
> v3: Add 'make vm-test' document. [Phil]
> 
> v2: Drop archive-source.sh changes.
>     The new test depends on the iotests nbd fix I posted today to pass.
> 
> Docker testing on patchew has long suffered from 'make check' hangings. The
> cleanness of VM testing is the cure. Now let's add a CentOS 7 image to run the
> tests.  It's purely ad-hoc, but hopefully still easy to understand and use for
> everyone.
> 
> The first patch makes passing source code from host to the container in VM
> working, and is a nice clean up.
> 
> The second patch makes caches work, to speed up repetitive runs like on
> patchew.
> 
> The last patch adds the new image that does the job. Two out of three docker
> tests running on patchew.org are added to the image. I'll wait for Peter to fix
> the 'docker-test-quick@centos6' hanging (oob test) before adding it too.
> 
> Fam
> 
> Fam Zheng (4):
>   tests: Add an option for snapshot (default: off)
>   tests/vm: Pass verbose flag into VM make commands
>   tests: Allow overriding archive path with SRC_ARCHIVE
>   tests: Add centos VM testing

Series:
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> 
>  tests/docker/Makefile.include |  7 ++-
>  tests/vm/Makefile.include     |  3 +-
>  tests/vm/basevm.py            | 10 ++++-
>  tests/vm/centos               | 84 +++++++++++++++++++++++++++++++++++
>  tests/vm/freebsd              |  4 +-
>  tests/vm/netbsd               |  4 +-
>  tests/vm/openbsd              |  4 +-
>  tests/vm/ubuntu.i386          |  4 +-
>  8 files changed, 107 insertions(+), 13 deletions(-)
>  create mode 100755 tests/vm/centos
> 
