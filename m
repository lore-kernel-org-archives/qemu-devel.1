Received: from eggs.gnu.org ([209.51.188.92]:54433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3Njs-0003Dn-PR
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:25:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3Njq-0005J0-Uv
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:25:20 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:43098)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h3Njp-0005H2-Iv
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 12:25:17 -0400
Received: by mail-oi1-x232.google.com with SMTP id i8so4126586oib.10
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 09:25:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190307095441.31921-1-kraxel@redhat.com>
	<20190307095441.31921-4-kraxel@redhat.com>
	<CAFEAcA_HzSj7sQ+aKEwHmJXkJcG8yLmn5ZsZKM5xxYUrBxO2rQ@mail.gmail.com>
	<jpg36nxf8ta.fsf@linux.bootlegged.copy>
	<jpg8sxpypx2.fsf_-_@linux.bootlegged.copy>
	<CAFEAcA_3=cQDHibDe++d+6UpkHhKMP8=s4iJYbqUVeJdDQv+fQ@mail.gmail.com>
	<jpg8sxle6c6.fsf@linux.bootlegged.copy>
In-Reply-To: <jpg8sxle6c6.fsf@linux.bootlegged.copy>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Mar 2019 16:25:05 +0000
Message-ID: <CAFEAcA9sx64kcz=wOqeBwGg0YJc-xO-K5yNkoSC8uuCqNF_FYA@mail.gmail.com>
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

On Mon, 11 Mar 2019 at 16:14, Bandan Das <bsd@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
> > At the moment PARTIAL_DELETE is "ALL_DELETE | READ_ONLY", which
> > doesn't seem like it makes much sense.
> >
>
> Sorry, can you please clarify what doesn't make sense ?

Generally, if you have multiple bits X, Y in a return
value, they should be independent. Sometimes we define
a convenience value Z that's X | Y, but then Z should
have a name that indicates that it's really doing both
X and Y (for instance often a READWRITE constant will
be READ | WRITE). In this case, I don't see why
PARTIAL_DELETE would be a sensible name to indicate
"both ALL_DELETE and also READ_ONLY" -- if we only
partially did a delete why do we set the ALL_DELETE bit ?

It might be useful to take a step back -- what are
the different possible outcomes from this function that
we need to distinguish, and when should we be returning
which outcome?

thanks
-- PMM
