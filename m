Received: from eggs.gnu.org ([2001:4830:134:3::10]:45404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEBsI-0002Xn-WF
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:22:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEBsI-0006na-6q
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:21:54 -0500
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:46009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEBsI-0006nG-0c
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 05:21:54 -0500
Received: by mail-wr0-x22a.google.com with SMTP id y9so13956742wrb.2
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 02:21:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b65a5baf-e2a8-ec3a-7c28-4046a2fc8dec@kaod.org>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-2-clg@kaod.org>
	<715a7bd1-7aa5-fa64-a9b8-76782ee20576@redhat.com>
	<CAFEAcA_vZ6KNQzsRTeFujf3W7cqXi-Y9qJS0-EtodB24jsQe+w@mail.gmail.com>
	<b65a5baf-e2a8-ec3a-7c28-4046a2fc8dec@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 10:21:32 +0000
Message-ID: <CAFEAcA_+GHLNa-kCXgiiJaBCTJrUr-AoVXK_6rd5ukDuuzvZTg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] QEMU 3.0 ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

On 13 November 2017 at 10:03, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> One of the sweeping change for 3.0 could be to stop to maintaining
> migration compatibility with older versions (2.x). Even if the
> feature is really a must have in some cluster environment, the
> code (and the developer) is starting to suffer from it.

We certainly can't just drop all migration-compat. The closest
we might come would be to say we dropped migration-compat
from versions older than $X for some value of X.

But this kind of discussion is what I mean -- various
people have different ideas about what we might or might
not drop, but we need to come to a consensus about what
we can actually do first.

thanks
-- PMM
