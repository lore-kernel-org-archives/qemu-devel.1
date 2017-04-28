Received: from eggs.gnu.org ([2001:4830:134:3::10]:33733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d46Ee-0005yJ-FF
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:47:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d46Ed-0006Nj-Kf
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:47:00 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d46Ed-0006N2-DI
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 09:46:59 -0400
Received: by mail-wr0-x22f.google.com with SMTP id l50so34006836wrc.3
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 06:46:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87fugsfyfq.fsf@dusky.pond.sub.org>
References: <20170427165526.19836-1-dgilbert@redhat.com>
	<87fugsfyfq.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Apr 2017 14:46:37 +0100
Message-ID: <CAFEAcA_o3+w1k-2w6FUa9GhSXTaFx9nEC+_DWsdLvozeHXLPgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] checkpatch: Disallow glib asserts in main
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 28 April 2017 at 14:34, Markus Armbruster <armbru@redhat.com> wrote:
> If these are screwy enough to warrant rejecting them in new code,
> they're probably screwy enough to purge them from existing code:
>

>     include/glib-compat.h:#ifndef g_assert_true
>     include/glib-compat.h:#define g_assert_true(expr)

These ones prompted me to wonder if we could/should use
#pragma GCC poison g_assert_true

rather than just leaving it up to checkpatch.

thanks
-- PMM
