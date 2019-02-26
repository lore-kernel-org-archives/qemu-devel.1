Received: from eggs.gnu.org ([209.51.188.92]:41253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyi6o-0003fX-Py
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:09:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gyi6n-0004Fv-Ob
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:09:42 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37056)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gyi6n-0004FU-I4
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 14:09:41 -0500
Received: by mail-oi1-x241.google.com with SMTP id w66so11281918oia.4
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 11:09:41 -0800 (PST)
MIME-Version: 1.0
References: <20190225123111.30363-1-berrange@redhat.com>
	<CAFEAcA9_AeKMZxrGE7pSp0j1JSSWTLCk2g7aP=QCtTWGNFposQ@mail.gmail.com>
	<41d3532c-0ab4-db82-dc9a-cc9fb45c6162@redhat.com>
In-Reply-To: <41d3532c-0ab4-db82-dc9a-cc9fb45c6162@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Feb 2019 19:09:29 +0000
Message-ID: <CAFEAcA-zo+mVS_H7dU2uM83Ndv_f_0BDSBS_jxJs1e7L+=0R5w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/11] Merge authz core patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

On Tue, 26 Feb 2019 at 19:07, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 2/26/19 8:04 PM, Peter Maydell wrote:
> > On Mon, 25 Feb 2019 at 12:35, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> >>
> >> The following changes since commit 8eb29f1bf5a974dc4c11d2d1f5e7c7f7a62=
be116:
> >>
> >>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-201=
90221.0' into staging (2019-02-22 15:48:04 +0000)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://github.com/berrange/qemu tags/authz-core-pull-request
> >>
> >> for you to fetch changes up to cfde05c6c0db7d3122a5491d50f62f7910ab8ab=
b:
> >>
> >>   authz: delete existing ACL implementation (2019-02-25 12:28:25 +0000=
)
> >>
> >> ----------------------------------------------------------------
> >> Add a standard authorization framework
> >>
> >> The current network services now support encryption via TLS and in som=
e
> >> cases support authentication via SASL. In cases where SASL is not
> >> available, x509 client certificates can be used as a crude authorizati=
on
> >> scheme, but using a sub-CA and controlling who you give certs to. In
> >> general this is not very flexible though, so this series introduces a
> >> new standard authorization framework.
> >>
> >
> > Applied, thanks.
>
> Argh there is a v2... Daniel didn't NACK'd this one.

Oops. Yes, I process my pullreq queue oldest-first and unless you
follow up to the cover letter to say "don't apply this v1" I'm
not necessarily going to notice a v2. I'm afraid you'll have to
send whatever the v1->v2 fixes were as a separate set of patches now.

thanks
-- PMM
