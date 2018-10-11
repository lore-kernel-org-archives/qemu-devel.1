Received: from eggs.gnu.org ([2001:4830:134:3::10]:44379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gAdPv-0001NR-MK
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 12:02:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gAdPu-000597-TL
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 12:02:27 -0400
Date: Thu, 11 Oct 2018 18:02:17 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181011160217.GC23047@localhost.localdomain>
References: <20181011105802.22665-1-berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011105802.22665-1-berto@igalia.com>
Subject: Re: [Qemu-devel] [PATCH] qcow2: Get the request alignment for
 encrypted images from QCryptoBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>

Am 11.10.2018 um 12:58 hat Alberto Garcia geschrieben:
> This doesn't have any practical effect at the moment because the
> values of BDRV_SECTOR_SIZE, QCRYPTO_BLOCK_LUKS_SECTOR_SIZE and
> QCRYPTO_BLOCK_QCOW_SECTOR_SIZE are all the same (512 bytes), but
> future encryption methods could have different requirements.
> 
> Signed-off-by: Alberto Garcia <berto@igalia.com>

Thanks, applied to the block branch.

Kevin
