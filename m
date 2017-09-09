Received: from eggs.gnu.org ([2001:4830:134:3::10]:49291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqkeK-00019F-4j
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 14:38:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dqkeJ-0005it-4h
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 14:38:36 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:46537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dqkeI-0005dx-T3
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 14:38:35 -0400
Received: by mail-wm0-x234.google.com with SMTP id i189so18977323wmf.1
	for <qemu-devel@nongnu.org>; Sat, 09 Sep 2017 11:38:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170909150710.GA29670@lemon.lan>
References: <20170909054613.19148-1-famz@redhat.com>
	<20170909054613.19148-11-famz@redhat.com>
	<CAFEAcA83JDUMAsCAY=YBL+qS8A1n6VMfH1p_DAmouF0W8m-j9g@mail.gmail.com>
	<20170909150710.GA29670@lemon.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Sep 2017 19:38:11 +0100
Message-ID: <CAFEAcA-8f_0jSZ8Rn0F125qLberVMVOOQLyyEWxvUiXD5u-KMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 10/37] scripts: Add archive-source.sh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 9 September 2017 at 16:07, Fam Zheng <famz@redhat.com> wrote:
> On Sat, 09/09 13:07, Peter Maydell wrote:
>> On 9 September 2017 at 06:45, Fam Zheng <famz@redhat.com> wrote:
>> > Signed-off-by: Fam Zheng <famz@redhat.com>
>> > Message-Id: <20170905021201.25684-4-famz@redhat.com>
>> > ---
>> >  scripts/archive-source.sh | 31 +++++++++++++++++++++++++++++++
>> >  1 file changed, 31 insertions(+)
>> >  create mode 100755 scripts/archive-source.sh
>> >
>> > diff --git a/scripts/archive-source.sh b/scripts/archive-source.sh
>> > new file mode 100755
>> > index 0000000000..1de369532e
>> > --- /dev/null
>> > +++ b/scripts/archive-source.sh
>> > @@ -0,0 +1,31 @@
>> > +#!/bin/sh
>> > +#
>> > +# Author: Fam Zheng <famz@redhat.com>
>> > +#
>> > +# Create archive of source tree, including submodules
>> > +#
>> > +# This code is licensed under the GPL version 2 or later.  See
>> > +# the COPYING file in the top-level directory.
>>
>> So is this the script that for instance Mike Roth would use
>> to create the release tarballs? If it isn't, should it be?
>
> I don't know the workflow of release tarballs, there is ./scripts/make-release
> for that. So this one is not.
>
>> Is it intended for end users to create tarballs with, or
>> is it really just a helper script for the docker stuff?
>> If the latter, it would be helpful to say so. If the former,
>> it could really use more usage information/documentation...
>
> I'm not sure what end users would use this for, but it should do its work just
> the same.. What kind of usage information do you suggest? More explaination in
> the header, or in the "usage" output when no target is specified, or a "-h"
> option for help?

Basically, if it's a special purpose script that is only
being used by docker, then it should clearly say that
so that anybody who looks at it will know it's not
something relevant to them. If it's not special purpose
then it should say what it's for and how you use it.
Just putting this in comments at the top of the script
is fine.

thanks
-- PMM
