Received: from eggs.gnu.org ([209.51.188.92]:53256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBJu6-00026W-Pj
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:56:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hBJu5-0001XX-Qw
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:56:42 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:43965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hBJu5-0001X6-Gd
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 09:56:41 -0400
Received: by mail-ot1-x32a.google.com with SMTP id u15so12033077otq.10
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 06:56:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190402130112.15142-1-armbru@redhat.com>
In-Reply-To: <20190402130112.15142-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2019 13:56:19 +0000
Message-ID: <CAFEAcA9Mg7jzOv3iHY8BJKga=RHft-0d7LKzetFEyfnMgZxvzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] Miscellaneous patches for 2019-04-02
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

Hi Markus -- this pullreq seems to be missing the git url and tag
to merge. Could you fix it up and resend the cover letter, please?

thanks
-- PMM


On Tue, 2 Apr 2019 at 20:25, Markus Armbruster <armbru@redhat.com> wrote:
>
> Two regression fixes for 4.0:
>
> * Unbreak migration for Xen
> * Unbreak accelerator fallback
>
> Three safe bug fixes thrown in:
>
> * Fix error location of qemu-system-FOO positional arguments
> * COLOStatus minor doc fix
> * COLOStatus member rename to conform to naming rules
>
> Markus Armbruster (6):
>   vl: Fix error location of positional arguments
>   Revert "vl: Fix to create migration object before block backends
>     again"
>   Revert "migration: move only_migratable to MigrationState"
>   migration: Support adding migration blockers earlier
>   vl: Document dependencies hiding in global and compat props
>   accel: Unbreak accelerator fallback
>
> Zhang Chen (2):
>   qapi/migration.json: Fix ColoStatus member last_mode's version
>   qapi/migration.json: Rename COLOStatus last_mode to last-mode
>
>  accel/accel.c           |  3 ++-
>  include/sysemu/sysemu.h |  1 +
>  migration/migration.c   | 11 ++++++----
>  migration/migration.h   |  3 ---
>  migration/savevm.c      |  2 +-
>  qapi/migration.json     |  6 +++---
>  vl.c                    | 45 +++++++++++++++++++++++++++--------------
>  7 files changed, 44 insertions(+), 27 deletions(-)
>
> --
> 2.17.2
>
>
