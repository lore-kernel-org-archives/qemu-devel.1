Received: from eggs.gnu.org ([2001:4830:134:3::10]:56778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHB6S-0004aB-9K
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:08:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eHB6R-0007Uh-AN
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:08:52 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:39117)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eHB6R-0007UA-4K
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 11:08:51 -0500
Received: by mail-ot0-x243.google.com with SMTP id v15so10952870ote.6
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 08:08:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <7c5ebc0b-c588-e405-58a4-783c357169b6@amsat.org>
References: <1511276888-17834-1-git-send-email-peter.maydell@linaro.org>
	<7308e432-4cf5-04bd-4a22-f330dda1f933@amsat.org>
	<CAFEAcA_NK63LdJs=3Y6zvdrn2Vn7Vvq-CF=p_J4kq9+6VKDOXg@mail.gmail.com>
	<7c5ebc0b-c588-e405-58a4-783c357169b6@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Nov 2017 16:08:30 +0000
Message-ID: <CAFEAcA9DejuhzRcnf90s4-u3eEvgDWpUuBcRVVcgktub9B1C3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] memory-internal.h: Remove obsolete claim
 that header is obsolete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 21 November 2017 at 16:04, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> On 11/21/2017 01:00 PM, Peter Maydell wrote:
>> I'm not sure what you're suggesting. I definitely think the
>> s390 usage is pretty nasty but I guess it would need some
>> rework to get rid of. For everything else, it's nice
>> to have somewhere to share these things. You could argue
>> for splitting the header into two, one for 'between memory.c
>> and exec.c' and one for 'between memory.c and cputlb.c',
>> but is it worth the effort?
>
> Why not move memory_region_access_valid() + NotDirtyInfo in
> "exec/exec-all.h" and only use this to "share these things"?

Because exec-all.h is included by an absolute ton of .c files.
The point is to have a header for these basically-internal
functions that's only included by the small set of .c files
that should have access to them, so that other code doesn't
start using them by accident.

thanks
-- PMM
