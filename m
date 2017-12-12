Received: from eggs.gnu.org ([2001:4830:134:3::10]:59904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOi1l-0003vU-4s
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 05:43:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eOi1g-0007GM-Uo
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 05:43:09 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:43225)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eOi1g-0007FR-OH
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 05:43:04 -0500
Received: by mail-ot0-x244.google.com with SMTP id y10so17383924otg.10
	for <qemu-devel@nongnu.org>; Tue, 12 Dec 2017 02:43:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171212024808.GB2790@xz-mi>
References: <1513006964-3371-1-git-send-email-peter.maydell@linaro.org>
	<db0d2fd0-ae95-b9f8-47a7-d273306a2432@twiddle.net>
	<CAFEAcA_ezdp_ygjT2r9P7niSnOqRxAMUJ+vhaMk4HJTSrEjrJQ@mail.gmail.com>
	<20171211194213.GA4200@flamenco>
	<CAFEAcA-=XHydnzmV7uEydfFR=fYzYsGSUfaR+L5V0mMTLcX+yw@mail.gmail.com>
	<20171212024808.GB2790@xz-mi>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2017 10:42:43 +0000
Message-ID: <CAFEAcA-rYD_eN6P_bjg=RoTaD+71qk04oKZ3J_7_kVxbcxKoGQ@mail.gmail.com>
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
To: Peter Xu <peterx@redhat.com>
Cc: "Emilio G. Cota" <cota@braap.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On 12 December 2017 at 02:48, Peter Xu <peterx@redhat.com> wrote:
> On Mon, Dec 11, 2017 at 08:55:56PM +0000, Peter Maydell wrote:
>> On 11 December 2017 at 19:42, Emilio G. Cota <cota@braap.org> wrote:
>> > On Mon, Dec 11, 2017 at 17:32:48 +0000, Peter Maydell wrote:
>> >> Thanks. I think I have come down on the side of putting this into
>> >> 2.11, so rolling an rc5 today, and delaying the final release
>> >> a day to Wednesday.
>> >
>> > Glad to see it's in -rc5 -- thanks for fixing this so quickly!
>> >
>> > Again, apologies for not having caught this earlier ;-(
>>
>> It's my own fault really -- my extremely ad-hoc approach
>> to testing for Arm guests was bound to come back and
>> bite me sooner or later.
>
> Should we include the vfio fix in too for rc5?
>
>   http://patchwork.ozlabs.org/patch/844940/
>
> I see that the tag is there already, not sure whether it means it
> missed the chance again...  Thanks,

It did miss the chance, but in any case that vfio fix is
not a regression from 2.10, so it doesn't meet the
criteria to go in now.

thanks
-- PMM
