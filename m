Received: from eggs.gnu.org ([209.51.188.92]:34961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gjlOB-0000Df-Gz
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:37:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gjlOA-0008ID-Jm
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:37:51 -0500
Received: from 3.mo1.mail-out.ovh.net ([46.105.60.232]:36423)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gjlOA-00080v-B0
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 08:37:50 -0500
Received: from player718.ha.ovh.net (unknown [10.109.143.201])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id 873B214EEFB
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 14:37:46 +0100 (CET)
Date: Wed, 16 Jan 2019 14:37:41 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190116143741.0cc91a8f@bahia.lan>
In-Reply-To: <alpine.BSF.2.21.9999.1901161259260.16452@zero.eik.bme.hu>
References: <20190116041916.130523-1-aik@ozlabs.ru>
	<511a675b-fa61-1ef0-643f-9c568b5daaa8@linaro.org>
	<alpine.BSF.2.21.9999.1901161259260.16452@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc]  [PATCH qemu] spapr: Fix fdt warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>

On Wed, 16 Jan 2019 13:01:46 +0100 (CET)
BALATON Zoltan <balaton@eik.bme.hu> wrote:

> On Wed, 16 Jan 2019, Richard Henderson wrote:
> > On 1/16/19 3:19 PM, Alexey Kardashevskiy wrote:  
> >> because TARGET_FMT_lx is defined as "%016"PRIx64.
> >>
> >> This uses simple "%lx" to suppress the warning. Since it is spapr which
> >> is always 64bit, we assume here that hwaddr is always "long".  
> >
> > This file is not solely for kvm, i.e. ppc64 hosts.  Thus this
> > is a bad assumption and will fail for a 32-bit host.
> >
> > You may want to use PRIx64 and assume hwaddr == uint64_t, or
> > also include an explicit cast to uint64_t.  
> 
> I don't know the context of this but there's HWADDR_PRIx as well so if you 
> want to print a hwaddr that's probably the one to use.
> 

Good suggestion, "%" HWADDR_PRIx does the job.

Cheers,

--
Greg

> Regards,
> BALATON Zoltan
> 
