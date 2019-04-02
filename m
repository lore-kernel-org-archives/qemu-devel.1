Received: from eggs.gnu.org ([209.51.188.92]:35078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hB9kU-00056N-Pa
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 23:06:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hB9kS-0006u7-LW
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 23:06:06 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hB9kP-0006eZ-WA
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 23:06:04 -0400
Received: by mail-ot1-x344.google.com with SMTP id m10so10767847otp.2
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 20:05:58 -0700 (PDT)
MIME-Version: 1.0
References: <1553010562-13561-1-git-send-email-catherine.hecx@gmail.com>
	<20190320050735.GB8956@xz-x1>
	<CAEn6zmEzwQD_Ot8sttJj0KwML3Zkhfg9+QBxbOLn6bUsDpVn7w@mail.gmail.com>
	<20190321061024.GB9149@xz-x1>
	<CAEn6zmGFv+UbhyriwakFKB=UhnC6=thhybDF9D1E9JzoYL-1oA@mail.gmail.com>
	<CAFEAcA8q0c5BFh-11KNRJWCi6+Yer_5peekmQptmaw8Ag3SNhw@mail.gmail.com>
	<20190322101211.GA2703@work-vm> <20190325033948.GG9149@xz-x1>
	<CAEn6zmF0DRqqUxjKpdxWYdb_ofGXV_wACfELA991qLfvo9N6vA@mail.gmail.com>
	<CAEn6zmEzcNJGQWrkbP2_v3aidj5o=S39pQgm8kPHqSn8Os=J+g@mail.gmail.com>
In-Reply-To: <CAEn6zmEzcNJGQWrkbP2_v3aidj5o=S39pQgm8kPHqSn8Os=J+g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Apr 2019 03:05:46 +0000
Message-ID: <CAFEAcA_=7E9nrFLLmhXBwk5k10ufhKQKX+ZCttfWOxOYt=hZog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] migration: avoid copying ignore-shared
 ramblock when in incoming migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Catherine Ho <catherine.hecx@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Yury Kotov <yury-kotov@yandex-team.ru>

On Tue, 2 Apr 2019 at 09:57, Catherine Ho <catherine.hecx@gmail.com> wrote:
> The root cause is the used idx is moved forward after 1st time incoming, and in 2nd time incoming,
> the last_avail_idx will be incorrectly restored from the saved device state file(not in the ram).
>
> I watched this even on x86 for a virtio-scsi disk
>
> Any ideas for supporting 2nd time, 3rd time... incoming restoring?

Does the destination end go through reset between the 1st and 2nd
incoming attempts? I'm not a migration expert, but I thought that
devices were allowed to assume that their state is "state of the
device following QEMU reset" before the start of an incoming
migration attempt.

thanks
-- PMM
