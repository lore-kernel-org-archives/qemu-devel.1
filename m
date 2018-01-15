Received: from eggs.gnu.org ([2001:4830:134:3::10]:38407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eb2aV-0001aV-Ei
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:06:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eb2aR-0007Qy-CP
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:05:59 -0500
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:37519)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eb2aR-0007Qb-58
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:05:55 -0500
Received: from player714.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 578D795353
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 12:05:53 +0100 (CET)
Date: Mon, 15 Jan 2018 12:05:43 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180115120543.1f825292@bahia.lan>
In-Reply-To: <1516008655-31732-1-git-send-email-thuth@redhat.com>
References: <1516008655-31732-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Murilo Opsfelder =?UTF-8?B?QXJhw7pqbw==?= <muriloo@linux.vnet.ibm.com>

On Mon, 15 Jan 2018 10:30:53 +0100
Thomas Huth <thuth@redhat.com> wrote:

> ppc64-softmmu is a superset of ppc-softmmu which in turn is a superset

Hi Thomas,

Per curiosity. I understand that a 64-bit ppc CPU is expected to support
32-bit ppc code, but does QEMU really need to emulate setups that likely
never existed in real life (like a PowerMac G5 or a pSeries with an
internal floppy disk controller for example) ?

I ask because Murilo and I had a chat about removing CONFIG_FDC from
default-configs/ppc64-softmmu.mak the other day :)

Cheers,

--
Greg

> of ppcemb-softmmu. But since the config files are currently independent
> from each other, we missed to define some CONFIG switches in the super-
> sets: CONFIG_SUNGEM is missing from the ppc64-softmmu config, and the
> CONFIG_IDE_SII3112 switch is only defined in ppcemb-softmmu.
> 
> Let's fix this by including the subsets instead of duplicating all the
> switches all over the place.
> 
> (off-topic question: Do we still need a separate ppcemb-softmmu nowadays?
> It seemed to be useful 10 years ago when everybody was doing KVM on
> embedded PPC, but these days seem to be pretty much over now, so IMHO
> just using ppc-softmmu for embedded should be enough nowadays? We could
> save quite some compilation- and "make check"-time if we could finally get
> rid of ppcemb-softmmu again...)
> 
> Thomas Huth (2):
>   default-configs/ppc64-softmmu: Include 32-bit configs instead of
>     copying them
>   default-configs/ppc-softmmu: Restructure the switches according to the
>     machines
> 
>  default-configs/ppc-softmmu.mak   | 59 +++++++++++++++----------------------
>  default-configs/ppc64-softmmu.mak | 61 +++++----------------------------------
>  2 files changed, 32 insertions(+), 88 deletions(-)
> 
