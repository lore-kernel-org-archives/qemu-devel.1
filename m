Received: from eggs.gnu.org ([2001:4830:134:3::10]:51222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fCB56-0007fT-MC
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 17:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fCB54-0005hv-9w
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 17:39:04 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:53729)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1fCB54-0005h6-3A
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 17:39:02 -0400
Date: Fri, 27 Apr 2018 23:38:44 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <CAFEAcA_ErkL21OvsXtHWX6k9wTM0DYv0eHOTio7aX=0YP1RTqg@mail.gmail.com>
Message-ID: <alpine.BSF.2.21.1804272336340.26364@zero.eik.bme.hu>
References: <20180306040154.3669-1-david@gibson.dropbear.id.au>
	<20180306040154.3669-4-david@gibson.dropbear.id.au>
	<CAFEAcA_ErkL21OvsXtHWX6k9wTM0DYv0eHOTio7aX=0YP1RTqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PULL 03/30] ppc440: Add emulation of plb-pcix
 controller found in some 440 SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, 27 Apr 2018, Peter Maydell wrote:
> On 6 March 2018 at 04:01, David Gibson <david@gibson.dropbear.id.au> wrote:
>> From: BALATON Zoltan <balaton@eik.bme.hu>
>>
>> This is the PCIX controller found in newer 440 core SoCs e.g. the
>> AMMC 460EX. The device tree refers to this as plb-pcix compared to
>> the plb-pci controller in older 440 SoCs.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> [dwg: Remove hwaddr from trace-events, that doesn't work with some
>>  trace backends]
>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>
>> +    case PCIX0_PIM2SAL:
>> +        s->pim[2].sa &= 0xffffffff00000000ULL;
>> +        s->pim[2].sa = val;
>> +        ppc440_pcix_update_pim(s, 2);
>> +        break;
>
> Coverity (CID1390577) points out that the "s->pim[2].sa = val;"
> overwrites the value set by the &= line, making it pointless.
> Should this be "|= val" like the other cases in this switch?

Yes this is a typo and I meant |= here like in other cases. I'll send a 
patch to correct this with the next batch of changes. Thanks for spotting 
it.

Regards,
BALATON Zoltan
