Received: from eggs.gnu.org ([2001:4830:134:3::10]:35975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcbP6-0006v1-T3
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 13:56:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcbP6-00069B-2a
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 13:56:24 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:35063)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dcbP5-00068T-S5
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 13:56:24 -0400
Received: by mail-wm0-x236.google.com with SMTP id m85so21680344wma.0
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 10:56:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1501604245-33460-3-git-send-email-pbonzini@redhat.com>
References: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
	<1501604245-33460-3-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Aug 2017 18:56:02 +0100
Message-ID: <CAFEAcA8ArjNALptSYkR4T-SaejWPQxpazYjm-b_aCkGDFFXgnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 02/17]
 cpu_physical_memory_sync_dirty_bitmap: Fix alignment check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 1 August 2017 at 17:17, Paolo Bonzini <pbonzini@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> This code has an optimised, word aligned version, and a boring
> unaligned version.  Recently 084140bd498909 fixed a missing offset
> addition from the core of both versions.  However, the offset isn't
> necessarily aligned and thus the choice between the two versions
> needs fixing up to also include the offset.
>
> Symptom:
>   A few stuck unsent pages during migration; not normally noticed
> unless under very low bandwidth in which case the migration may get
> stuck never ending and never performing a 2nd sync; noticed by
> a hanging postcopy-test on a very heavily loaded system.
>
> Fixes: 084140bd498909
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reported-by: Alex Benne=C3=83=C2=A9 <alex.benee@linaro.org>
> Tested-by: Alex Benne=C3=83=C2=A9 <alex.benee@linaro.org>
>
> --
> v2
>   Move 'page' inside the if (Comment from Paolo)
> Message-Id: <20170724165125.29887-1-dgilbert@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Something somewhere along the line seems to have mangled the
unicode characters in Alex's name :-(
Also, Alex's email address is typoed, and what should be the
'---' marker has been written as '--' so the below-the-fold waffle
is still hanging around in the commit.

This doesn't seem worth rejecting the pull request on the
eve of rc1 for, but it's still a bit sad :-(

thanks
-- PMM
