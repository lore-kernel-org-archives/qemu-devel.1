Received: from eggs.gnu.org ([2001:4830:134:3::10]:36982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emLj7-0000Ae-AK
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:45:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emLj6-0005hk-Io
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:45:37 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:35186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1emLj6-0005hZ-CY
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 10:45:36 -0500
Received: by mail-ot0-x244.google.com with SMTP id a2so92345otf.2
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 07:45:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180214153938.5410-1-dgilbert@redhat.com>
References: <20180214153938.5410-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 15:45:14 +0000
Message-ID: <CAFEAcA_dzzcxKVyoNm_wsSJmqsLj0=cKESW6HwYWsdZwMHx_Ug@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/10] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Greg Kurz <groug@kaod.org>, Ross Lagerwall <ross.lagerwall@citrix.com>

On 14 February 2018 at 15:39, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit bec9c64ef7be8063f1192608b83877bc5c9ea217:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-02-13 18:24:08 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20180214a
>
> for you to fetch changes up to 3e0c8050ebba3f55dc2d92b3790a3cfb80786d07:
>
>   migration: pass MigrationState to migrate_init() (2018-02-14 10:37:09 +0000)
>
> ----------------------------------------------------------------
> Migration pull 20180214
>
> Note that the 'Add test for migration to bad destination' displays
> a 'Connection refused' during running, but still gives the correct exit
> code and OK (It's checking that the source doesn't fail when
> it can't connect, so that's the right error).
> If it's particularly disliked that patch can be skipped individually.
>
> ----------------------------------------------------------------

Hi. This fails 'make check' on aarch64 host:
QTEST_QEMU_BINARY=hppa-softmmu/qemu-system-hppa
QTEST_QEMU_IMG=qemu-img MALLOC_PERTURB_=${MALLOC_PERTURB_:-$((
${RANDOM
:-0} % 255 + 1))} gtester -k --verbose -m=quick tests/boot-serial-test
tests/qmp-test tests/device-introspect-test test
s/qom-test tests/test-hmp
TEST: tests/boot-serial-test... (pid=2306)
  /hppa/boot-serial/hppa:                                              **
ERROR:/home/pm215/qemu/tests/boot-serial-test.c:137:check_guest_output:
assertion failed: (output_ok)
FAIL
GTester: last random seed: R02S43359b02a322915508b897be44a0e9c6
(pid=7220)
FAIL: tests/boot-serial-test


thanks
-- PMM
