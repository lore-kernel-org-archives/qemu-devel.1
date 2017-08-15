Received: from eggs.gnu.org ([2001:4830:134:3::10]:58629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhVyp-0000aC-VX
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhVyl-0001Jg-6o
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:09:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dhVyl-0001JY-0u
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 03:09:31 -0400
Date: Tue, 15 Aug 2017 15:09:27 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170815070927.GB29320@lemon>
References: <20170810085025.14076-1-famz@redhat.com>
	<0d899b2a-19a0-5b52-c63e-dba8b1d2d851@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <0d899b2a-19a0-5b52-c63e-dba8b1d2d851@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Makefile: Let "make check-help" work
 without running ./configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Thu, 08/10 08:59, Philippe Mathieu-Daud=E9 wrote:
> Hi Fam,
>=20
> thank for fixing this :)
>=20
> I think as a bugfix it should enter 2.10
> (maybe through Alex's Travis series, CC'ing him)

Since Alex hasn't replied, I'll send a pull request for -rc3.

>=20
> On 08/10/2017 05:50 AM, Fam Zheng wrote:
> > Currently if you do "make check-help" in a fresh checkout, only an er=
ror
> > is printed which is not nice:
> >=20
> >      $ make check-help V=3D1
> >      cc -nostdlib  -o check-help.mo
> >      cc: fatal error: no input files
> >      compilation terminated.
> >      rules.mak:115: recipe for target 'check-help.mo' failed
> >      make: *** [check-help.mo] Error 1
> >=20
> > Move the config-host.mak condition into the body of
> > tests/Makefile.include and always include the rule for check-help.
> >=20
> > Reported-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20

Fam
