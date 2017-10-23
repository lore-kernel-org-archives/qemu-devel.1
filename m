Received: from eggs.gnu.org ([2001:4830:134:3::10]:40018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1e6TQQ-0004PR-UC
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 23:29:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1e6TQP-0003pg-Lk
	for qemu-devel@nongnu.org; Sun, 22 Oct 2017 23:29:14 -0400
MIME-Version: 1.0
In-Reply-To: <150868113318.482.11705826106714639873@b58463cdfd5f>
References: <1508678882-4327-1-git-send-email-sundeep.lkml@gmail.com>
	<150868113318.482.11705826106714639873@b58463cdfd5f>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Mon, 23 Oct 2017 08:59:12 +0530
Message-ID: <CALHRZuqhSJC9t3Xrc6-yd3EKcaNUp3NyR+i3FW=i4C7Y16acxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu devel v3 PATCH] msf2: Remove dead code
 reported by Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: famz@redhat.com, qemu-arm <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair23@gmail.com>, Darren Kenny <darren.kenny@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Hi Peter,

On Sun, Oct 22, 2017 at 7:35 PM, <no-reply@patchew.org> wrote:

> Hi,
>
> This series failed automatic build test. Please find the testing commands
> and
> their output below. If you have docker installed, you can probably
> reproduce it
> locally.
>
> Type: series
> Message-id: 1508678882-4327-1-git-send-email-sundeep.lkml@gmail.com
> Subject: [Qemu-devel] [Qemu devel v3 PATCH] msf2: Remove dead code
> reported by Coverity
>
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> set -e
> git submodule update --init dtc
> # Let docker tests dump environment info
> export SHOW_ENV=1
> export J=8
> time make docker-test-quick@centos6
> time make docker-test-build@min-glib
> time make docker-test-mingw@fedora
> time make docker-test-block@fedora
> === TEST SCRIPT END ===
>
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  * [new tag]               patchew/1508678882-4327-1-git-
> send-email-sundeep.lkml@gmail.com -> patchew/1508678882-4327-1-git-
> send-email-sundeep.lkml@gmail.com
> Switched to a new branch 'test'
> a1c66b66e7 msf2: Remove dead code reported by Coverity
>
> === OUTPUT BEGIN ===
> Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path
> 'dtc'
> Cloning into '/var/tmp/patchew-tester-tmp-egubaaoc/src/dtc'...
> fatal: Could not read from remote repository.
>
> Please make sure you have the correct access rights
> and the repository exists.
> fatal: clone of 'git://git.qemu-project.org/dtc.git' into submodule path
> '/var/tmp/patchew-tester-tmp-egubaaoc/src/dtc' failed
> Failed to clone 'dtc'. Retry scheduled
> Cloning into '/var/tmp/patchew-tester-tmp-egubaaoc/src/dtc'...
> fatal: Could not read from remote repository.
>
> Please make sure you have the correct access rights
> and the repository exists.
> fatal: clone of 'git://git.qemu-project.org/dtc.git' into submodule path
> '/var/tmp/patchew-tester-tmp-egubaaoc/src/dtc' failed
> Failed to clone 'dtc' a second time, aborting
> === OUTPUT END ===
>
> Test command exited with code: 1
>

I did not understand. Is the error related to my patch?

Thanks,
Sundeep


>
>
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
>
