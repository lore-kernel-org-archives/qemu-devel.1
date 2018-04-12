Received: from eggs.gnu.org ([2001:4830:134:3::10]:52963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f6YJZ-0008I2-Tl
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f6YJX-0003rR-AG
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:14:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54116 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f6YJX-0003qn-55
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 05:14:43 -0400
Date: Thu, 12 Apr 2018 17:14:24 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180412091424.GG24896@lemon.usersys.redhat.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-23-alex.bennee@linaro.org>
	<20180412081311.GD24896@lemon.usersys.redhat.com>
	<87o9ion748.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87o9ion748.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 22/24] tests/tcg/Makefile: update to be
 called from Makefile.target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, cota@braap.org

On Thu, 04/12 09:47, Alex Benn=E9e wrote:
>=20
> Fam Zheng <famz@redhat.com> writes:
> >> +testthread: LDFLAGS=3D-lpthread
> >
> > I'm a bit curious why only testthread is left in this file but others
> > are gone.
>=20
> testthread is the only one that needs additional flags. However I could
> put those rules in a multiarch/Makefile.target if you want?

I don't have a preference, and this patch is fine. Thanks for explaining.

Fam
