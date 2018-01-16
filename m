Received: from eggs.gnu.org ([2001:4830:134:3::10]:48280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebOqc-0007oO-0g
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 05:52:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebOqb-0001l0-1v
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 05:52:06 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:44385)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebOqa-0001kf-SM
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 05:52:04 -0500
Received: by mail-ot0-x241.google.com with SMTP id t20so3880271ote.11
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 02:52:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <75638e52-8c52-498a-7dca-fe2a1dae2573@redhat.com>
References: <1516008655-31732-1-git-send-email-thuth@redhat.com>
	<alpine.BSF.2.21.1801151238370.57536@zero.eik.bme.hu>
	<75638e52-8c52-498a-7dca-fe2a1dae2573@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 10:51:43 +0000
Message-ID: <CAFEAcA_v6xk=ReowvgaGiwktF-Dnu0ZfKXtoMovmqkfLKv_gGw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 0/2] Clean up the ppc default
 configs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On 16 January 2018 at 10:41, Thomas Huth <thuth@redhat.com> wrote:
> On 15.01.2018 13:00, BALATON Zoltan wrote:
> [...]
>> I've also noticed that most of the boards were available both in ppcemb
>> and ppc targets so maybe these could be merged now to avoid confusion
>> but I don't know the reason why ppcemb existed in the first place so I
>> don't know what other implications dropping ppcemb may have.
>
> FYI: I've had a chat with Alexander Graf this morning in IRC, and the
> qemu-system-ppcemb was indeed only created for supporting the CPUs with
> page sizes < 4k. Everything else is supposed to work with
> qemu-system-ppc, too. Since likely nobody is using page sizes < 4k on
> embedded PPCs nowadays anymore (and Alex was also only aware of one
> home-brew OS that did this in the past is likely not available now
> anymore), I think we can go forward and start the deprecation of ppcemb.

We do now support runtime-settable page sizes (as a board model property),
so you could roll support for 1K pages into ppc-softmmu/ppc64-softmmu
if you wanted.

thanks
-- PMM
