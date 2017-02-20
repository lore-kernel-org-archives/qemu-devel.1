Received: from eggs.gnu.org ([2001:4830:134:3::10]:57723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cfpPb-0005V3-17
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1cfpPY-0007RD-IG
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:57:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1cfpPY-0007R5-CI
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 09:57:56 -0500
Date: Mon, 20 Feb 2017 15:57:52 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170220155752.32892bc3@nial.brq.redhat.com>
In-Reply-To: <cover.1487286467.git.ben@skyportsystems.com>
References: <cover.1487286467.git.ben@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v8 0/8] Add support for VM Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com
Cc: qemu-devel@nongnu.org, lersek@redhat.com, mst@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Kevin O'Connor <kevin@koconnor.net>

On Thu, 16 Feb 2017 15:15:32 -0800
ben@skyportsystems.com wrote:

> From: Ben Warren <ben@skyportsystems.com>
> 
> This patch set adds support for passing a GUID to Windows guests.  It is a
> re-implementation of previous patch sets written by Igor Mammedov et al, but
> this time passing the GUID data as a fw_cfg blob.
> 
> This patch set has dependencies on new guest functionality, in particular the
> support for a new linker-loader command and the ability to write back data
> to QEMU over a DMA link.  Work is in flight in both SeaBIOS and OVMF to support this.
> 
> v7->v8:
>     - Rebased to top of tree.
>     - Fixed two small bugs in "write pointer" function
>     - minor re-ordering of data in patches
>     - Fixed unit test by adding delays/retries to reading RSDP table
Michael,

series looks good for merging.
Patch
 [PATCH v8 7/8] tests: Add unit tests for the VM  Generation ID feature
needs updated seabios blob to make 'make check' happy
so we probably should merge/update seabios first
  [PATCH v5 0/5] QEMU: Add capability to write back fw_cfg address to QEMU

CCing Gerd and Kevin.
