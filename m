Received: from eggs.gnu.org ([2001:4830:134:3::10]:49283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1dYUIO-0000hK-T8
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:32:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pahome.chen@mirlab.org>) id 1dYUIN-00075q-S8
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:32:28 -0400
Received: from mail-ua0-x22a.google.com ([2607:f8b0:400c:c08::22a]:36647)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pahome.chen@mirlab.org>)
	id 1dYUIN-00075e-NM
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:32:27 -0400
Received: by mail-ua0-x22a.google.com with SMTP id k43so4766153uaf.3
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 02:32:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170721092624.GR11032@lemon>
References: <CAB3eZfs8E0xsBAFH_4U=M4LsVpRs73aPdFk5qy_ZUKqMom9P8g@mail.gmail.com>
	<20170721041053.GQ11032@lemon>
	<CAFEAcA-bDWpXsn9HyaLSX_Kqa7+5-6icks-zu4jZ0a0M4h41FQ@mail.gmail.com>
	<20170721092624.GR11032@lemon>
From: =?UTF-8?B?6Zmz5Z+55rOT?= <pahome.chen@mirlab.org>
Date: Fri, 21 Jul 2017 17:32:26 +0800
Message-ID: <CAB3eZftH13TSyoP9MfW6eu+waOdFX2MuV84aeorZXDp_VG8P0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] unrecognized option --object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

It works when I replace /usr/bin/qemu-nbd with qemu-nbd which I just built
from qemu github.

2017-07-21 17:26 GMT+08:00 Fam Zheng <famz@redhat.com>:

> On Fri, 07/21 10:15, Peter Maydell wrote:
> > On 21 July 2017 at 05:10, Fam Zheng <famz@redhat.com> wrote:
> > > On Thu, 07/20 19:06, =E9=99=B3=E5=9F=B9=E6=B3=93 wrote:
> > >> I build qemu from the https://github.com/qemu/qemu, and it didn't
> show any
> > >> errors.
> > >>
> > >> I tried qemu-nbd --object secret,id=3Dsec0...
> > >> but it shows unrecognized option '--object '
> > >>
> > >> how to solve it?
> > >
> > > -object it is. Thanks.
> >
> > Hmm? For me the help message says '--object' and the implementation
> > agrees that it wants two hyphens:
>
> Yup, sorry for the misinformation. (I was confused by qemu-system-*
> options).
>
> Fam
>
