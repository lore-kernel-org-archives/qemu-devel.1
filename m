Received: from eggs.gnu.org ([2001:4830:134:3::10]:55024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOV7g-0001pH-PX
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 15:56:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOV7c-0005er-PH
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 15:56:21 -0500
Received: from mail-ot0-x236.google.com ([2607:f8b0:4003:c0f::236]:46592)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eOV7c-0005XJ-JM
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 15:56:20 -0500
Received: by mail-ot0-x236.google.com with SMTP id j2so15942813ota.13
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 12:56:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171211194213.GA4200@flamenco>
References: <1513006964-3371-1-git-send-email-peter.maydell@linaro.org>
	<db0d2fd0-ae95-b9f8-47a7-d273306a2432@twiddle.net>
	<CAFEAcA_ezdp_ygjT2r9P7niSnOqRxAMUJ+vhaMk4HJTSrEjrJQ@mail.gmail.com>
	<20171211194213.GA4200@flamenco>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Dec 2017 20:55:56 +0000
Message-ID: <CAFEAcA-=XHydnzmV7uEydfFR=fYzYsGSUfaR+L5V0mMTLcX+yw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.11?] target/arm: Generate UNDEF for
 32-bit Thumb2 insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 11 December 2017 at 19:42, Emilio G. Cota <cota@braap.org> wrote:
> On Mon, Dec 11, 2017 at 17:32:48 +0000, Peter Maydell wrote:
>> Thanks. I think I have come down on the side of putting this into
>> 2.11, so rolling an rc5 today, and delaying the final release
>> a day to Wednesday.
>
> Glad to see it's in -rc5 -- thanks for fixing this so quickly!
>
> Again, apologies for not having caught this earlier ;-(

It's my own fault really -- my extremely ad-hoc approach
to testing for Arm guests was bound to come back and
bite me sooner or later.

thanks
-- PMM
