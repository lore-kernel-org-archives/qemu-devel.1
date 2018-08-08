Received: from eggs.gnu.org ([2001:4830:134:3::10]:56597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fnOop-0002SQ-4b
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 09:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fnOoo-0005qA-Ar
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 09:48:07 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:46824)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fnOoo-0005q1-40
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 09:48:06 -0400
Received: by mail-oi0-x243.google.com with SMTP id y207-v6so3733364oie.13
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 06:48:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87k1p11foc.fsf@trasno.org>
References: <20180807130355.29780-1-peter.maydell@linaro.org>
	<87muty2u57.fsf@trasno.org>
	<CAFEAcA_m+81aDQR=n=8gXhcifYp0L6n9KZA5COQsRejeqZe2FQ@mail.gmail.com>
	<87in4m2qni.fsf@trasno.org>
	<CAFEAcA81Xr6_eUV5247JtZRnN9Ms7fau1iwhHkmW-gnwH9y8JA@mail.gmail.com>
	<87wot21bbt.fsf@trasno.org>
	<CAFEAcA_y1qKsC8kSDee+FEpqZstz9UHTeyP6ABuGfXf_aDMRHw@mail.gmail.com>
	<87o9ee1aka.fsf@trasno.org>
	<CAFEAcA_XJGWPioUDUR0+9v16Xj_osDwk7OYEK3vkqdg_SacMXA@mail.gmail.com>
	<87k1p11foc.fsf@trasno.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Aug 2018 14:47:44 +0100
Message-ID: <CAFEAcA_HVcjORfefJXMB3cG=cCt5njDQVCeOFjF-h_KSPOT22w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] migration: Correctly handle subsections
 with no 'needed' function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 8 August 2018 at 08:27, Juan Quintela <quintela@redhat.com> wrote:
>
> This is part of the problem.  For some architectures, we don't even care
> about migraiton.  For others, we care about migration but not
> cross-version.  And yet in others we care very much (downstream
> specially).

I think we should care about migration on all architectures
and devices, in the sense that we want savevm/loadvm to work.
This is a really useful debugging and user tool, and when
I'm reviewing devices it's the minimum bar I think new
devices should clear. You then get migration "for free" but
I don't particularly expect it to be used compared to
snapshot save/restore. (Of course some of our existing code
doesn't support this, and we don't have a good way of testing
so bugs creep in easily, but as a principle I think it's
good.)

thanks
-- PMM
