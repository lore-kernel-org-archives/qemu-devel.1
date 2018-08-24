Received: from eggs.gnu.org ([2001:4830:134:3::10]:39342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ft8gX-0001ix-UF
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:47:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ft8gT-0004Va-2S
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:47:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54366 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ft8gS-0004V7-SP
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 05:47:12 -0400
Date: Fri, 24 Aug 2018 17:47:09 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180824094709.GG31581@lemon.usersys.redhat.com>
References: <20180824012126.22721-1-famz@redhat.com>
	<20180824082237.GA3430@redhat.com>
	<20180824085220.GF31581@lemon.usersys.redhat.com>
	<CAFEAcA-Qqsnwo3CwtbTMoPvNqkVc6f+4Uj15a2=a2BQdvqmLkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA-Qqsnwo3CwtbTMoPvNqkVc6f+4Uj15a2=a2BQdvqmLkA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: vm: auto_install OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Brad Smith <brad@comstyle.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Fri, 08/24 10:06, Peter Maydell wrote:
> On 24 August 2018 at 09:52, Fam Zheng <famz@redhat.com> wrote:
> > On Fri, 08/24 09:22, Daniel P. Berrang=E9 wrote:
> >> On Fri, Aug 24, 2018 at 09:21:26AM +0800, Fam Zheng wrote:
> >> > Upgrade OpenBSD to 6.3 using auto_install. Especially, drop SDL1,
> >> > include SDL2.
> >> >
> >> > One limitation of this patch is that we need a temporary HTTP serv=
er on
> >> > host 80 port for auto_install, because slirp cannot do guest forwa=
rd on
> >> > "host addr".
> >>
> >> That's a pretty big limitation, as port 80 requires root privileges,
> >> and that's a pretty strict no for automated testing IMHO.
> >>
> >> Why does it have to be port 80 in particular - is it not possible
> >> to use 8080 or even better, detect a random free port ?
> >
> > OpenBSD autoinstall[1] is hardcoded to fetch from port 80. Maybe we c=
an instead
> > persuade it into fetching from a different http server than 10.0.2.2.=
 To do that
> > we'd need to implement a new slirp option for either "option tftp-ser=
ver-name"
> > or "next-server" according to the manpage. I'll have to experiment wi=
th it to
> > see if it will work.
>=20
> Can you use the usermode networking "guestfwd" option to make guest
> tcp connections to wherever:80 go to host:8080 or something instead?
> (watch out for https://bugs.launchpad.net/qemu/+bug/1628971 if it
> is still relevant, I guess).

Yes, that is what I mean above. Will post v2.

Fam
