Received: from eggs.gnu.org ([2001:4830:134:3::10]:47492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJjgR-0006dc-Ro
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:28:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eJjgQ-00077Q-Qb
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:28:35 -0500
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:40513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eJjgQ-000770-L9
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 12:28:34 -0500
Received: by mail-ot0-x236.google.com with SMTP id e74so553526ote.7
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 09:28:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a92ce6e2-0d7d-8db2-e12f-418b77e8abd4@redhat.com>
References: <20171128121055.6954-1-den@openvz.org>
	<20171128160805.GE3703@localhost.localdomain>
	<b5cb007b-7a6a-c8a0-b551-2efdc4b0cdac@openvz.org>
	<a92ce6e2-0d7d-8db2-e12f-418b77e8abd4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Nov 2017 17:28:13 +0000
Message-ID: <CAFEAcA8Ak5FNNOSujRARVOL78n4v40W-ZfC4n4Bi6imMPJs_FQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for 2.11 0/2] QEMU crashes with CD device
 without media
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

On 28 November 2017 at 17:01, John Snow <jsnow@redhat.com> wrote:
> It's not your fault, it's mine for letting this go for a release. It's
> just unfortunate timing. I'm looking at (at least) the IDE portion of
> this and the underlying cause in block-backend today.

If it's not a regression, and nobody reported it for the whole release
cycle, we might choose to not fix it in 2.11...

thanks
-- PMM
