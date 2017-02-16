Received: from eggs.gnu.org ([2001:4830:134:3::10]:50820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ceN4G-0001i4-R3
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:29:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ceN4D-0006x1-Kw
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:29:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ceN4D-0006wV-Fa
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:29:53 -0500
Date: Thu, 16 Feb 2017 15:29:50 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170216152950.2d2de076@nial.brq.redhat.com>
In-Reply-To: <cover.1487224954.git.ben@skyportsystems.com>
References: <cover.1487224954.git.ben@skyportsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 0/8] Add support for VM Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: ben@skyportsystems.com
Cc: qemu-devel@nongnu.org, lersek@redhat.com, mst@redhat.com

On Wed, 15 Feb 2017 22:18:10 -0800
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
> v6->v7:
>     - Rebased to top of tree.
>     - Added 'src_offset' field to "write pointer" command
Ben,

Do you plan to post updated write pointer seabios impl.?
