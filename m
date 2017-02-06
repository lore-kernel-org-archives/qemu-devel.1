Received: from eggs.gnu.org ([2001:4830:134:3::10]:38670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1caoQ9-0007XG-Uc
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 13:53:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1caoQ9-0007XT-6m
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 13:53:50 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:37717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1caoQ8-0007XP-Vk
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 13:53:49 -0500
Received: by mail-wm0-x22b.google.com with SMTP id v77so127809803wmv.0
	for <qemu-devel@nongnu.org>; Mon, 06 Feb 2017 10:53:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1486399909-16338-1-git-send-email-quintela@redhat.com>
References: <1486399909-16338-1-git-send-email-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Feb 2017 18:53:27 +0000
Message-ID: <CAFEAcA-yFVYzwxt4FG9D3g3BwEJFPnmNrr-pJOzYV-h5Y6bu7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/6] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 6 February 2017 at 16:51, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> This are the current migration pull:
> - fix long id's for migration (David)
> - several postcopy fixes (David)
> - create the incomming state in a single place for Migraition (me)
>
> Please, apply.
>
> The following changes since commit 7d2c6c95511e42dffe2b263275e09957723d0ff4:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-usb-20170206-1' into staging (2017-02-06 11:44:08 +0000)
>
> are available in the git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/migration/20170206
>
> for you to fetch changes up to ef8d6488d2767fe81bb4bb9bcdc52af5ff718b56:
>
>   postcopy: Recover block devices on early failure (2017-02-06 13:36:49 +0100)
>
> ----------------------------------------------------------------
> migration/next for 20170206
>
> ----------------------------------------------------------------
> Dr. David Alan Gilbert (5):
>       vmstate_register_with_alias_id: Take an Error **
>       migration: Check for ID length
>       vmstate registration: check return values
>       Postcopy: Reset state to avoid cleanup assert
>       postcopy: Recover block devices on early failure
>
> Juan Quintela (1):
>       migration: create Migration Incoming State at init time

I get a test failure on aarch64 host on one of the ppc guest tests:

TEST: tests/prom-env-test... (pid=26435)
  /ppc64/prom-env/mac99:                                               OK
  /ppc64/prom-env/g3beige:                                             OK
  /ppc64/prom-env/pseries:                                             **
ERROR:/home/petmay01/qemu/tests/prom-env-test.c:42:check_guest_memory:
assertion failed (signature == MAGIC): (0x7c7f1b78 == 0xcafec0de)
FAIL
GTester: last random seed: R02Sbd97cf9617f5dd55ba90b08765cfa0d0
(pid=26445)
FAIL: tests/prom-env-test


This might just be the test having an overzealous timeout (I
think I've seen this before a while back, when I was trying
to do a 'make -j2 check' on this slow board); but on the other
hand it's been fine recently but it failed twice trying to test
this pullreq.

thanks
-- PMM
