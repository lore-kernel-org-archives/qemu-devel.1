Received: from eggs.gnu.org ([209.51.188.92]:37419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3OZc-0001Qn-PL
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3OZb-00048U-VQ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:18:48 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h3OZa-00043O-BU
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:18:47 -0400
Received: by mail-ot1-x341.google.com with SMTP id e15so4652296otk.6
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 10:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190307095441.31921-1-kraxel@redhat.com>
	<20190307095441.31921-4-kraxel@redhat.com>
	<CAFEAcA_HzSj7sQ+aKEwHmJXkJcG8yLmn5ZsZKM5xxYUrBxO2rQ@mail.gmail.com>
	<jpg36nxf8ta.fsf@linux.bootlegged.copy>
	<jpg8sxpypx2.fsf_-_@linux.bootlegged.copy>
	<CAFEAcA_3=cQDHibDe++d+6UpkHhKMP8=s4iJYbqUVeJdDQv+fQ@mail.gmail.com>
	<jpg8sxle6c6.fsf@linux.bootlegged.copy>
	<CAFEAcA9sx64kcz=wOqeBwGg0YJc-xO-K5yNkoSC8uuCqNF_FYA@mail.gmail.com>
	<jpgef7d746o.fsf@linux.bootlegged.copy>
In-Reply-To: <jpgef7d746o.fsf@linux.bootlegged.copy>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Mar 2019 17:18:29 +0000
Message-ID: <CAFEAcA_U=1w2krP9zrC3oXjhJZ1Y5k+2GP_s3oY0p8WvB_9hig@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] usb-mtp: fix return status of delete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 11 Mar 2019 at 16:43, Bandan Das <bsd@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > On Mon, 11 Mar 2019 at 16:14, Bandan Das <bsd@redhat.com> wrote:
> > Generally, if you have multiple bits X, Y in a return
> > value, they should be independent. Sometimes we define
> > a convenience value Z that's X | Y, but then Z should
> > have a name that indicates that it's really doing both
> > X and Y (for instance often a READWRITE constant will
> > be READ | WRITE). In this case, I don't see why
> > PARTIAL_DELETE would be a sensible name to indicate
> > "both ALL_DELETE and also READ_ONLY" -- if we only
> > partially did a delete why do we set the ALL_DELETE bit ?
> >
>
> Because during a recursive call, we were able to successfully
> delete objects(s) for the previous call but for "this"
> set of objects, it failed which is supposed to return a
> partial_delete back.
>
> Does simply "DELETE" instead of "ALL_DELETE" seem less
> confusing ? I definitely want to keep PARTIAL_DELETE the
> way it is simply because it's easier to refer back
> to the spec that way.

I think this would be easier to answer if you answered
this question:

> > It might be useful to take a step back -- what are
> > the different possible outcomes from this function that
> > we need to distinguish, and when should we be returning
> > which outcome?

thanks
-- PMM
