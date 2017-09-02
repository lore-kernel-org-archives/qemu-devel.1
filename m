Received: from eggs.gnu.org ([2001:4830:134:3::10]:47932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1do4Wq-0007d1-6z
	for qemu-devel@nongnu.org; Sat, 02 Sep 2017 05:15:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1do4Wl-0005Fw-CE
	for qemu-devel@nongnu.org; Sat, 02 Sep 2017 05:15:48 -0400
Date: Sat, 2 Sep 2017 11:15:20 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170902091520.bxecfhisvy46o4cb@aurel32.net>
References: <20170901110332.32650-1-otubo@redhat.com>
	<20170901143016.GK7570@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901143016.GK7570@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH] dma/i82374: avoid double creation of
 i82374 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, mst@redhat.com, pbonzini@redhat.com, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org

On 2017-09-01 11:30, Eduardo Habkost wrote:
> i82374 is compiled in only on ppc and sh4, so I'm CCing the
> maintainers for those architectures.

The i82374 device is not useful nor usable on SH4. It has just been
added in commit 85d3846a39 to be able to run the tests.

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
