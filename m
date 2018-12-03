Received: from eggs.gnu.org ([2001:4830:134:3::10]:43118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTppV-0008Lf-Sc
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gTppT-0000fA-Ia
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:08:13 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37171)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gTppR-0000Qz-M8
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 10:08:11 -0500
Received: by mail-ot1-x343.google.com with SMTP id 40so11865664oth.4
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 07:08:04 -0800 (PST)
MIME-Version: 1.0
References: <20181129101801.6421-1-vsementsov@virtuozzo.com>
	<da28be03-4e8a-c75f-8bfa-35e24ad14cca@redhat.com>
In-Reply-To: <da28be03-4e8a-c75f-8bfa-35e24ad14cca@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Dec 2018 15:07:51 +0000
Message-ID: <CAFEAcA8PcESbmM6iuV90nhPFB8cStZTrU=RkpAna+LFBYgFhag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 0/2] mirror dead-lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, dplotnikov@virtuozzo.com, "Denis V. Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 3 Dec 2018 at 14:03, Max Reitz <mreitz@redhat.com> wrote:
>
> On 29.11.18 11:17, Vladimir Sementsov-Ogievskiy wrote:
> > Hi all!
> >
> > v2: add fix:)
> >
> > We've faced the following mirror bug:
> >
> > Just run mirror on qcow2 image more than 1G, and qemu is in dead lock.
>
> So because apparently there is going to be an rc4 anyway (like basically
> always...), I'd really like to bring this fix into it, unless there are
> any objections from anyone (though all of you are more than welcome to
> explicitly agree, too :-)).

Discussion on IRC seemed to lean in favour of putting this fix into
rc4 as well. Could somebody (not sure if this would be you or Kevin)
send a pullrequest with it in today, please ?

thanks
-- PMM
