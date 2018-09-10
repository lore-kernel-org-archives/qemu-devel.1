Received: from eggs.gnu.org ([2001:4830:134:3::10]:40259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fzKeB-0004Yf-6T
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fzKcC-0002c2-95
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:44:27 -0400
Received: from mail.ispras.ru ([83.149.199.45]:50960)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1fzKcC-0002bo-0D
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 07:44:24 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <152819515565.30857.16834004920507717324.stgit@pasha-ThinkPad-T60>
	<87lg8dz809.fsf@linaro.org>
	<CAFEAcA-iTfGnjc+0ndTMxZ=RYRCK3_RRmE1RCNgDnTVL_brrXQ@mail.gmail.com>
	<87h8ixd8vb.fsf@linaro.org>
In-Reply-To: <87h8ixd8vb.fsf@linaro.org>
Date: Mon, 10 Sep 2018 14:44:24 +0300
Message-ID: <001a01d448fb$9f1d3670$dd57a350$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v2 0/7] QEMU binary instrumentation
 prototype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?'Alex_Benn=C3=A9e'?= <alex.bennee@linaro.org>, 'Peter Maydell' <peter.maydell@linaro.org>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, 'QEMU Developers' <qemu-devel@nongnu.org>, maria.klimushenkova@ispras.ru, 'Paolo Bonzini' <pbonzini@redhat.com>, =?utf-8?Q?'Llu=C3=ADs_Vilanova'?= <vilanova@ac.upc.edu>

> From: Alex Benn=C3=A9e [mailto:alex.bennee@linaro.org]
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
> <snip>
> >> Now I can see arguments against it from an interface complexity =
point of
> >> view but I think plugins should get access to the TCG functions so =
they
> >> can generate their own op sequences if need be and not have to call =
a
> >> helper at all if they don't need to.
> >
> > I strongly disagree -- plugins should not have access to details
> > of QEMU internals that might change from version to version, and
> > definitely not access to generating their own TCG code.
>=20
> In terms of the wider problem about exposing internals that might =
change
> from version to version I wonder if we should care? Is the plugin API
> one where we should provide ABI stability or should we take the =
approach
> that Linux does and say if your code lives out-of-tree then it's your
> problem to keep up if/when we change.

Then one can just omit the plugins and embed the analysis code into =
QEMU.
The idea behind the plugins is making the maintenance less =
time-consuming
by providing the stable interface.

Pavel Dovgalyuk
