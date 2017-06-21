Received: from eggs.gnu.org ([2001:4830:134:3::10]:60509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dNYwO-0004OP-Um
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 02:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dNYwL-00034x-MR
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 02:16:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dNYwL-00034j-Gg
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 02:16:33 -0400
Date: Wed, 21 Jun 2017 14:16:28 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170621061628.GB15212@lemon.lan>
References: <20170602185630.5059-1-f4bug@amsat.org> <87podyu01e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87podyu01e.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 00/24] docker/shippable: cross-build
 mipsel and powerpc targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On Tue, 06/20 16:54, Alex Benn=E9e wrote:
>=20
> Philippe Mathieu-Daud=E9 <f4bug@amsat.org> writes:
>=20
> > This patchset add 2 more architectures to the cross-build farm.
> >
> > There is still some issue trying to cross-build mips64el-softmmu, it =
seems the
> > cross tools use the system outdated libfdt instead of the one checkou=
ted in the
> > dtc submodule. I disabled this target for now.
> >
> > The branch https://github.com/philmd/qemu/tree/docker_shippable_v5 ca=
n be
> > checked at Shippable:
> >   https://app.shippable.com/github/philmd/qemu/status/dashboard
> >
> > Each arch builds in around ~9min. Using Shippable free open source pr=
ojects
> > service, the 5 jobs take ~38-44min in total.
>=20
> Fam,
>=20
> Are you picking this up or shall I roll a pull-req?

Please do, thanks! I am occupied by something else for at least the rest =
of this
week (and my apologies for not responding to this series for days).

Fam
