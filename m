Received: from eggs.gnu.org ([2001:4830:134:3::10]:52895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dkReB-0001Tq-Sb
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 05:08:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dkRe6-0005I8-Tn
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 05:08:23 -0400
Date: Wed, 23 Aug 2017 11:08:16 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20170823022833.GK5379@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1708231104210.76247@zero.eik.bme.hu>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<f34dbaefd1224bca33a9052107cd32b628400106.1503249785.git.balaton@eik.bme.hu>
	<20170823022833.GK5379@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] [PATCH 11/15] ppc: Add 460EX embedded CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>

On Wed, 23 Aug 2017, David Gibson wrote:
> On Sun, Aug 20, 2017 at 07:23:05PM +0200, BALATON Zoltan wrote:
>> Despite its name it is a 440 core CPU
>
> As I recall 460 was supposed to be a 440 with SMP support.  Except
> they screwed up the cache coherence, so it's basically unusable for
> SMP (at least with Linux).  They finally got 440 SMP right in 470
> IIRC.
>
> Or are you saying that the 460EX is more 440 like than other 460 cpus?

AFAIK this SoC really has a 440 core with some of the embedded devices 
(such as PCIe and SDRAM controller) similar to real 460 core SoCs, so its 
name is a bit misleading. It definitely does not have a 460 CPU core so 
it's more like 440 than other 460 core SoCs.
