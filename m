Received: from eggs.gnu.org ([2001:4830:134:3::10]:57966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gHP3K-0000eo-Nj
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gHP3H-0001qF-JU
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:07:06 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gHP3H-0001p5-Ee
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:07:03 -0400
Received: by mail-qt1-f196.google.com with SMTP id u34-v6so12427852qth.3
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 01:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20181029125733.14597-1-marcandre.lureau@redhat.com>
	<20181030054848.GF22523@xz-x1>
In-Reply-To: <20181030054848.GF22523@xz-x1>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 30 Oct 2018 12:06:51 +0400
Message-ID: <CAMxuvawJnOXvJYFPGQ-5Vutmft+RwV616FxTtZk1i8K8NhGTWA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/6] monitor: misc fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Armbruster, Markus" <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Tue, Oct 30, 2018 at 9:48 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Oct 29, 2018 at 04:57:27PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi,
> >
> > Here is a small series of fixes for the monitor, mostly related to
> > threading issues.
>
> Hi, Marc-Andr=C3=A9, Markus,
>
> I'd be glad to know how you think about these monitor series,
> considering that I just noticed it's exactly softfreeze for QEMU 3.1
> today...
>
> I gave a quick look on this series, IMHO patch 1,2,6 could be
> candidate for 3.1 (though I'm not sure for patch 6; it seems even fine
> to me with some comments there but I'd like to see how other people
> think about it too, and whether it's really possible to insert a new
> monitor at that time) and I'm not sure whether the rest can be

Patch 5 & 6 are the result of the discussion of the previous proposed fixed=
:
https://lists.nongnu.org/archive/html/qemu-devel/2018-08/msg00018.html

They fix a dead-lock on cleanup, so it should be considered for 3.1.

> postponed (say, patch 3,4,5).  Meanwhile, I think we need Wolfgang's

Patch 3 & 4 should also be considered, as OOB won't have the expected
behaviour with all chardevs. With non-gcontext feature chardev, they
will behave more or less like non-oob.

> patches to fix the daemonize chaos, and hopefully I also like to know
> your thoughts on my oob enablement series (especially Marc-Andr=C3=A9,
> since I talked to Markus face to face during the forum after all :).
> I would like it to be in 3.1 as well but I'll see my luck.

I acked the series already (except "monitor: resume the monitor
earlier if needed" which we agreed could be dropped for now), so it's
in Markus hand.

Thanks
