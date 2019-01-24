Received: from eggs.gnu.org ([209.51.188.92]:56332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmjl1-0004gg-Nh
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 13:29:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmjkz-00077o-Pv
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 13:29:43 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41745)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmjkx-00070V-Oj
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 13:29:41 -0500
Received: by mail-oi1-x243.google.com with SMTP id j21so5657727oii.8
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 10:29:34 -0800 (PST)
MIME-Version: 1.0
References: <20190121144841.24467-1-anthony.perard@citrix.com>
	<CAFEAcA_ytAb-K-HB3wL5baMBDkY71ksBK8hsUSFxuUeqVDFyHQ@mail.gmail.com>
	<804f8429-d3f6-dc1a-4980-fc5a44a6b3c5@msgid.tls.msk.ru>
	<87fttijvfm.fsf@dusky.pond.sub.org>
	<9a1725c3-1119-886d-2d9d-11369ea5f207@redhat.com>
In-Reply-To: <9a1725c3-1119-886d-2d9d-11369ea5f207@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Jan 2019 18:29:21 +0000
Message-ID: <CAFEAcA-qKrCSc0U2hWDzsHyrEaMtPVQ1A6o6FFvtucg0tnaM2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: Don't add Xen's libs to LDFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>, Stefano Stabellini <sstabellini@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, Paul Durrant <paul.durrant@citrix.com>, Anthony PERARD <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>

On Thu, 24 Jan 2019 at 17:40, Eric Blake <eblake@redhat.com> wrote:
>
> On 1/24/19 2:45 AM, Markus Armbruster wrote:
>
> >> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> >> Revieved-by: Michael Tokarev <mjt@tls.msk.ru>
> >
> > Typo in Reviewed-by.
>
> Should we tighten checkpatch.pl to flag suspicious-looking 'xxx-by:'
> tags, to catch instances of typos?

Yes, I would vote for having it whitelist the half a dozen
expected ones and complain about the rest. I think we
kind of discussed this in the past...

thanks
-- PMM
