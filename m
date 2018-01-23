Received: from eggs.gnu.org ([2001:4830:134:3::10]:59277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edvWG-0002il-Ph
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:09:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1edvWF-0003gd-Sq
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:09:32 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:37634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1edvWF-0003gK-Np
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:09:31 -0500
Received: by mail-ot0-x243.google.com with SMTP id a24so10185166otd.4
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 02:09:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA960L3EX6cYFjw6BWueowa-ASn+N-Hwb4QOCisou802EA@mail.gmail.com>
References: <20180115115309.23982-1-quintela@redhat.com>
	<CAFEAcA8AMejrf1P26QX1xne2+JvYziBvT1Q-HjcC2Pa=40gB6A@mail.gmail.com>
	<20180122123810.GA2628@work-vm>
	<CAFEAcA960L3EX6cYFjw6BWueowa-ASn+N-Hwb4QOCisou802EA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jan 2018 10:09:10 +0000
Message-ID: <CAFEAcA94cbq2+wYTfh3d9e8Vd0mFEirFumkqytqrH3FW7ArKzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/27] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>

On 22 January 2018 at 13:38, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 22 January 2018 at 12:38, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
>> It's probably better to remove the whole set of 6, then we can come
>> back to it later rather than leaving something half-implemented in
>> there.
>
> OK. I'm currently running a commit with
>  git revert --no-commit 31bf06a9d6844d^..ca6011c232912
> through my build tests, though I'll hold off on actually pushing it
> for a bit to give people time to comment.

I've now pushed this revert to master.

thanks
-- PMM
