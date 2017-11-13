Received: from eggs.gnu.org ([2001:4830:134:3::10]:39100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEBRL-0000Yc-BZ
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:54:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eEBRK-0008OU-EC
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:54:03 -0500
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:54631)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eEBRK-0008OC-81
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:54:02 -0500
Received: by mail-wr0-x236.google.com with SMTP id l22so13846567wrc.11
	for <qemu-devel@nongnu.org>; Mon, 13 Nov 2017 01:54:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <715a7bd1-7aa5-fa64-a9b8-76782ee20576@redhat.com>
References: <20171110152017.24324-1-clg@kaod.org>
	<20171110152017.24324-2-clg@kaod.org>
	<715a7bd1-7aa5-fa64-a9b8-76782ee20576@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2017 09:53:40 +0000
Message-ID: <CAFEAcA_vZ6KNQzsRTeFujf3W7cqXi-Y9qJS0-EtodB24jsQe+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] QEMU 3.0 ? (was: [PATCH for-2.12 v3 01/11] spapr:
 add pseries 2.12 machine type)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>

On 13 November 2017 at 07:14, Thomas Huth <thuth@redhat.com> wrote:
> By the way, before everybody now introduces "2.12" machine types ... is
> there already a consensus that the next version will be "2.12" ?
>
> A couple of months ago, we discussed that we could maybe do a 3.0 after
> 2.11, e.g. here:
>
>  https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg05056.html
>
> I'd still like to see that happen... Peter, any thoughts on this?

I don't see the point in declaring a 3.0 unless we have some
sweeping change that merits it. I don't think we should do a
sweeping change unless we have a well laid out and agreed on
plan for how the transition works. So I would want to see the
plan discussed and agreed first, and then we can say "ok, and
we think we can do this in this timescale and so the version
at $DATE will be 3.0". Changing the version number should be
the last part of this process, not the first, in my view.

thanks
-- PMM
