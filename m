Received: from eggs.gnu.org ([2001:4830:134:3::10]:44885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTpvp-0004Lj-Nf
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:14:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTpvi-0000Db-Vb
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:14:45 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gTpvi-0000Cy-RE
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:14:38 -0500
Received: by mail-ot1-x343.google.com with SMTP id u16so11878714otk.8
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 07:14:38 -0800 (PST)
MIME-Version: 1.0
References: <20181126182844.23109-1-minyard@acm.org>
	<d7a7cb4a-a55d-ec84-4bd8-89ef3fad7ebf@mvista.com>
	<20181129104930-mutt-send-email-mst@kernel.org>
	<94fea825-f77b-760f-d093-eccc137594d8@redhat.com>
In-Reply-To: <94fea825-f77b-760f-d093-eccc137594d8@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Dec 2018 15:14:26 +0000
Message-ID: <CAFEAcA9ucZbWUv0LurwB51+_mKjD1D-LM3Y6o5W9W1LNsa5gWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-3.1?] pc:piix4: Update smbus I/O space
 after a migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Corey Minyard <cminyard@mvista.com>, Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Corey Minyard <minyard@acm.org>

On Thu, 29 Nov 2018 at 16:44, Eric Blake <eblake@redhat.com> wrote:
>
> On 11/29/18 9:49 AM, Michael S. Tsirkin wrote:
> > On Thu, Nov 29, 2018 at 09:45:17AM -0600, Corey Minyard wrote:
> >> On 11/26/18 12:28 PM, minyard@acm.org wrote:
> >>> From: Corey Minyard <cminyard@mvista.com>
> >>>
> >>> Otherwise it won't be set up correctly and won't work after
> >>> miigration.
> >>
> >> Any opinions on this?  I think this would be good for 3.1. Without
> >> this when a migration occurs on piix4 the SMBus address space
> >> appears in the wrong place.  I'm not sure how bad that is, but
> >> SMBus certainly ceases to work.
> >>
> >> -corey
> >
> >
> > I have this queued. Thanks!
>
> We've missed -rc3. Is the problem this patch addresses severe enough to
> warrant -rc4? Is it a regression since 3.0?

The git history of the file suggests it's been like this for
at least five years, so I would suggest this is not worth
putting into -rc4 (we will have an rc4). Happy to hear
contrary views, but I don't want to bloat rc4 out more
than we can avoid...

thanks
-- PMM
