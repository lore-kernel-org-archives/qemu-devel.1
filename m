Received: from eggs.gnu.org ([2001:4830:134:3::10]:34473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cWkC4-000748-Pw
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:34:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cWkC3-0001HI-Uw
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:34:28 -0500
References: <1476117341-32690-1-git-send-email-drjones@redhat.com>
	<1476117341-32690-3-git-send-email-drjones@redhat.com>
	<CAFEAcA92X+oCMji_bnWkjRWvqQ+CyqrR0ogy-SKOGW7TRYsZ3g@mail.gmail.com>
	<6442c7ab-a539-c1e2-bb54-23d4643bba65@redhat.com>
	<CAFEAcA-R3CBd4_g=83Gq2U0LK6qf0k-sxb3Kiu3GSv9AXqZH2A@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <ddd1f11a-3816-11fb-100b-356e7dbeb5e7@redhat.com>
Date: Thu, 26 Jan 2017 14:34:16 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-R3CBd4_g=83Gq2U0LK6qf0k-sxb3Kiu3GSv9AXqZH2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/virt: no ITS on older machine
 types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jones <drjones@redhat.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Peter,

On 26/01/2017 11:41, Peter Maydell wrote:
> On 26 January 2017 at 07:58, Auger Eric <eric.auger@redhat.com> wrote:
>> On 20/01/2017 16:52, Peter Maydell wrote:
>>> So this patch added a no_its flag which gets set for virt-2.7
>>> and earlier, but there's no user-facing way to say "I'd like
>>> a virt-2.8 board with no ITS", right? That's a bit unfortunate
>>> because the ITS can't be migrated, which means there's no way
>>> to ask for a post-2.7 virt board which can be migrated...
>>
>> Sorry for the delay.
>>
>> For 2.9 machine I can add a new property that would allow the user to
>> deselect the ITS. Would that make sense?
> 
> Maybe, but Christoffer pointed out to me that we can't do
> migration of the GICv3 yet anyway, so I was getting a bit
> ahead of myself -- non-migratable ITS doesn't break something
> that worked previously. So perhaps we're OK the way we are?
Yes indeed GICv3 migration is not yet upstreamed although under way. For
2.9 your concern still is relevant if ITS migration functionality does
not get supported in 2.9 along with GICv3 one. I will pay attention to this.

Thanks

Eric
> 
> thanks
> -- PMM
> 
