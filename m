Received: from eggs.gnu.org ([2001:4830:134:3::10]:45286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gMF2M-0001x5-5c
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:26:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gMF2H-0003Yg-Fw
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:26:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:15230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gMF2H-0003MW-3Y
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 11:26:01 -0500
Date: Mon, 12 Nov 2018 14:25:42 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181112162542.GL12503@habkost.net>
References: <20181109150710.31085-1-crosa@redhat.com>
	<20181109150710.31085-4-crosa@redhat.com>
	<87efbu5ju6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87efbu5ju6.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] Travis CI: make specified Python
 versions usable on jobs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, Caio Carrara <ccarrara@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Fam Zheng <famz@redhat.com>

On Fri, Nov 09, 2018 at 03:52:49PM +0000, Alex Benn=E9e wrote:
>=20
> Cleber Rosa <crosa@redhat.com> writes:
>=20
> > For the two Python jobs, which seem to have the goal of making sure
> > QEMU builds successfully on the 3.0-3.6 spectrum of Python 3 versions=
,
> > the specified version is only applicable if a Python virtual
> > environment is used.  To do that, it's necessary to define the
> > (primary?) language of the job to be Python.
> >
> > Also, Travis doesn't have a 3.0 Python installation available for the
> > chosen distro, 3.2 being the lower version available.
> >
> > Reference: https://docs.travis-ci.com/user/languages/python/#specifyi=
ng-python-versions
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
>=20
> Reviewed-by: Alex Benn=E9e <alex.bennee@linaro.org>
>=20
> Do you want me to take this via my tree or keep it with the other patch=
es?

Considering that the rest of the series will be included only
after 3.1 and I don't have other Python patches queued for 3.1,
can you merge this one through your tree?  Thanks!

--=20
Eduardo
