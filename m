Received: from eggs.gnu.org ([2001:4830:134:3::10]:50678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gK3o5-0005m8-2S
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:02:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gK3nx-0000rm-E7
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:02:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47134)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gK3nw-0000nV-G4
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:02:12 -0500
Date: Tue, 6 Nov 2018 11:02:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181106105759-mutt-send-email-mst@kernel.org>
References: <20181105181353.39804-1-mst@redhat.com>
	<20181105181353.39804-3-mst@redhat.com>
	<a21e8e21-d056-1e9a-3726-54f8ce24a162@redhat.com>
	<20181106091147-mutt-send-email-mst@kernel.org>
	<4b68930c-1fc3-9462-8f9e-671b414e712d@redhat.com>
	<CAFEAcA9R9kTfznkvdFf9Eqtp80NFAt3Gd1cjooRpr2bZ6TsJiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAFEAcA9R9kTfznkvdFf9Eqtp80NFAt3Gd1cjooRpr2bZ6TsJiQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 02/33] tests: Move
 tests/hex-loader-check-data/ to tests/data/hex-loader/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Su Hang <suhang16@mails.ucas.ac.cn>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Nov 06, 2018 at 03:31:08PM +0000, Peter Maydell wrote:
> On 6 November 2018 at 15:15, Philippe Mathieu-Daud=E9 <philmd@redhat.co=
m> wrote:
> > No worry, I'm not mad at all, but there might be an issue in your git=
 PR
> > workflow, this series also missed your maintainer S-o-b.
> >
> > Peter: Can you add a such check in your scripts? (during next merge w=
indow,
> > no hurry).
> >
> > Rather than your scripts, this should be in scripts a maintainer can =
run
> > locally, such ./scripts/checkpatch.pl --maintainer or
> > ./scripts/checkseries.xx.
>=20
> I have such a check in my own make-pullreq script which I use
> for arm pull requests:
> https://git.linaro.org/people/peter.maydell/misc-scripts.git/tree/make-=
pullreq#n98
>=20
> I can't do much about other submaintainers' workflows
> (and the block tree's "sub-submaintainers" setup means
> "check all commits have a signoff from the same person as
> the merge commit did" won't work either.)
>=20
> thanks
> -- PMM

I don't have anything validating that but I agree it's a good idea.
Will add, thanks!
