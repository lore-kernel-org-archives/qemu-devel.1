Received: from eggs.gnu.org ([2001:4830:134:3::10]:56037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZIjY-0000Uf-NP
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZIjX-0008Gb-TW
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:28:24 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:42809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZIjX-0008Fj-Fz
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 12:28:23 -0400
Received: by mail-oi0-x242.google.com with SMTP id n84-v6so11149828oib.9
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 09:28:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180629174305.42849-1-dgilbert@redhat.com>
References: <20180629174305.42849-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 30 Jun 2018 17:28:02 +0100
Message-ID: <CAFEAcA8AdAYdnaCgyyEDwqbNd+0ZovfG2O3wLGcumRg2b3RW1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tests/migration: Skip tests for ppc tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>

On 29 June 2018 at 18:43, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> PPC tcg seems to be failing migration tests quite regularly;
> we believe this is TCG bugs in dirty bit updating; it's
> not clear why PPC fails more but lets skip for the moment.
>
> $ ./tests/migration-test
> /ppc64/migration/deprecated: OK
> /ppc64/migration/bad_dest: SKIP
> /ppc64/migration/postcopy/unix: SKIP
> /ppc64/migration/precopy/unix: SKIP

This patch seems to make the test fail in some setups:

TEST: tests/migration-test... (pid=58969)
  /ppc64/migration/deprecated:                                         OK
  /ppc64/migration/bad_dest:                                           FAIL
GTester: last random seed: R02S608df80fbcf1f18882138d397082bb59
  /ppc64/migration/postcopy/unix:                                      FAIL
GTester: last random seed: R02S608df80fbcf1f18882138d397082bb59
  /ppc64/migration/precopy/unix:                                       FAIL
GTester: last random seed: R02S608df80fbcf1f18882138d397082bb59
PASS: tests/migration-test

(and eventually make exits with an error).

Failed for me on ppc64, s390x, x86-64, aarch32.
I don't think any of my build systems printed "SKIP" for
these tests -- they either FAIL or just don't print
anything.

thanks
-- PMM
