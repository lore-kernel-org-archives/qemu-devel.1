Received: from eggs.gnu.org ([2001:4830:134:3::10]:38333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqJa3-0003Td-TJ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqJa3-0007To-24
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:44:23 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:45899)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dqJa2-0007TC-RL
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 09:44:22 -0400
Received: by mail-wm0-x231.google.com with SMTP id f199so5212883wme.0
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 06:44:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170908095506.13594-1-famz@redhat.com>
References: <20170908095506.13594-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2017 14:44:00 +0100
Message-ID: <CAFEAcA8XcsV0tULC4M3h5E-Jo0CKpLmWECi7QFp0DMV-aSy5Rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/38] Test and build system patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 September 2017 at 10:54, Fam Zheng <famz@redhat.com> wrote:
> Hi Peter,
>
> The following changes since commit cda4a338c4243fa3bff4498b935340ac7121cc76:
>
>   tcg/tci: Add TCG_TARGET_DEFAULT_MO (2017-09-07 18:57:34 +0100)
>
> are available in the git repository at:
>
>   git://github.com/famz/qemu.git tags/staging-pull-request
>
> for you to fetch changes up to d0fba2165aa69ee5cb6a368ad611f3d54950fe4e:
>
>   buildsys: Move rdma libs to per object (2017-09-08 17:47:11 +0800)
>
> ----------------------------------------------------------------
>
> This includes:
>
> - Alex's improvements of docker tests
> - VM test
> - test-block for docker tests
> - test-full improvements
> - cflags / libs cleanup
>
> ----------------------------------------------------------------

Hi. This failed to build on OpenBSD:
  CC      qmp.o
In file included from /home/qemu/ui/vnc.h:33:0,
                 from /home/qemu/qmp.c:26:
/home/qemu/include/ui/console.h:13:23: fatal error: epoxy/gl.h: No
such file or directory
 # include <epoxy/gl.h>
                       ^

Looks like the opengl_cflags are not being applied everywhere
they should be. (OpenBSD is a bit odd in that it doesn't put
epoxy/ in /usr/include, so you must get the -I options right
for the gl.h header to be found.)

thanks
-- PMM
