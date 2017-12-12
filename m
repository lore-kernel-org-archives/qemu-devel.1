Received: from eggs.gnu.org ([2001:4830:134:3::10]:48171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eOacE-0004SV-3Y
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 21:48:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eOacA-0004gC-TZ
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 21:48:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39558)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eOacA-0004eI-N2
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 21:48:14 -0500
Date: Tue, 12 Dec 2017 10:48:08 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171212024808.GB2790@xz-mi>
References: <1513006964-3371-1-git-send-email-peter.maydell@linaro.org>
	<db0d2fd0-ae95-b9f8-47a7-d273306a2432@twiddle.net>
	<CAFEAcA_ezdp_ygjT2r9P7niSnOqRxAMUJ+vhaMk4HJTSrEjrJQ@mail.gmail.com>
	<20171211194213.GA4200@flamenco>
	<CAFEAcA-=XHydnzmV7uEydfFR=fYzYsGSUfaR+L5V0mMTLcX+yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-=XHydnzmV7uEydfFR=fYzYsGSUfaR+L5V0mMTLcX+yw@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Emilio G. Cota" <cota@braap.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, "patches@linaro.org" <patches@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Mon, Dec 11, 2017 at 08:55:56PM +0000, Peter Maydell wrote:
> On 11 December 2017 at 19:42, Emilio G. Cota <cota@braap.org> wrote:
> > On Mon, Dec 11, 2017 at 17:32:48 +0000, Peter Maydell wrote:
> >> Thanks. I think I have come down on the side of putting this into
> >> 2.11, so rolling an rc5 today, and delaying the final release
> >> a day to Wednesday.
> >
> > Glad to see it's in -rc5 -- thanks for fixing this so quickly!
> >
> > Again, apologies for not having caught this earlier ;-(
> 
> It's my own fault really -- my extremely ad-hoc approach
> to testing for Arm guests was bound to come back and
> bite me sooner or later.

Should we include the vfio fix in too for rc5?

  http://patchwork.ozlabs.org/patch/844940/

I see that the tag is there already, not sure whether it means it
missed the chance again...  Thanks,

-- 
Peter Xu
