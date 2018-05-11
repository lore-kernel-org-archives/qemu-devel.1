Received: from eggs.gnu.org ([2001:4830:134:3::10]:43558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH8Ip-0004YE-UT
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:41:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fH8Io-0005Xh-96
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:41:43 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:37654)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fH8Io-0005W5-18
	for qemu-devel@nongnu.org; Fri, 11 May 2018 09:41:42 -0400
Received: by mail-oi0-x242.google.com with SMTP id w123-v6so4732449oia.4
	for <qemu-devel@nongnu.org>; Fri, 11 May 2018 06:41:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180509112406.6183-1-quintela@redhat.com>
References: <20180509112406.6183-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 May 2018 14:41:20 +0100
Message-ID: <CAFEAcA9+qqcVO1gq7PiLqCdKiHkrE81KroEdz7+iPanQ50zJRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/41] Migration queue
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

On 9 May 2018 at 12:23, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> this includes the reviewed patches for migration:
> - update docs (dave)
> - fixes for blocktime (text cleatups) (dave)
> - migration+tls (dave)
> - rdma index fix (lidong)
> - Postcopy recovery (peterx)
> - Parts reviewed of multifd and tests (me)
>
> There are missing parts of RDMA, will be sent after this is in.  This got already too big.
>
> Please, apply.
>
> The following changes since commit e5cd695266c5709308aa95b1baae499e4b5d4544:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' into staging (2018-05-08 17:05:58 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20180509
>
> for you to fetch changes up to c14eb5ac63b0d2cd146ca004daaeaf56677b7ed1:
>
>   Migration+TLS: Fix crash due to double cleanup (2018-05-09 12:17:22 +0200)
>
> ----------------------------------------------------------------
> migration/next for 20180509
>

Hi. I get some test failures here:

S390x host:
TEST: tests/migration-test... (pid=57456)
  /ppc64/migration/deprecated:                                         OK
  /ppc64/migration/bad_dest:                                           OK
  /ppc64/migration/postcopy/unix:                                      OK
  /ppc64/migration/precopy/unix:                                       OK
  /ppc64/migration/xbzrle/unix:
Unexpected 32 on dest_serial serial
**
ERROR:/home/linux1/qemu/tests/migration-test.c:144:wait_for_serial:
code should not be reached
FAIL

aarch64 host:

Memory content inconsistency at 44f7000 first_byte = 7 last_byte = 6
current = 5 hit_edge = 1
ERROR:/home/peter.maydell/qemu/tests/migration-test.c:281:check_guests_ram:
'bad' should be FALSE
(this is probably for ppc64 guest; unfortunately this system doesn't
have a make that knows about --output-sync, so the make check output
is hard to interpret.)

thanks
-- PMM
