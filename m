Received: from eggs.gnu.org ([2001:4830:134:3::10]:42169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egEZO-0007Yu-Jx
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:54:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egEZN-0008Lf-Ro
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:54:18 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:39688)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1egEZN-0008LX-Ls
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 13:54:17 -0500
Received: by mail-ot0-x22a.google.com with SMTP id d9so7533833oth.6
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 10:54:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180129120932.12874-1-quintela@redhat.com>
References: <20180129120932.12874-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jan 2018 18:53:56 +0000
Message-ID: <CAFEAcA_DrUj0MdJVRMst91k--Cvc9j+QKy-tscp0R526cEttdQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/13] Migration PULL request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On 29 January 2018 at 12:09, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> - migrate_fd_connect cleanup (dave)
> - use MAX_VM_PACKAGED_SIZE
>   have to change (1<<32) for UINT32_MAX to get no warnings on win32
> - Use right s->threashord_size(wei)
> - patches reviewed from info/migrate, migration tests and multifd (me)
>
> Later, Juan.
>
> The following changes since commit 6233b4a8c2a32ef6955a921246fa08705bbb3676:
>
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2018-01-26' into staging (2018-01-26 17:29:14 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20180129
>
> for you to fetch changes up to 4b6bb0a77761b8a906a540e927c7a9dde99bc10f:
>
>   tests: Adjust sleeps for migration test (2018-01-29 12:10:22 +0100)
>
> ----------------------------------------------------------------
> migration/next for 20180129

Hi. On aarch32 host I get this assert in the tests:

TEST: tests/migration-test... (pid=605)
  /ppc64/migration/deprecated:                                         OK
  /ppc64/migration/precopy/unix:                                       OK
  /ppc64/migration/postcopy/unix:                                      OK
  /ppc64/migration/xbzrle/unix:
Unexpected 32 on dest_serial serial
**
ERROR:/home/peter.maydell/qemu/tests/migration-test.c:218:wait_for_serial:
code should not be reached
FAIL
GTester: last random seed: R02S31c8250adcdb12a122a1c5c0ab62d01e
(pid=639)
FAIL: tests/migration-test

thanks
-- PMM
