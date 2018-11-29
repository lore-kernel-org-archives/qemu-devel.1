Received: from eggs.gnu.org ([2001:4830:134:3::10]:33785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gSDBf-0002Ln-G5
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 22:40:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1gSDBc-0002Jv-8N
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 22:40:23 -0500
Message-ID: <39eb027df3340121ba9877e689e4d0a2747c5e43.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 29 Nov 2018 14:39:55 +1100
In-Reply-To: <20181129004718.GJ2251@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-9-clg@kaod.org>
	<20181127234956.GR2251@umbus.fritz.box>
	<c16b55c5-8144-82bc-37f7-70427c6460a4@kaod.org>
	<20181129004718.GJ2251@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 08/36] ppc/xive: introduce a simplified
 XIVE presenter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Thu, 2018-11-29 at 11:47 +1100, David Gibson wrote:
> 
> 1) read/write accessors which take a word number
> 
> 2) A "get" accessor which copies the whole structure, but "write"
> accessor which takes a word number.  The asymmetry is a bit ugly, but
> it's the non-atomic writeback of the whole structure which I'm most
> uncomfortable with.

It shouldn't be a big deal though, there are HW facilities to access
the structures "atomically" anyway, due to the caching done by the
XIVE.

> 3) A map/unmap interface which gives you / releases a pointer to the
> "live" structure.  For powernv that would become
> address_space_map()/unmap().  For PAPR it would just be reutn pointer
> / no-op.
