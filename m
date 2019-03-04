Received: from eggs.gnu.org ([209.51.188.92]:37899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0nnk-0004dR-A5
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 08:38:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h0nnj-0004FC-JC
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 08:38:40 -0500
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:44184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h0nnj-0004DF-DO
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 08:38:39 -0500
Received: by mail-ot1-x333.google.com with SMTP id g1so4201241otj.11
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 05:38:39 -0800 (PST)
MIME-Version: 1.0
References: <20190221173326.31874-1-mst@redhat.com>
	<20190225101718-mutt-send-email-mst@kernel.org>
	<a84fe47c-e755-b13e-b176-89b233820bc7@redhat.com>
In-Reply-To: <a84fe47c-e755-b13e-b176-89b233820bc7@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2019 13:38:26 +0000
Message-ID: <CAFEAcA94uN2ETViEz5ENLgN5CYtm54AeW6j1DXh_VoVKdFppwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 resend 00/26] pci, pc, virtio: fixes,
 cleanups, tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 4 Mar 2019 at 10:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 25/02/19 16:19, Michael S. Tsirkin wrote:
> > The following changes since commit fc3dbb90f2eb069801bfb4cfe9cbc83cf9c5f4a9:
> >
> >   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-02-21 13:09:33 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
> >
> > for you to fetch changes up to 88c869198aa630e0477d653d0abf3f42c7c44d1f
> >
> >   pci: Sanity test minimum downstream LNKSTA (2019-02-21 12:28:41 -0500)
> >
> > ----------------------------------------------------------------
> >
> > Note: this is same as a fixup I sent earlier, this is just a resend to
> > make sure it's not missed.  This should also help me figure out whether
> > this is a good format to use.
>
> You should have sent it as a new toplevel message, too, otherwise Peter
> doesn't see it.

No, my filter doesn't care about top level messages or not (though
sending as a new top level message is a good idea). I'm not sure
why this slipped through the net.

In any case, now applied, thanks. Please update the changelog for
any user-visible changes.

-- PMM
