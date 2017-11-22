Received: from eggs.gnu.org ([2001:4830:134:3::10]:58498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHTjW-0006l3-CN
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:02:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHTjN-0007pb-6h
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:02:26 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:37696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHTjN-0007oa-2e
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 07:02:17 -0500
Received: by mail-oi0-x244.google.com with SMTP id d93so3049039oic.4
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 04:02:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171122084157.11480-1-quintela@redhat.com>
References: <20171122084157.11480-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 22 Nov 2017 12:01:55 +0000
Message-ID: <CAFEAcA_qh+mxGe9AjxDCVEnyPeKfg511HOAhF7H+jOBg2fLuhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg: Fix complilation with TCG
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

On 22 November 2017 at 08:41, Juan Quintela <quintela@redhat.com> wrote:
> This commit started use tb_unlock() and tlb_set_dirty() on non TCG
> code.  Add the function as stubs.
>
> commit 27266271977c5a30f2f7d493e042be1897827bdd
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Mon Nov 20 18:08:27 2017 +0000
>
>     exec.c: Factor out before/after actions for notdirty memory writes
>     ....
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Subject seems confusing -- do you mean "without TCG" ?

thanks
-- PMM
