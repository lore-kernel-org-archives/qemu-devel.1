Received: from eggs.gnu.org ([2001:4830:134:3::10]:49534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wlosh@bsdimp.com>) id 1fLAEz-0007EL-UM
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:34:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wlosh@bsdimp.com>) id 1fLAEy-0000GF-Um
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:34:25 -0400
Received: from mail-it0-x232.google.com ([2607:f8b0:4001:c0b::232]:52788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <wlosh@bsdimp.com>) id 1fLAEy-0000Ex-Mq
	for qemu-devel@nongnu.org; Tue, 22 May 2018 12:34:24 -0400
Received: by mail-it0-x232.google.com with SMTP id y189-v6so706968itb.2
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 09:34:24 -0700 (PDT)
MIME-Version: 1.0
Sender: wlosh@bsdimp.com
In-Reply-To: <CAFEAcA-xqG+9SZ2_K5XFooJuKYyuRoL51K1JuwQ-SWGcCYcX=A@mail.gmail.com>
References: <CAFEAcA9a-xrtibHYb4+-xu3QVmW3tJ1v9X0s_X_PMhQGFSJgdg@mail.gmail.com>
	<CANCZdfpNMR_buj3L4xvqhh_T4QZOvV5JsXHK2Rzk-zs5iHvGrg@mail.gmail.com>
	<CAFEAcA-xqG+9SZ2_K5XFooJuKYyuRoL51K1JuwQ-SWGcCYcX=A@mail.gmail.com>
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 22 May 2018 10:34:23 -0600
Message-ID: <CANCZdfq0_-t+HZhYmGOt0uCLd2p1VNUythUKrCMJffTtrWhz9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] QEMU 3.0 proposed release schedule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On Tue, May 22, 2018 at 9:50 AM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 22 May 2018 at 16:39, Warner Losh <imp@bsdimp.com> wrote:
> > On Tue, May 22, 2018 at 9:24 AM, Peter Maydell <peter.maydell@linaro.org
> >
> > wrote:
> >>
> >> I've put up a draft release schedule at:
> >> https://wiki.qemu.org/Planning/3.0
> >>
> >> 2018-04-24      Beginning of development phase
> >> 2018-07-03      Soft feature freeze.
> >> 2018-07-10      Hard feature freeze. Tag rc0
> >> 2018-07-17      Tag rc1
> >> 2018-07-24      Tag rc2
> >> 2018-07-31      Tag rc3
> >> 2018-08-07      Release, or if necessary, tag rc4
> >> 2018-08-14      Release, if we needed rc4
>
> > I'd love to get bsd-user into 3.0. At the moment, all the changes are in
> > bsd-user, and my cleanup is trending to about 50 patches. Given
> traditional
> > timelines, when should I submit patches to the mailing list for that?
>
> The usual recommendation is to submit early and often.
>

Should I do a RFC or preview submission then of the first dozen patches
maybe as I work out integrating back the bug/compile fixes into the early
series? I'd love to get feedback, but don't want to waste people's time on
something that I've not compile tested every change on (just the final
results, which stands today at ~125 changes, but last week was at 200).

Warner
