Received: from eggs.gnu.org ([209.51.188.92]:33233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghcem-00085E-AE
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghcek-0005Xw-MT
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:54:07 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ghcek-0005Xd-Fs
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:54:06 -0500
Received: by mail-ot1-x341.google.com with SMTP id f18so10299495otl.11
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 07:54:06 -0800 (PST)
MIME-Version: 1.0
References: <20190107163117.16269-1-peter.maydell@linaro.org>
	<20190107163117.16269-25-peter.maydell@linaro.org>
	<20190109055856.GA30631@comcast.net>
In-Reply-To: <20190109055856.GA30631@comcast.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 Jan 2019 15:53:53 +0000
Message-ID: <CAFEAcA__X_w5Dk1FjM_-bF-Ged_uchjpMagxr27-PwcqNaokRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 24/37] qtest: Add set_irq_in command to set
 IRQ/GPIO level
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthew Ogilvie <mmogilvi+qemu@zoho.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 9 Jan 2019 at 05:59, Matthew Ogilvie <mmogilvi+qemu@zoho.com> wrote=
:
>
> On Mon, Jan 07, 2019 at 04:31:04PM +0000, Peter Maydell wrote:
> > From: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> >
> > Adds a new qtest command "set_irq_in" which allows
> > to set qemu gpio lines to a given level.
> >
> > Based on https://lists.gnu.org/archive/html/qemu-devel/2012-12/msg02363=
.html
> > which never got merged.
> >
> > Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Message-id: 20190103091119.9367-2-stefanha@redhat.com
> > Originally-by: Matthew Ogilvie <mmogilvi_qemu@miniinfo.net>
>
> It is kind of interesting to see a part of my old thread(s)
> resurrected, even if it isn't the part I was actually interested
> in.
>
> Note that my miniinfo email account no longer exists, but I
> can still be reached at mmogilvi+qemu@zoho.com if desired.
>
> Regarding the patch, I haven't kept up with changes to qemu
> well enough to really have a useful opinion, although superficially
> it looks good.  Perhaps it would make sense to include both
> my old and new email addresses in the sign-off section, to both
> tie it to the old threads and make it easier to reach me
> if someone wants to contact me?  (But I'm not sure of a "clean"
> way to do so, and it is probably low priority.  Perhaps this
> current email is good enough?)

Thanks for the followup. Unfortunately the commit is already
in master so we can't tweak the commit message at this point.
That shouldn't matter much, people don't often fish emails out
of old commit message logs to email anyway :-)

thanks
-- PMM
