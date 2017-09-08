Received: from eggs.gnu.org ([2001:4830:134:3::10]:58442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqSRo-000097-R3
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 19:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dqSRj-0004rm-QN
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 19:12:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37290)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dqSRj-0004ot-K5
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 19:12:23 -0400
Date: Sat, 9 Sep 2017 07:12:17 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170908231217.GA18677@lemon.lan>
References: <20170905021201.25684-1-famz@redhat.com>
	<20170905021201.25684-2-famz@redhat.com>
	<87y3ppgty2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87y3ppgty2.fsf@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 01/12] gitignore: Ignore vm test images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, pbonzini@redhat.com, stefanha@redhat.com, Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, eblake@redhat.com, Kamil Rytarowski <kamil@netbsd.org>

On Fri, 09/08 15:12, Alex Benn=E9e wrote:
>=20
> Fam Zheng <famz@redhat.com> writes:
>=20
> > Signed-off-by: Fam Zheng <famz@redhat.com>
> > ---
> >  .gitignore       | 1 +
> >  tests/.gitignore | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/.gitignore b/.gitignore
> > index cf65316863..40acfcb9e2 100644
> > --- a/.gitignore
> > +++ b/.gitignore
> > @@ -52,6 +52,7 @@
> >  /vscclient
> >  /vhost-user-scsi
> >  /fsdev/virtfs-proxy-helper
> > +*.tmp
>=20
> I'm not sure we should be dumping anything in the rootdir, .gitignored
> or not.

It used to be /tests/vm/*.tmp but Philippe asked for a generic rule in pr=
evious
reviewing. I think it makes sense, we can also unify the docker-src.* pat=
tern by
making the directory names to have a .tmp suffix later.

Fam
