Received: from eggs.gnu.org ([2001:4830:134:3::10]:51903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gClOQ-0004W8-Dq
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gClOM-00040K-Dh
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:57:42 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:42479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gClOM-0003r0-7Z
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 08:57:38 -0400
Received: by mail-yw1-f68.google.com with SMTP id a197-v6so10284824ywh.9
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 05:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180930214744.27580-1-f4bug@amsat.org>
	<20180930214744.27580-5-f4bug@amsat.org>
	<BN6PR2201MB1251E81C553B373D095AE0C4C6FF0@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB1251E81C553B373D095AE0C4C6FF0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 17 Oct 2018 14:57:21 +0200
Message-ID: <CAAdtpL7fQY3RbmC3cHV=t=gT-ORL0DtM1_CGEYjQm_sgWqakQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/4] MAINTAINERS: Voluntary to review
 hobbyist MIPS contributions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Aurelien Jarno <aurelien@aurel32.net>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Hi Aleksandar,

On Wed, Oct 17, 2018 at 2:15 PM Aleksandar Markovic
<amarkovic@wavecomp.com> wrote:
> > From: Philippe Mathieu-Daud=C3=A9 <philippe.mathieu.daude@gmail.com> on=
 behalf of Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > Subject: [PATCH v3 4/4] MAINTAINERS: Voluntary to review hobbyist MIPS =
contributions
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> > MAINTAINERS | 2 ++
> > 1 file changed, 2 insertions(+)
>
> This is very generous of you. However, I would prefer registered reviewer=
s of MIPS directories to be persons more focused on MIPS. But thanks again.

In MAINTAINERS the 'R:' tag simply means "These reviewers should be
CCed on patches."

This is just used by the get_maintainer script to see to who send patches t=
o.
This is not about responsibility nor ownership.

The guideline on the wiki
https://wiki.qemu.org/Contribute/SubmitAPatch#CC_the_relevant_maintainer
says:
  "In fact, you can automate this, via a one-time setup of git config
sendemail.cccmd 'scripts/get_maintainer.pl --nogit-fallback'."

So you end up with:

$ grep -A2 email .git/config
[sendemail]
    confirm =3D auto
    cccmd =3D scripts/get_maintainer.pl --nogit-fallback --noroles --n
--m --r --remove-duplicates

As an example, if you check the "Unimp device" section:

Unimplemented device
M: Peter Maydell <peter.maydell@linaro.org>
R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
S: Maintained
F: include/hw/misc/unimp.h
F: hw/misc/unimp.c

I'm not a maintainer, Peter is. I have no obligation to review
patches, I am simply interested to not loose them in the traffic.
With the 'R:' tag my email appears in the list:

$ ./scripts/get_maintainer.pl -f hw/misc/unimp.c
Peter Maydell <peter.maydell@linaro.org> (maintainer:Unimplemented device)
"Philippe Mathieu-Daud=C3=A9" <f4bug@amsat.org> (reviewer:Unimplemented dev=
ice)
qemu-devel@nongnu.org (open list:All patches CC here)

Anyway I'm fine with that patch not being applied, and now I even
prefer it is not.

I found a kludge using the "to: (qemu-devel@nongnu.org
aurelien@aurel32.net amarkovic@wavecomp.com)" email filter. If an
email is sent to the list and both of you, it is very likely this is
MIPS related.

Regards,

Phil.
