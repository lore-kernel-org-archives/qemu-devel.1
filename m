Received: from eggs.gnu.org ([2001:4830:134:3::10]:33147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVtZf-0002vf-68
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 03:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fVtZc-0006qY-4q
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 03:00:07 -0400
Date: Thu, 21 Jun 2018 09:00:02 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180620072506.GE24636@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1806210852360.16898@zero.eik.bme.hu>
References: <cover.1529398335.git.balaton@eik.bme.hu>
	<20180620072506.GE24636@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH v4 00/11] Misc sam460ex improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@suse.de>, Sebastian Bauer <mail@sebastianbauer.info>

Hello,

On Wed, 20 Jun 2018, David Gibson wrote:
> On Tue, Jun 19, 2018 at 10:52:15AM +0200, BALATON Zoltan wrote:
>> Next spin of sam460ex pathces with changes according to review and
>> some new patches.
>
> So, the sm501 patches I don't really have the technical knowledge to
> review, and I'm a little uncomfortable taking them through my tree,
> since they aren't strictly related to ppc.

OK, since the sm501 is also used on SH it's not PPC only so I think you 
can ignore them for now and just take the other patches and I can submit 
the sm501 related patches as a separate series (although all these changes 
are to improve sam460ex emulation).

> It looks like you're the only person that's made substantive changes
> to sm501 lately, though.  So, given I haven't heard screaming, I think
> it's fair to assume that either you know what you're doing, or you're
> the only person that cares about sm501 anyway.
>
> So, I think we should make you sm501 maintainer.

I don't feel confident enough to take on maintainership of this device but 
hope maybe Peter could help as he did before to get the patches in not 
involving your tree.

> Specifically I think you should:
>  * Fix the compile breakage I pointed out elsewhere

Thanks, I'll check and fix this.

>  * Split out your sm501 patches

OK, as above I'll send these as separate series, you can ignore all sm501: 
prefixed patches from this v4 series.

>  * Prepend a patch adding it to MAINTAINERS with yourself as
>    maintainer (whether you call it "Maintained" or "Odd Fixes" is up
>    to your level of dedication)
>  * Send this new series direct to Peter Maydell, CC me, Gerd Hoffman
>    <kraxel@redhat.com> and the SH maintainer(s) (as well as the lists
>    and whoever else you think's appropriate)
>  * I'll reply, making the case above to Peter for your
>    maintainership.
>
> With any luck, from there on you'll be able to send sm501 pull
> requests directly.

But if there's an other way I'd rather cc those people for review and to 
take care of pull requests without me becoming maintainer as I don't have 
any experience with that.

Regards,
BALATON Zoltan
