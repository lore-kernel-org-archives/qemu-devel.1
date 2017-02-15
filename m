Received: from eggs.gnu.org ([2001:4830:134:3::10]:36252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdnp0-0003dp-8Y
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 19:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cdnow-0000B9-C6
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 19:51:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cdnow-0000B2-5z
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 19:51:46 -0500
Date: Wed, 15 Feb 2017 08:51:42 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170215005142.GA26331@lemon.lan>
References: <20170214100733.22280-1-alex.bennee@linaro.org>
	<20170214100733.22280-4-alex.bennee@linaro.org>
	<20170214141117.GC12294@lemon.lan> <87bmu4vk8v.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87bmu4vk8v.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] .shippable.yml: new CI provider
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On Tue, 02/14 15:56, Alex Benn=E9e wrote:
> > May I propose we merge 'docker testing' section of MAINTAINERS into '=
build and
> > test automation' section? I don't know as much about travis (and ship=
pable) but
> > I'm totally fine if you want to have docker tests under your umbrella=
, and
> > it seems a logical step judging from their names.
>=20
> So:
>=20
> Build and test automation
> -------------------------
> M: Alex Benn=E9e <alex.bennee@linaro.org>
> M: Fam Zheng <famz@redhat.com>
> L: qemu-devel@nongnu.org
> S: Maintained
> F: .travis.yml
> F: .shippable.yml
> F: tests/docker/

Yes, looks good. Please include a patch in v4.

>=20
> Or did you want to drop out of the review cycle and concentrate on patc=
hew?

I would still keep my eyes on tests/docker/, the intent is just for being=
 more
compact on MAINTAINERS.

Fam
