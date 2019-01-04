Received: from eggs.gnu.org ([208.118.235.92]:43757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfOpT-0003OP-Ua
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 07:44:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfOpT-00012y-Ab
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 07:43:59 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfOpT-0000yA-3k
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 07:43:59 -0500
Received: by mail-oi1-x242.google.com with SMTP id j21so30250482oii.8
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 04:43:58 -0800 (PST)
MIME-Version: 1.0
References: <20190104090610.652-1-clg@kaod.org>
	<CAFEAcA9qKgxY=u4YdymWz3oEDx8Fu-Z5_PfSaznxuWWY-m+=ZA@mail.gmail.com>
	<12292c86-0e43-f969-311b-0eaa83254767@kaod.org>
In-Reply-To: <12292c86-0e43-f969-311b-0eaa83254767@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 12:43:47 +0000
Message-ID: <CAFEAcA-cawceysk6Yx+FTU5tyiUGRjtrrDATa4Jhh+pDAdZSAQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] spapr: return from post_load method when
 RTC import fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 4 Jan 2019 at 12:31, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> On 1/4/19 11:08 AM, Peter Maydell wrote:
> > On Fri, 4 Jan 2019 at 09:07, C=C3=A9dric Le Goater <clg@kaod.org> wrote=
:
> >>
> >> The error value can be squashed by the section handling radix migratio=
n.
> >> Simply bail out if an error occurs when the RTC offset is imported.
> >>
> >> Fixes: d39c90f5f3ae ("spapr: Fix migration of Radix guests")
> >
> > You could also mention that this fixes the Coverity
> > issue CID 1398591.
>
> ok. I will in a v2.
>
> Is there a tag for it ?
>
> or adding a comment "this fixes the Coverity issue CID 1398591."
> is considered sufficient ?


No, we don't have a formal tag for that kind of thing.

thanks
-- PMM
