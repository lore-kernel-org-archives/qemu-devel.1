Received: from eggs.gnu.org ([2001:4830:134:3::10]:40622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ceT5O-0005P4-LZ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 15:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ceT5L-00048l-Ky
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 15:55:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ceT5L-00048T-Fy
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 15:55:27 -0500
References: <cover.1487224954.git.ben@skyportsystems.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <cae7d7f8-9075-1d00-e036-76476862e12f@redhat.com>
Date: Thu, 16 Feb 2017 21:55:24 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1487224954.git.ben@skyportsystems.com>
Content-Type: text/plain; charset=windows-1252
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
To: ben@skyportsystems.com, qemu-devel@nongnu.org
Cc: imammedo@redhat.com, mst@redhat.com

On 02/16/17 07:18, ben@skyportsystems.com wrote:
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
>     - Reworked unit tests based on feedback
>     - various minor changes based on feedback
>     - Added entries to MAINTAINERS file

I posted the OVMF series:

  [edk2] [PATCH 0/5] OvmfPkg: support QEMU_LOADER_WRITE_POINTER
  Message-Id: <20170216204137.30221-1-lersek@redhat.com>
  https://lists.01.org/pipermail/edk2-devel/2017-February/007454.html

Thanks,
Laszlo
