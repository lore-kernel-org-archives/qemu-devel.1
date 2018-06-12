Received: from eggs.gnu.org ([2001:4830:134:3::10]:48123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSldq-0000tQ-Jh
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:55:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSldp-0002W9-PX
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:55:30 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:37130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fSldp-0002V7-DX
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 11:55:29 -0400
Received: by mail-oi0-x22f.google.com with SMTP id l22-v6so21569913oib.4
	for <qemu-devel@nongnu.org>; Tue, 12 Jun 2018 08:55:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180612175241.7340be80@bahia.lab.toulouse-stg.fr.ibm.com>
References: <20180612064503.14282-1-david@gibson.dropbear.id.au>
	<CAFEAcA85qHjDLBYxWW9i4T91m1uTS6TAY_y2A6_840n-_tDZKw@mail.gmail.com>
	<20180612175241.7340be80@bahia.lab.toulouse-stg.fr.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Jun 2018 16:55:08 +0100
Message-ID: <CAFEAcA8yKyHX-xVx5VPxBOy7-hiKDo+DgztVZ_sD5FxK77Z-9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/33] ppc-for-3.0 queue 20180612
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>

On 12 June 2018 at 16:52, Greg Kurz <groug@kaod.org> wrote:
> On Tue, 12 Jun 2018 15:34:22 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
>> On 12 June 2018 at 07:44, David Gibson <david@gibson.dropbear.id.au> wrote:
>> > ----------------------------------------------------------------
>> > ppc patch queue 2018-06-12
>> >
>> > Here's another batch of ppc patches towards the 3.0 release.  There's
>> > a fair bit here, because I've been working through my mail backlog
>> > after a holiday.  There's not much of a central theme, amongst other
>> > things we have:
>> >     * ppc440 / sam460ex improvements
>> >     * logging and error cleanups
>> >     * 40p (PReP) bugfixes
>> >     * Macintosh fixes and cleanups
>> >     * Add emulation of the new POWER9 store-forwarding barrier
>> >       instruction variant
>> >     * Hotplug cleanups
>> >
>>
>> Applied, thanks.

> Oh... so we've broken bisect until Cedric's fix is merged.

If you want me not to merge a pullreq you need to follow up to
the cover letter saying "please don't merge this" or something
similar. Otherwise I will not notice.

thanks
-- PMM
