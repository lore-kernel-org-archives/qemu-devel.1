Received: from eggs.gnu.org ([209.51.188.92]:44678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h2E8r-00025J-0L
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:58:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h2E8o-0007Cj-83
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:58:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h2E8o-0006xT-12
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:58:18 -0500
Date: Fri, 8 Mar 2019 12:58:10 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190308115810.6f2dq4ub5t55lnih@sirius.home.kraxel.org>
References: <3246431b-8d6e-f2bc-e0f0-99d80384d97b@redhat.com>
	<87r2bigarf.fsf@zen.linaroharston>
	<a6d25edf-1386-655e-6fd8-3b121838b00b@redhat.com>
	<CAFEAcA_ybrfeVdGrr=fWRg8xR1Yj33xySjX14-JmPvBySqKF8w@mail.gmail.com>
	<62408d6c-5a61-ffb2-f810-6ef36703b277@redhat.com>
	<20190308064743.xe4govhrfdsrzns3@sirius.home.kraxel.org>
	<CAFEAcA_nb_s-DGQTf3GRMcN+9ke8XKyzf_n9QfpeCcKCoA439A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_nb_s-DGQTf3GRMcN+9ke8XKyzf_n9QfpeCcKCoA439A@mail.gmail.com>
Subject: Re: [Qemu-devel] converting build system to Meson?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Fri, Mar 08, 2019 at 10:31:20AM +0000, Peter Maydell wrote:
> On Fri, 8 Mar 2019 at 06:47, Gerd Hoffmann <kraxel@redhat.com> wrote:
> > I stopped using in-tree builds years ago.  When test-building different
> > configurations using an build/$cfgname out-of-tree build directory is
> > the only sane approach.
> 
> Yes. The other big advantage for me is being able to blow away
> the whole build tree and recreate it if necessary.

Yes.  Easy way to force a full rebuild, which seems to be needed now and
then because the dependency tracking of our build system isn't perfect.

> > And IIRC I've managed to break in-tree builds
> > because of that.
> 
> I think in fact I have just broken in-tree builds with the
> Sphinx support patchset :-/

Great opportunity!  Stop supporting in-tree build fixes a bug,
so this can be merged post soft-freeze.

cheers,
  Gerd
