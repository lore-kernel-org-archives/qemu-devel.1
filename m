Received: from eggs.gnu.org ([2001:4830:134:3::10]:56848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIBjO-0007eo-4g
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 08:05:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIBVd-0002YK-GL
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 07:51:36 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:39225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIBVV-0002QU-TV
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 07:51:29 -0400
Received: by mail-ot1-x332.google.com with SMTP id g27so4585010oth.6
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 04:51:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181030191620.32168-1-armbru@redhat.com>
References: <20181030191620.32168-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Nov 2018 11:50:59 +0000
Message-ID: <CAFEAcA8RdNrbCLL7tXY=e95N2Y0LcZdCPr3EuQo1_hu08qJuaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] Monitor patches for 2018-10-30
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

On 30 October 2018 at 19:16, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 3f3285491dd52014852a56135c90e428c8b507ea:
>
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2018-10-30 14:09:25 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2018-10-30
>
> for you to fetch changes up to 1a8de278dd3c93a7aa40f88486509fe0e2de04da:
>
>   vl: Avoid crash when -mon is underspecified (2018-10-30 20:13:52 +0100)
>
> ----------------------------------------------------------------
> Monitor patches for 2018-10-30
>
> * Fix crash on shutdown with --daemonize
> * Change out-of-band execution to stop reading instead of dropping
>   commands
> * Enable out-of-band execution by default
> * Avoid crash when -mon lacks chardev=...
>
> ----------------------------------------------------------------

Hi; I get test failures on FreeBSD host:

TEST: tests/qmp-test... (pid=18305)
  /sparc64/qmp/protocol:                                               OK
  /sparc64/qmp/oob:                                                    FAIL
GTester: last random seed: R02Se36038cab4c051a2cd47374ec9718e98
(pid=18337)
  /sparc64/qmp/preconfig:                                              OK
FAIL: tests/qmp-test

ERROR:tests/qmp-test.c:211:recv_cmd_id: assertion failed
(qdict_get_try_str(resp, "id") == id): ("oob-1" == "queue-blocks-1")
gmake: *** [/var/tmp/qemu-test.2n2tBU/tests/Makefile.include:805:
check-qtest-sparc] Error 1

and similarly with i386/qmp/oob and sparc/qmp/oob.

thanks
-- PMM
