Received: from eggs.gnu.org ([2001:4830:134:3::10]:51693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1db1CA-00049D-Hv
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1db1C9-0003qs-Qt
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:04:30 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:37072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1db1C9-0003qJ-IP
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:04:29 -0400
Received: by mail-wm0-x231.google.com with SMTP id e199so14640160wmd.0
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 02:04:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170728085547.13947-1-vsementsov@virtuozzo.com>
References: <20170728085547.13947-1-vsementsov@virtuozzo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jul 2017 10:04:07 +0100
Message-ID: <CAFEAcA_9_YVyDC5jbLT=YXT64MFkxOrpxV7eydCEK_Lc4oSY5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] trace-events: print 0x before hex numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

On 28 July 2017 at 09:55, Vladimir Sementsov-Ogievskiy
<vsementsov@virtuozzo.com> wrote:
> To make logs more readable prefix all hex values with '0x' mark.
> This is needed for consistency too, as a lot of hex values are already
> prefixed with '0x'. Also, bring all hex outputs to the common form -
> use '%#', not '0x%'.
>
> This patch is done by two commands:
> find . -name trace-events | \
>  xargs sed -i 's/%\([-+ *.0-9]*\([hljztL]\|ll\|hh\)\?\(x\|X\|"\s*PRIx\)\)/%#\1/g'
> find . -name trace-events | xargs sed -i 's/0x%#/%#/g'
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

There seem to be an order of magnitude more trace format strings
using 0x% rather than %#, so maybe converting in the other direction
would be better? I think the patch would also be easier to review
if the "no change to the printed value" switches between 0x% and %#
were not in the same patch as "changing the printed value which
didn't have an 0x before".

thanks
-- PMM
