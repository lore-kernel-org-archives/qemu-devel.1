Received: from eggs.gnu.org ([2001:4830:134:3::10]:47675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dYUCe-0005dr-FA
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dYUCd-0004Wq-DM
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:26:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dYUCd-0004VO-6y
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 05:26:31 -0400
Date: Fri, 21 Jul 2017 17:26:24 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170721092624.GR11032@lemon>
References: <CAB3eZfs8E0xsBAFH_4U=M4LsVpRs73aPdFk5qy_ZUKqMom9P8g@mail.gmail.com>
	<20170721041053.GQ11032@lemon>
	<CAFEAcA-bDWpXsn9HyaLSX_Kqa7+5-6icks-zu4jZ0a0M4h41FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-bDWpXsn9HyaLSX_Kqa7+5-6icks-zu4jZ0a0M4h41FQ@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?utf-8?B?6Zmz5Z+55rOT?= <pahome.chen@mirlab.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 07/21 10:15, Peter Maydell wrote:
> On 21 July 2017 at 05:10, Fam Zheng <famz@redhat.com> wrote:
> > On Thu, 07/20 19:06, =E9=99=B3=E5=9F=B9=E6=B3=93 wrote:
> >> I build qemu from the https://github.com/qemu/qemu, and it didn't sh=
ow any
> >> errors.
> >>
> >> I tried qemu-nbd --object secret,id=3Dsec0...
> >> but it shows unrecognized option '--object '
> >>
> >> how to solve it?
> >
> > -object it is. Thanks.
>=20
> Hmm? For me the help message says '--object' and the implementation
> agrees that it wants two hyphens:

Yup, sorry for the misinformation. (I was confused by qemu-system-* optio=
ns).

Fam
